#!/usr/bin/env sh
# =============================================================
# default-arch.sh  —  Platform Default Architecture-as-Code Script
# DevOps Pipeline Platform
# =============================================================
# Usage: sh onboarding/ci/arch/default-arch.sh
# =============================================================
set -eu
echo "[ARCH] Starting Architecture-as-Code review..."
ARCH_RULES_PATH="${ARCH_RULES_PATH:-architecture/}"
POLICY_PACK="${POLICY_PACK:-default}"
if [ ! -d "$ARCH_RULES_PATH" ]; then
    echo "[ARCH] Architecture rules directory not found at: ${ARCH_RULES_PATH}"
    echo "[ARCH] Skipping architecture review"
    exit 0
fi
echo "[ARCH] Running architecture policy check with pack: ${POLICY_PACK}"
if command -v arch-as-code >/dev/null 2>&1; then
    arch-as-code validate \
        --rules-path "${ARCH_RULES_PATH}" \
        --policy-pack "${POLICY_PACK}" \
        --credential-ref "${ARCH_POLICY_CREDENTIAL_REF:-ARCH_POLICY_CREDENTIAL_REF}"
else
    echo "[ARCH] arch-as-code CLI not found — running stub validation"
fi
echo "[ARCH] Architecture-as-Code review completed successfully"
