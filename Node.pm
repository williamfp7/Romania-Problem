use lib './';

package Node;
use parent 'Object';
use overload 
    fallback =>1,
    '==' => \&equals;

sub setState{
    my $self=shift;
    $self->{state}=shift;
}
sub getState{
    my $self=shift;
    return $self->{state};
}
sub setParent{
    my $self=shift;
    $self->{parent}=shift;
}
sub getParent{
    my $self=shift;
    return $self->{parent};
}
sub setAction{
    my $self=shift;
    $self->{action}=shift;
}
sub getAction{
    my $self=shift;
    return $self->{action};
}
sub setPathCost{
    my $self=shift;
    $self->{pathCost}=shift;
}
sub getPathCost{
    my $self=shift;
    return $self->{pathCost};
}
sub setDepth{
    my $self=shift;
    $self->{depth}=shift;
}
sub getDepth{
    my $self=shift;
    return $self->{depth};
}

sub new{
    my $class=shift;
    my $self=$class->SUPER::new(@_);
    $self->setState($self->{state});
    $self->setPathCost($self->{pathCost} || 0);
    $self->setAction($self->{action}) if defined($self->{action});
    $self->setParent($self->{parent}) if defined($self->{parent});
    if(defined($self->getParent())){
        $self->setDepth($self->getParent()->getDepth()+1);
    }else{
        $self->setDepth(0);
    }
    return $self;
}

sub lt{
    my ($self, $node)=@_;
    return $self->getState() < $node->getState();
} 

#List the nodes reachable in one step from this node.
sub expand{
    my ($self, $problem)=@_;
    my @list=();
    foreach my $action ($problem->actions($self->getState())){
        #print($action);
        push(@list,$self->childNode($problem,$action));
    }
    return @list;
}

sub childNode{
    my ($self,$problem,$action)=@_;
    my $next=$problem->result($self->getState(),$action);
    return Node->new(
        state=>$next,
        parent=>$self,
        action=>$action,
        pathCost=>$problem->pathCost(
            $self->getPathCost,
            $self->getState(),
            $self->getAction(),
            $next
        )
    );
}

#"Return the sequence of actions to go from the root to this node."
sub solution{
    my($self)=@_;
    my @list=();
    my @path=$self->path();
    for(my $i=1;$i<@path;$i++){
        push(@list,$path[$i]->getAction());
    }
    return @list;
}

#"Return a list of nodes forming the path from the root to this node."
sub path{
    my $self=shift;
    my @pathBack=();
    my $node=$self;
    while(defined($node)){
        unshift(@pathBack,$node);
        $node=$node->getParent();
    }
    return @pathBack;
}

sub equals{
    my $self=shift;
    my ($obj)=@_;
    #print("\n\t\t",$self->getState(), " -> ", $obj->getState(),"\n");
    return (ref($self) eq ref($obj)) and ($self->getState() eq $obj->getState());
}

1;