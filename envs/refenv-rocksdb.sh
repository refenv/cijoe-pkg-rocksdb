#!/usr/bin/env bash

# CIJOE: SSH_* environment variables; setup to SSH into qemu-guest running on localhost
: "${SSH_HOST:=localhost}"; export SSH_HOST
: "${SSH_PORT:=$QEMU_GUEST_SSH_FWD_PORT}"; export SSH_PORT
: "${SSH_USER:=root}"; export SSH_USER
: "${SSH_NO_CHECKS:=1}"; export SSH_NO_CHECKS

#
# rocksdb environment variables
# The following variables are used to control the workload run by RocksDB.
# All variables are prefixed with `ROCKSDB_` and then contains the name of
# the RocksDB option where possible. Some places the name has been expaded
# to make it more clear what it means.
#
# These options aren't documented very well in RocksDB in general. The
# easiest way to get information about them is to look at the source:
# https://github.com/facebook/rocksdb/blob/main/tools/db_bench_tool.cc#L110
#
# The following is the exact mapping between env names and rocksdb options:
#
# rocksdb binary path: ${ROCKSDB_DBBENCH_BIN}
# -benchmarks=${ROCKSDB_BENCHMARKS}
# -disable_wal=${ROCKSDB_DISABLE_WAL}
# -num=${ROCKSDB_NUM_KV_PAIRS}
# -use_direct_reads=${ROCKSDB_O_DIRECT}
# -use_direct_io_for_flush_and_compaction=${ROCKSDB_O_DIRECT}  # this mapping is not an error
# -multiread_batched=${ROCKSDB_MULTIREAD_BATCHED}
# -batch_size=${ROCKSDB_BATCH_SIZE}


: "${ROCKSDB_DBBENCH_BIN:=db_bench}"
: "${ROCKSDB_BENCHMARKS:=fillseq,readrandom}"
: "${ROCKSDB_DISABLE_WAL:=true}"
: "${ROCKSDB_NUM_KV_PAIRS:=100000}"
: "${ROCKSDB_O_DIRECT:=false}"
: "${ROCKSDB_MULTIREAD_BATCHED:=true}"
: "${ROCKSDB_BATCH_SIZE:=16}"
: "${ROCKSDB_OUTPUT_FILE:=/tmp/rocksdb_output.txt}"
