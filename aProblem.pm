use lib './';
use static;

package aProblem;
use parent 'Object';

sub setInitial{
    my $self=shift;
    $self->{initial}=shift;
}
sub getInitial{
    my $self=shift;
    return $self->{initial};
}

sub setGoal{
    my $self=shift;
    $self->{goal}=shift;
}
sub getGoal{
    my $self=shift;
    return $self->{goal};
}

sub new{
    my ($class,@args)=@_;
    $self=$class->SUPER::new(@args);
    $self->setInitial($self->{initial});
    $self->setGoal($self->{goal}) if defined($self->{goal});
    return $self;
}

sub goal_test{
    my $self=shift;
    my $state=shift;
    if (ref($self->getGoal()) eq "ARRAY"){
        return main::in($state,$self->getGoal());
    }else{
        return $state eq $self->getGoal();
    }
}

sub path_cost{
    my $self=shift;
    my ($c, $state1, $action, $state2)=@_;
    return $c+1;
}

sub actions{
    my $self=shift;
    main::notImplementedError();
}

sub result{
    my $self=shift;
    main::notImplementedError();
}

sub value{
    my $self=shift;
    main::notImplementedError();
}

1;