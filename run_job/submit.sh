#!/bin/bash
# Usage: ./submit.sh run_lstr.pbs
# Run this from ~/hpc_run/run_job/ instead of calling qsub directly.

PBS_SCRIPT=${1:-run_lstr.pbs}
HPC_RUN_DIR=~/hpc_run

# ── Create dated log directory (one per DAY) ─────────────────────────────────
RUN_DATE=$(date +"%Y-%m-%d")
LOG_DIR="${HPC_RUN_DIR}/logs/${RUN_DATE}"
mkdir -p "$LOG_DIR"

echo "Created (or reusing) log directory: $LOG_DIR"

# ── Submit job, redirecting .o output into the dated folder ──────────────────
JOB_ID=$(qsub -o "$LOG_DIR/" "$PBS_SCRIPT")
echo "Submitted job $JOB_ID → logs in $LOG_DIR"