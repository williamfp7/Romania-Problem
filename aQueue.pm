#!/usr/bin/perl
use warnings;
use strict;
use lib './';
use static;

package aQueue;
use parent 'Object';

sub setStart{
    my $self=shift;
    $self->{start}=shift;
}
sub getStart{
    my $self=shift;
    return $self->{start};
}

sub setArray{
    my $self=shift;
    $self->{array}=shift;
}
sub getArray{
    my $self=shift;
    return @{$self->{array}};
}

sub len{
    my $self=shift;
    return scalar($self->getArray())-$self->getStart();
}

sub append{
    my $self=shift;
    main::notImplementedError();
}

sub extend{
    my $self=shift;
    my @itens=@_;
    foreach (@itens){
        $self->append($_);
    }
}

sub contains{
    my $self=shift;
    my $item=shift;
    my @a=$self->getArray();
    for(my $i=$self->getStart();$i<$self->len();$i++){
        if($a[$i] eq $item){
            return 1;
        }
    }
    return 0;
}

1;