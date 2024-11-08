# Makefile for kzip2 utility

.PHONY: all clean setup

all: kzip2

kzip2: kzip2.sh compress_rle.pl check_kzip2.pl
	cp kzip2.sh kzip2
	chmod +x kzip2

setup: setup.sh
	./setup.sh

clean:
	rm -f kzip2
	find . -type f -name "*.kzip2" -exec rm -f {} +
