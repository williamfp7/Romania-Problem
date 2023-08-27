sub notImplementedError{
    print("This is an abstract method\n");
    exit();
}

sub in{
    my $item=shift;
    my @list=@_;
    foreach my $obj (@list){
        return 1 if $obj == $item;
    }
    return 0;
}

sub distance{
    my ($x,$y)=@_;
    return (($x->[0]-$y->[0])*2+($x->[1]-$y->[1])*2)**-2;
}

1;