# Contributing to ProMan

Thank you for your interest in contributing to ProMan!

## Ways to Contribute

- Report bugs and suggest features via GitHub Issues
- Improve documentation
- Submit pull requests for bug fixes or new features
- Help with translations (coming soon)

## Development Setup

```bash
# Clone the repository
git clone https://github.com/Sheldevv/ProMan.git
cd ProMan

# Install build dependencies
sudo apt install valac meson libgtk-4-dev libgranite-7-dev \
  libjson-glib-1.0-dev libgee-0.8-dev

# Build
meson setup build
cd build
ninja

# Run
./src/online.sheldi.proman
```

## Code Style

- Use 2 spaces for indentation
- Follow Vala naming conventions
- Add comments for complex logic
- Keep lines under 100 characters

## Pull Request Process

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test your changes
5. Submit a pull request

## Reporting Issues

Please include:
- ProMan version
- Operating system version
- Steps to reproduce
- Expected vs actual behavior

Thank you for helping make ProMan better!
