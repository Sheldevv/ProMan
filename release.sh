#!/bin/bash

VERSION="0.1.0"
REPO="Sheldevv/ProMan"

echo "Building release v$VERSION"

# Clean and build
rm -rf build
meson setup build
cd build
ninja
cd ..

# Create tarball
git archive --format=tar.gz --output=proman-$VERSION.tar.gz --prefix=proman-$VERSION/ main

# Create GitHub release (requires gh CLI)
gh release create v$VERSION \
  --title "ProMan v$VERSION" \
  --notes "## Project Manager v$VERSION

### Features
- ✅ Add, edit, and delete projects
- ✅ Open projects in file manager/terminal
- ✅ Dark mode support
- ✅ Settings persistence
- ✅ Local JSON storage
- ✅ GTK4 + Granite 7 UI

### Installation
\`\`\`bash
# From source
git clone https://github.com/$REPO.git
cd ProMan
meson setup build
cd build
ninja
sudo ninja install

# Or download the tarball
tar -xzf proman-$VERSION.tar.gz
cd proman-$VERSION
meson setup build
cd build
ninja
sudo ninja install
\`\`\`

### Requirements
- GTK4 >= 4.0
- Granite >= 7.0
- Vala >= 0.56

### Links
- [GitHub Repository](https://github.com/$REPO)
- [Report Issues](https://github.com/$REPO/issues)" \
  proman-$VERSION.tar.gz

echo "Release v$VERSION created!"
