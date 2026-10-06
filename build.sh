#!/bin/bash
set -e

echo "=== Setting up Flutter for Vercel Deployment ==="

# Clone Flutter stable branch if not present
if [ ! -d "flutter" ]; then
  echo "Cloning Flutter SDK..."
  git clone https://github.com/flutter/flutter.git --depth 1 -b stable flutter
fi

export PATH="$PATH:`pwd`/flutter/bin"

echo "=== Verifying Flutter installation ==="
flutter doctor

echo "=== Building Flutter Web Release ==="
flutter config --enable-web
flutter pub get
flutter build web --release --no-tree-shake-icons

echo "=== Build Completed Successfully ==="
