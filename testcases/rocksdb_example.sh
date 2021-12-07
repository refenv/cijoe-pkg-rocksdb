#!/bin/bash

CIJ_TEST_NAME=$(basename "${BASH_SOURCE[0]}")
export CIJ_TEST_NAME
# shellcheck source=modules/cijoe.sh
source "$CIJ_ROOT/modules/cijoe.sh"

test.enter

: "${ROCKSDB_DBBENCH_BIN:=db_bench}"
: "${ROCKSDB_BENCHMARKS:=fillseq,readrandom}"
: "${ROCKSDB_DISABLE_WAL:=true}"
: "${ROCKSDB_NUM_KV_PAIRS:=100000}"
: "${ROCKSDB_O_DIRECT:=false}"
: "${ROCKSDB_MULTIREAD_BATCHED:=true}"
: "${ROCKSDB_BATCH_SIZE:=16}"
: "${ROCKSDB_OUTPUT_FILE:=/tmp/rocksdb_output.txt}"

LOCAL_DBBENCH_OUTPUT_FILE="${CIJ_TEST_AUX_ROOT}/db_bench-$(basename $ROCKSDB_OUTPUT_FILE)"

cij.cmd "${ROCKSDB_DBBENCH_BIN} \
  -benchmarks=${ROCKSDB_BENCHMARKS} \
  -disable_wal=${ROCKSDB_DISABLE_WAL} \
  -num=${ROCKSDB_NUM_KV_PAIRS} \
  -use_direct_reads=${ROCKSDB_O_DIRECT} \
  -use_direct_io_for_flush_and_compaction=${ROCKSDB_O_DIRECT} \
  -multiread_batched=${ROCKSDB_MULTIREAD_BATCHED} \
  -batch_size=${ROCKSDB_BATCH_SIZE} 2>&1 | tee ${ROCKSDB_OUTPUT_FILE}"
RET=${?}
if [ ${RET} -ne 0 ] ; then
  cij.err "${ROCKSDB_DBBENCH_BIN} failed!"
  test.fail
fi

# Fetch the db_bench output file to local storage such that we can
# extract data from it using cij_extractor
cij.pull ${ROCKSDB_OUTPUT_FILE} "${LOCAL_DBBENCH_OUTPUT_FILE}"

test.pass
