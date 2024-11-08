import bz2
import sys
import os

def compress_file(input_file, output_file):
    with open(input_file, 'rb') as file_in:
        data = file_in.read()
        compressed_data = bz2.compress(data, compresslevel=9)

    with open(output_file, 'wb') as file_out:
        file_out.write(compressed_data)

def decompress_file(input_file, output_file):
    with open(input_file, 'rb') as file_in:
        compressed_data = file_in.read()
        data = bz2.decompress(compressed_data)

    with open(output_file, 'wb') as file_out:
        file_out.write(data)

if __name__ == '__main__':
    if len(sys.argv) != 3:
        print('Usage: python kzip2.py [compress|decompress] input_file')
        sys.exit(1)

    action = sys.argv[1]
    input_file = sys.argv[2]

    if action == 'compress':
        output_file = input_file + '.kzip2'
        compress_file(input_file, output_file)
    elif action == 'decompress':
        if not input_file.endswith('.kzip2'):
            print('Error: Input file must have .kzip2 extension')
            sys.exit(1)
        output_file = input_file[:-6]  # Remove the .kzip2 extension
        decompress_file(input_file, output_file)
    else:
        print('Invalid action. Use "compress" or "decompress".')
        sys.exit(1)
