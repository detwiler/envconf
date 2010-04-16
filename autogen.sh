#! /bin/sh

echo
echo "Generating ChangeLog..."

git2cl >|ChangeLog

echo
echo "Running autoreconf..."
echo

autoreconf --verbose --install --force
