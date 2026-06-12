#!/usr/bin/env sh
# default-test.sh — Platform Default CI Test Script
# Usage: sh onboarding/ci/test/default-test.sh
set -eu
echo "[TEST] Starting default test stage"
if [ -f "pom.xml" ]; then
    echo "[TEST] Detected Maven project"
    mvn test --no-transfer-progress
elif [ -f "build.gradle" ] || [ -f "build.gradle.kts" ]; then
    echo "[TEST] Detected Gradle project"
    ./gradlew test
elif [ -f "package.json" ]; then
    echo "[TEST] Detected Node.js project"
    npm test
elif [ -f "requirements.txt" ] || [ -f "pyproject.toml" ]; then
    echo "[TEST] Detected Python project"
    pytest --tb=short
elif [ -f "go.mod" ]; then
    echo "[TEST] Detected Go project"
    go test ./...
else
    make test || echo "[TEST] No Makefile target 'test' found, skipping"
fi
echo "[TEST] Default test stage completed successfully"
