#!/bin/bash
# Usage: ./submit.sh <job>.pbs [RPID]
#   ./submit.sh run_ek100.pbs                 # no RPID (transition period)
#   ./submit.sh run_ek100.pbs ABCDEF1234      # with your project RPID
# Run from ~/hpc_run/run_job/. Creates the dated log dir, then submits.

PBS_SCRIPT=${1:-run_lstr.pbs}
RPID=${2:-}
HPC_RUN_DIR=~/hpc_run

# ── Create dated log directory (one per DAY) ─────────────────────────────────
RUN_DATE=$(date +"%Y-%m-%d")
LOG_DIR="${HPC_RUN_DIR}/logs/${RUN_DATE}"
mkdir -p "$LOG_DIR"
echo "Log directory: $LOG_DIR"

# ── Submit (add -P only if an RPID was given) ────────────────────────────────
if [ -n "$RPID" ]; then
    JOB_ID=$(qsub -P "$RPID" -o "$LOG_DIR/" "$PBS_SCRIPT")
else
    JOB_ID=$(qsub -o "$LOG_DIR/" "$PBS_SCRIPT")
fi

echo "Submitted $JOB_ID"
echo "  PBS console log : $LOG_DIR/"
echo "  Full output + errors (EK100 jobs tee here): ~/TeSTra/joblogs/"
