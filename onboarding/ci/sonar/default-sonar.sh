#!/usr/bin/env sh
# =============================================================
# default-sonar.sh  —  Platform Default SonarQube Analysis Script
# DevOps Pipeline Platform
# =============================================================
# Usage: sh onboarding/ci/sonar/default-sonar.sh
# =============================================================
set -eu
echo "[SONAR] Starting SonarQube analysis..."
if [ -z "${SONAR_TOKEN:-}" ]; then
    echo "[SONAR] SONAR_TOKEN not set — skipping SonarQube analysis"
    exit 0
fi
if [ -f "pom.xml" ]; then
    echo "[SONAR] Detected Maven project"
    mvn sonar:sonar \
        -Dsonar.host.url="${SONAR_HOST_URL:-https://sonar.npci.org.in}" \
        -Dsonar.login="${SONAR_TOKEN}" \
        --no-transfer-progress
elif [ -f "build.gradle" ] || [ -f "build.gradle.kts" ]; then
    echo "[SONAR] Detected Gradle project"
    ./gradlew sonarqube \
        -Dsonar.host.url="${SONAR_HOST_URL:-https://sonar.npci.org.in}" \
        -Dsonar.login="${SONAR_TOKEN}"
else
    echo "[SONAR] Running generic Sonar scanner"
    sonar-scanner \
        -Dsonar.host.url="${SONAR_HOST_URL:-https://sonar.npci.org.in}" \
        -Dsonar.login="${SONAR_TOKEN}"
fi
echo "[SONAR] SonarQube analysis completed successfully"
