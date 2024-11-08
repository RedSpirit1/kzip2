#!/usr/bin/perl
use strict;
use warnings;
use File::Find;

# List of required files
my @required_files = qw(kzip2.py kzip2.sh compress_rle.pl Makefile);

# Directory to check for required files
my $base_dir = '.';

# Check for missing files
sub check_missing_files {
    my $missing = 0;
    foreach my $file (@required_files) {
        unless (-e "$base_dir/$file") {
            print "Error: Missing required file: $file\n";
            $missing = 1;
        }
    }
    return $missing;
}

# Check file permissions
sub check_file_permissions {
    my $permissions_issue = 0;
    find(sub {
        if (-f $_) {
            unless (-r $_) {
                print "Error: File $_ is not readable\n";
                $permissions_issue = 1;
            }
            unless (-w $_) {
                print "Error: File $_ is not writable\n";
                $permissions_issue = 1;
            }
        }
    }, $base_dir);
    return $permissions_issue;
}

# Main function
sub main {
    my $issues_found = 0;
    $issues_found += check_missing_files();
    $issues_found += check_file_permissions();

    if ($issues_found) {
        print "One or more issues were found in your kzip2 utility.\n";
    }
}

# Run the main function
main();
