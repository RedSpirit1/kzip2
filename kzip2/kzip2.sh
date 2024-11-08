#!/bin/bash

# Check for utility issues
perl check_kzip2.pl

if [ $? -ne 0 ]; then
    echo "Errors found in the utility. Please fix them before proceeding."
    exit 1
fi

if [ "$1" == "--compress" ]; then
    if [ -d "$2" ]; then
        echo "Compressing folder: $2"
        tar -cf - "$2" | gzip -c > "$2.kzip2"
    else
        echo "Compressing file: $2"
        python kzip2.py compress "$2"
    fi
elif [ "$1" == "--decompress" ]; then
    if [ "${2: -6}" == ".kzip2" ]; then
        if file "$2" | grep -q "gzip compressed"; then
            echo "Decompressing folder archive: $2"
            gunzip -c "$2" | tar -xf -
        else
            echo "Decompressing file: $2"
            python kzip2.py decompress "$2"
        fi
    else
        echo "Error: Input file must have .kzip2 extension"
        exit 1
    fi
else
    echo "Usage: kzip2 --compress <file/folder> or kzip2 --decompress <file>"
    exit 1
fi
