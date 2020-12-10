#!/usr/bin/gawk -f
#
# Usage: generate_table.sh < ${board}.txt
#
# Takes the file generated by collect.sh and generates an ASCII
# table that can be inserted into the README.md.

BEGIN {
  NUM_ACE_CRC_ALGORITHMS = 9
  NUM_ALGORITHMS = 12
  labels[1] = "crc8_bit";
  labels[2] = "crc8_nibble";
  labels[3] = "crc8_byte";
  labels[4] = "crc16ccitt_bit";
  labels[5] = "crc16ccitt_nibble";
  labels[6] = "crc16ccitt_byte";
  labels[7] = "crc32_bit";
  labels[8] = "crc32_nibble";
  labels[9] = "crc32_byte";
  labels[10] = "CRC32";
  labels[11] = "Arduino_CRC32";
  labels[12] = "FastCRC32";

  # Use 1-based index for better compatibility with MemoryBenchmark which has a
  # "Baseline" record.
  record_index = 1
}
!/^END/ {
  u[record_index]["name"] = $1
  u[record_index]["micros"] = $6
  record_index++
}
END {
  printf("+-----------------------------------------------+\n")
  printf("| CRC algorithm                   |  micros/kiB |\n")
  printf("|---------------------------------+-------------|\n")
  for (i = 1; i <= NUM_ACE_CRC_ALGORITHMS; i++) {
    printf("| %-31s | %11d |\n", labels[i], u[i]["micros"])
  }
  printf("|---------------------------------+-------------|\n")
  for (i = NUM_ACE_CRC_ALGORITHMS + 1; i <= NUM_ALGORITHMS; i++) {
    printf("| %-31s | %11d |\n", labels[i], u[i]["micros"])
  }
  printf("+---------------------------------+-------------+\n")
}