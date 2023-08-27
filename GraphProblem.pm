use lib './';

package GraphProblem;
use parent 'aProblem';

sub setGraph{
    my $self=shift;
    $self->{graph}=shift;
}
sub getGraph{
    my $self=shift;
    return $self->{graph};
}

sub new{
    my $class=shift;
    my $self=$class->SUPER::new(@_);
    $self->setGraph($self->{graph});
    return $self;
}

sub actions{
    my $self=shift;
    my $A=shift;
    my @tmp=sort keys %{$self->getGraph()->getHash()->{$A}};
    return @tmp;
}

sub result{
    my $self=shift;
    my ($state,$action)=@_;
    return $action;
}

sub pathCost{
    my $self=shift;
    my ($cost_so_far, $A, $action, $B)=@_;
    return $cost_so_far + ($self->getGraph()->get($A,$B) || inf);
}

sub h{
    my $self=shift;
    my $node=shift || die("argumento '\$node' não declarado");
    my $locations=$self->getGraph()->getLocations() || "";
    if ($locations){
        return int(main::distance($locations->{$node->getState()},$locations->{$self->getGoal()}));
    }else{
        return inf;
    }
}

1;