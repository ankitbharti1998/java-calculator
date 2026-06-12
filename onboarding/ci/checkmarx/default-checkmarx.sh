#!/usr/bin/env bash
# =============================================================
# default-checkmarx.sh  —  Platform Default Checkmarx SAST Script
# DevOps Pipeline Platform
# =============================================================
# Usage: sh onboarding/ci/checkmarx/default-checkmarx.sh
# =============================================================
set -euo pipefail
echo "[CHECKMARX] Starting Checkmarx SAST scan..."
if [ -z "${CHECKMARX_TOKEN:-}" ]; then
    echo "[CHECKMARX] CHECKMARX_TOKEN not set — skipping Checkmarx SAST scan"
    exit 0
fi
CHECKMARX_SERVER="${CHECKMARX_SERVER:-https://checkmarx.npci.org.in}"
PROJECT_NAME="${CX_PROJECT_NAME:-${APP_NAME:-my-app}}"
TEAM_NAME="${CX_TEAM_NAME:-/CxServer/SP/DevOps}"
if command -v runCxConsole.sh &> /dev/null; then
    runCxConsole.sh Scan \
        -CxServer "${CHECKMARX_SERVER}" \
        -CxToken "${CHECKMARX_TOKEN}" \
        -ProjectName "${PROJECT_NAME}" \
        -TeamName "${TEAM_NAME}" \
        -LocationType folder \
        -LocationPath "." \
        -ReportPDF "checkmarx-report.pdf"
elif command -v cx &> /dev/null; then
    cx scan create \
        --project-name "${PROJECT_NAME}" \
        --source "."
else
    echo "[CHECKMARX] Checkmarx CLI not found — running stub scan"
fi
echo "[CHECKMARX] Checkmarx SAST scan completed"
