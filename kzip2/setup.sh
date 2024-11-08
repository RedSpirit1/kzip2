#!/bin/sh
# setup.sh

echo "Setting up kzip2 utility..."

# Install required packages
echo "Installing dependencies..."
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo apt update
    sudo apt install python3 perl make gzip -y
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install python perl make gzip
elif [[ "$OSTYPE" == "msys" ]]; then
    echo "Please install Python, Perl, Make, and Gzip manually on Windows."
else
    echo "Unsupported OS. Please install dependencies manually."
fi

echo "Dependencies installed."

# Run Makefile
echo "Building kzip2 utility..."
make

echo "Setup complete. You can now use the kzip2 utility."
