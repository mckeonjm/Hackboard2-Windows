# Full header GPIO bench results

On November 22, 2026, the owner completed the guided tests on PCB PZ08C20045B0 using the temporary Windows ACPI table. The table summarizes the full batch. The targeted retest below records subsequent runs. The [raw bench log](header-test-results.txt) and [continuity map](Header-Continuity-Map.md) contain the observations and pad assignments.

## Scope and snapshot results

| Physical pins | Output and release | Input after release |
| --- | --- | --- |
| 7, 18, 19, 23, 29, 37, 38 | Both pulses and release observed | Snapshot agreed with the meter at both near 3 V and near 0 V. |
| 36 | Both pulses and release observed | Snapshot reported HIGH at 1.56 V with the pull-up and LOW near 0 V with the pull-down. The reduced pull-up voltage remains unexplained. |
| 21, 24, 31 | Both pulses and release observed | Earlier runs demonstrated both levels. The full run read HIGH for both biases on 21 and LOW for both on 24 and 31, even though the meter moved between near 3 V and near 0 V. |
| 3, 5 | Both pulses and return to biased baseline observed | With the 10 kΩ pull-down, both settled at about 1.7 V and still read HIGH. The passive test did not produce a clear LOW at the pad. |
| 8, 10 | Both pulses and release observed | Snapshot read HIGH for both biases despite measured near-rail voltages. |
| 11, 12, 13, 15, 16, 22, 26, 32, 33, 35 | Both pulses and release observed | Snapshot read LOW for both post-output biases despite measured near-rail voltages. Pin 35 did report HIGH in a separate post-pulse sample. |
| 40 | Both commands and releases returned `0x55`, with no physical pulse observed in either direction | The candidate bit switched during commanded drive, from set on high to clear on low. Passive bias moved the measured voltage, but both post-output samples read LOW. |
| 27, 28 | Passive voltage only | Approximately 0.68 V and 0.65 V, respectively. Controller and route remain unknown. |

The scope recorded both output directions and return to baseline on 25 contacts. All pulse commands in the completed batch returned `0x55` for drive and release. Every tested selector with a during-drive bitmap sample had its expected bit set during drive-high and clear during drive-low, including selector 40. Pin 31's method did not return during-drive bitmap data. Its physical pulses and earlier live input trace provide separate evidence.

### Targeted pin 7 and 31 retest

Both pins passed both scope pulses and release. After the pulses, both correctly reported HIGH at about 3 V with the pull-up and LOW near 0 V with the pull-down. Pin 31 also matched the meter on all three pre-pulse observations. Pin 7 had one pre-pulse mismatch: it measured near 3 V with the pull-up while the snapshot reported LOW. Pin 7 then read correctly under the same bias after the pulses, and pin 31's earlier full-batch mismatch did not recur. These observations confirm that the existing masks can report both levels, with a read discrepancy still observable within an individual run.

## Interpretation

### Input initialization on pins 7 and 11

The [input initialization log](input-initialization-results.txt) shows 48 post-request reads, all matching the meter on the first sample and the five repeats. Each pin read correctly at 3.0 V and 0 V before and after its explicit input-mode command. Both commands returned `0x55`. The pads' prior state was not independently reset between bench sessions, so this run does not establish their state after a cold power cycle.

On each bias transition, the first request's pre-request bitmap still held the previous level. The during-request and post-request bitmaps both reflected the new level. This directly demonstrates the need to request a fresh snapshot. It gives no measured improvement from explicit input configuration in this run, and the earlier one-shot mismatches did not reproduce.

The during-drive data support the selector-to-bitmap offset across the tested range. The post-release reads can disagree even on previously verified pins, while the measured voltage and during-drive bits still track the command. That makes the input mode or snapshot acquisition path a better first target than remapping individual bitmap bits. The current test uses one timed snapshot request without a completion indicator. The evidence does not isolate snapshot refresh from pad mode or input-buffer behavior.

Pins 3 and 5 warrant a separate electrical check. Their 1.7 V result under 10 kΩ loading is consistent with a pull-up or another bias path, and the EC did report LOW during active drive-low. This does not verify an I²C transaction, open-drain operation, or a passive input LOW.

On pin 40, firmware acceptance and a matching bitmap bit are insufficient to prove the package lead drove the header. The most direct follow-up is to compare the waveforms on header contact 40 and ITE lead 47 during the same pulse and verify the active mux if neither moves. Leave pin 40 out of the verified output set.

For input diagnosis, keep a known-good pad and an inconsistent pad at each measured voltage and capture several consecutive snapshots. Comparing pin 7 with previously verified pin 31 or pin 24 would show whether additional settled samples help. If the disagreement persists, investigate the input-mode and alternate-function control bits before exposing general-purpose reads.
