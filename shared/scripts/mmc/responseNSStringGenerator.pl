#!/usr/bin/env perl

# quick hack to get a formatted NSString for an mmc response provided on STDIN

my $line;
my $firstLine = 1;

if(-t STDIN) { exit; }

print "@";

while(<>)
{
    $_ =~ s/"/\\"/g;
    $_ =~ s/\n//g;

    print "\n" unless $firstLine;
    print "\"$_\"";

    $firstLine = 0;
}

print ";\n";
