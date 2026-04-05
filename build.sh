#!/bin/bash

echo "Building Project Manager (ProMan)..."

# Check dependencies
echo "Checking dependencies..."
deps=("valac" "meson" "pkg-config")
missing=()

for dep in "${deps[@]}"; do
    if ! command -v $dep &> /dev/null; then
        missing+=($dep)
    fi
done

if [ ${#missing[@]} -ne 0 ]; then
    echo "Missing dependencies: ${missing[@]}"
    echo "Install with: sudo apt install ${missing[@]}"
    exit 1
fi

# Build
rm -rf build
meson setup build
cd build
ninja

echo ""
echo "Build complete!"
echo "Run with: ./src/online.sheldi.proman"
echo "Install with: sudo ninja install"
