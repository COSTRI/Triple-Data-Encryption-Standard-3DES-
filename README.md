# Triple DES (TDES) Key-on-the-Fly Hardware Pipeline

A structural SystemVerilog implementation of an optimized, high-throughput Triple DES (TDES) crypto-engine primitive. This core bypasses heavy storage overhead by executing **Key-on-the-Fly** generation—dynamically scheduling, shifting, and presenting 48-bit subkeys ($K_{round}$) directly to the round networks in real-time.

## 📌 Subsystem Architecture

The key scheduler processes a full 192-bit master key payload and pipes it into separate operational data paths managed by a central controller loop:

1. **Key Encryption Scheduler (`KeyEncryption`):** Computes on-the-fly left-shift scheduling transformations for forward-DES blocks.
2. **Key Decryption Scheduler (`KeyDecryption`):** Computes on-the-fly right-shift transformations to invert subkey delivery during reverse-DES blocks.
3. **Dynamic Routing Multiplexer (`roundKey`):** Intercepts the current round status and selects between the active scheduler outputs to feed the core DES round network.

---

## 🔄 Block Sequences & Key Schedules

The execution control loop splits operation tracking across an automated block-counter sequence (`blockCount`) to perform standard Triple DES Encrypt-Decrypt-Encrypt (EDE) operations:

* **Phase 1: Block Count `2'd1` (First Encryption Block)**
  * **Key Map:** Extracts Key 1 ($K_1$) from the master array.
  * **Behavior:** Processes forward DES rounds using left shifts (`shiftAmt`).
* **Phase 2: Block Count `2'd0` (Second Decryption Block)**
  * **Key Map:** Switches key parameters to Key 2 ($K_2$).
  * **Behavior:** Inverts the subkey schedule using reverse right shifts for hardware decryption.
* **Phase 3: Block Count `2'd3` (Third Encryption Block)**
  * **Key Map:** Applies Key 3 ($K_3$).
  * **Behavior:** Executes the final forward encryption round sequence to produce the finalized `TDEScipher` word.

---

## 🚀 Simulation & Verification Trace

The runtime execution details can be fully simulated and evaluated using the standalone `testDES_TOP.sv` verification harness.

### Hardcoded Test Vector Configuration
* **Master 192-bit Key String:** `192'h0f1571c947d9e8590f1571c947d9e8590f1571c947d9e859`
* **64-bit Input Plaintext (`DESin`):** `64'h02468aceeca86420`

### Expected Verification Output Logs
When executing a simulation run, the console monitors intermediate block completions and key transitions:

```
key[0f1571c947d9e8590f1571c947d9e8590f1571c947d9e859] 
 DESin[02468aceeca86420]

Selected Key [0f1571c947d9e859] 
Time 315000: FIRST BLOCK (K1) DONE. Switching to K2 (Decryption).

Selected Key [0f1571c947d9e859] 
Time 635000: SECOND BLOCK (K2) DONE. Switching to K3 (Encryption).

TDES out:   da02ce3a89ecac3b
Time 955000: ALL 48 ROUNDS COMPLETE.
Simulation Finished.
