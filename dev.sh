#!/usr/bin/env bash

set -e

# Ensure we are in the project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "Building and installing for development..."

# 1. Build and Install to ~/.local
BUILD_DIR="$SCRIPT_DIR/build"
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"
cmake .. \
    -DCMAKE_INSTALL_PREFIX="$HOME/.local" \
    -DCMAKE_BUILD_TYPE=Debug \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=OFF
cmake --build . --parallel "$(nproc)"
cmake --install .
cd "$SCRIPT_DIR"

# 2. Set up environment
if [ -f "$BUILD_DIR/prefix.sh" ]; then
    source "$BUILD_DIR/prefix.sh"
fi

# 3. Run in plasmoidviewer
echo "Starting plasmoidviewer..."
# We use the package directory to ensure it loads the local version
plasmoidviewer -a package/
