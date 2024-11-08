#!/usr/bin/perl
use strict;
use warnings;

sub compress_rle {
    my ($data) = @_;
    my @compressed;
    my $count = 1;
    for (my $i = 1; $i < length($data); $i++) {
        if (substr($data, $i, 1) eq substr($data, $i - 1, 1)) {
            $count++;
        } else {
            push @compressed, substr($data, $i - 1, 1) . $count;
            $count = 1;
        }
    }
    push @compressed, substr($data, -1, 1) . $count;
    return join('', @compressed);
}

sub decompress_rle {
    my ($compressed_data) = @_;
    my @decompressed;
    while ($compressed_data =~ /(.)(\d+)/g) {
        push @decompressed, $1 x $2;
    }
    return join('', @decompressed);
}

my $action = shift @ARGV;
my $input_file = shift @ARGV;
my $output_file = shift @ARGV;

if ($action eq 'compress') {
    open my $in, '<', $input_file or die "Cannot open $input_file: $!";
    my $data = do { local $/; <$in> };
    close $in;

    my $compressed_data = compress_rle($data);

    open my $out, '>', $output_file or die "Cannot open $output_file: $!";
    print $out $compressed_data;
    close $out;

    print "File compressed successfully!\n";
} elsif ($action eq 'decompress') {
    open my $in, '<', $input_file or die "Cannot open $input_file: $!";
    my $compressed_data = do { local $/; <$in> };
    close $in;

    my $data = decompress_rle($compressed_data);

    open my $out, '>', $output_file or die "Cannot open $output_file: $!";
    print $out $data;
    close $out;

    print "File decompressed successfully!\n";
} else {
    die "Unknown action: $action\nUsage: compress_rle.pl [compress|decompress] input_file output_file\n";
}

