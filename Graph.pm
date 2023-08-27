use lib './';

package Graph;
use parent 'Object';

sub setHash{
    my $self=shift;
    $self->{hash}=shift;
}
sub getHash{
    my $self=shift;
    return $self->{hash};
}

sub setDirected{
    my $self=shift;
    $self->{directed}=shift;
}
sub getDirected{
    my $self=shift;
    return $self->{directed};
}

sub setLocations{
    my $self=shift;
    $self->{locations}=shift;
}
sub getLocations{
    my $self=shift;
    return $self->{locations};
}

sub new{
    my $class=shift;
    my $self=$class->SUPER::new(@_);
    $self->setDirected($self->{directed});
    $self->setHash($self->{hash});
    if(!$self->getDirected()){
        $self->make_undirected();
    }
    return $self;
}

#Make a digraph into an undirected graph by adding symmetric edges.
sub make_undirected{
    my $self=shift;
    foreach $a (keys %{$self->getHash()}){
        foreach $b (keys %{$self->getHash()->{$a}}){
            $self->connect1($b,$a,$self->getHash()->{$a}->{$b});
        }
    }
}

sub connect{
    my $self=shift;
    my ($A,$B,$distance)=@_;
    $self->connect1($A,$B,$distance);
    if(!$self->getDirected()){
        $self->connect1($B,$A,$distance);
    }
}
#Add a link from A to B of given distance, in one direction only.
sub connect1{
    my $self=shift;
    my ($A,$B,$distance)=@_;
    my $hash=$self->setHashDefault($A);
    $hash->{$A}->{$B}=$distance;
    $self->setHash($hash);
}

sub get{
    my $self=shift;
    my ($a,$b)=@_;
    my $links=$self->setHashDefault($a);
    if (!defined($b)){
        return $links->{$a};
    }else{
        return $links->{$a}->{$b};
    }
}

sub nodes{
    my $self=shift;
    return keys %{$self->getHash()};
}

sub setHashDefault{
    my $self=shift;
    my $a=shift;
    my $hash=$self->getHash();
    $hash->{$a} = {} if !exists($hash->{$a});
    $self->setHash($hash);
    return $self->getHash();
}

1;