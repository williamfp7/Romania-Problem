#!/usr/bin/perl
use warnings;
use strict;

my $sx=memoize(\&fib);

sub fib{
    my ($n)=@_;
    if ($n == 0){
        return 0;
    }elsif($n == 1){
        return 1;
    }else{
        return $sx->($n-1) + $sx->($n-2);
    }
}


sub memoize{
    my ($f)=@_;
    my $memo={};
    sub helper{
        my ($x)=@_;
        if(!defined($memo->{$x})){
            #print "undefined for $x\n";
            $memo->{$x}=$f->($x);
        }else{
            #print "defined for $x\n";
        }
        return $memo->{$x};
    }
    return \&helper;
}



print($sx->(40));