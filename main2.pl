#!/usr/bin/perl
use warnings;
use strict;
use lib './';
use Node;

my %b=(
    a=>1, b=>2, c=>3, d=>4
);

for (my $i=0;$i<10;$i++){
    my @a=sort keys %b;
    foreach (@a){
        print $_," ";
    }
    print "\n";
}