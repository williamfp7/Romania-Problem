#!/usr/bin/perl
use warnings;
use strict;
use lib './';

package FIFOQueue;
use parent 'aOrderedCollection';



sub new{
    my ($class, @args) = @_;
    my $self = $class->SUPER::new(@args);
    $self->setStart(0);
    $self->setArray([]);
    return $self;
}

sub add{
    my $self=shift;
    my $item=shift;
    my @array=$self->getArray();
    push(@array,$item);
    $self->setArray(\@array);
}



sub remove{
    my $self=shift;
    my @a=$self->getArray();
    my $e=$a[$self->getStart()];
    $self->setStart($self->getStart()+1);
    return $e;
}

sub contains{
    my $self=shift;
    my $item=shift;
    my @a=$self->getArray();
    for(my $i=$self->getStart();$i<$self->len();$i++){
        if($item == $a[$i]){
            return 1;
        }
    }
    return 0;
}

1;
