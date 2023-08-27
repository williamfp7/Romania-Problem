#!/usr/bin/perl
use warnings;
use strict;
use lib './';
use static;

package aOrderedCollection;
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

sub add{
    my $self=shift;
    main::notImplementedError();
}

sub remove{
    my $self=shift;
    main::notImplementedError();
}

sub extend{
    my $self=shift;
    my @itens=@_;
    foreach (@itens){
        print("\tadding ".$_->getState()."\n");
        $self->add($_);
    }
}

sub contains{
    my $self=shift;
    main::notImplementedError();
}
1;