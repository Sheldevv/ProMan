#!/bin/bash

echo "Installing Project Manager (ProMan)..."

# Build if not already built
if [ ! -d "build" ]; then
    ./build.sh
fi

# Install
cd build
sudo ninja install

# Compile schemas
sudo glib-compile-schemas /usr/local/share/glib-2.0/schemas/

echo ""
echo "Installation complete!"
echo "You can now run 'online.sheldi.proman' from the terminal"
echo "or find it in your application menu."
