#!/usr/bin/env sh
# default-build.sh — Platform Default CI Build Script
# Usage: sh onboarding/ci/build/default-build.sh
set -eu
echo "[BUILD] Starting default build stage"
if [ -f "pom.xml" ]; then
    echo "[BUILD] Detected Maven project"
    mvn clean package -DskipTests --no-transfer-progress
elif [ -f "build.gradle" ] || [ -f "build.gradle.kts" ]; then
    echo "[BUILD] Detected Gradle project"
    ./gradlew build -x test
elif [ -f "package.json" ]; then
    echo "[BUILD] Detected Node.js project"
    npm install --ci && npm run build
elif [ -f "requirements.txt" ] || [ -f "pyproject.toml" ]; then
    echo "[BUILD] Detected Python project"
    pip install --upgrade pip && pip install -r requirements.txt && python -m build
elif [ -f "go.mod" ]; then
    echo "[BUILD] Detected Go project"
    go build ./...
else
    make build || echo "[BUILD] No Makefile target 'build' found, skipping"
fi
echo "[BUILD] Default build stage completed successfully"
