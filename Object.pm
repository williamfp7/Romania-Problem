#!/usr/bin/perl
use warnings;
use strict;

package Object;
use overload 
    fallback =>1,
    '==' => \&equals;
sub new{
    my $class=shift;
    my ($self)={@_};
    bless $self,$class;
    return $self;
}

sub toString{
    my $self=shift;
    return $self;
}

sub equals{
    print("equals do Object\n");
    my $self=shift;
    my ($obj)=@_;
    if($self eq $obj){
        return 1;
    }else{
        return 0;
    }
}
1;