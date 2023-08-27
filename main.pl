#!/usr/bin/perl
use warnings;
use strict;
use lib './';
use FIFOQueue;
use Stack;
use Graph;
use GraphProblem;
use Node;
use static;

sub tree_search{
    my ($problem, $frontier)=@_;
    $frontier->add(Node->new(state=>$problem->getInitial()));
    my $iter=0;
    while($frontier->len()){
        my $node = $frontier->remove();
        print("current node: ".$node->getState(),"\n");
        $iter++;
        if($problem->goal_test($node->getState())){
            return $node;
        }
        print("$iter\n");
        $frontier->extend($node->expand($problem));
    }
    return "";
}
sub in{
    my $item=shift;
    my @list=@_;
    foreach my $obj (@list){
        return 1 if $obj eq $item;
    }
    return 0;
}
sub graph_search{
    my ($problem, $frontier)=@_;
    my @explored=();
    $frontier->add(Node->new(state=>$problem->getInitial()));
    my $iter=0;
    while($frontier->len()){
        my $node = $frontier->remove();
        #print("current node: ".$node->getState(),"\n");
        $iter++;
        if($problem->goal_test($node->getState())){
            return $node;
        }
        push(@explored,$node->getState());
        #print("$iter\n");
        foreach ($node->expand($problem)){
           # print($_->getState());
            if(!in($_->getState(),@explored) or !$frontier->contains($_)){
                $frontier->add($_);
                #print $_->getState()," adicionado\t",in($_->getState(),@explored),"\n";
            }else{
                #print $_->getState()," não adicionado\t",in($_->getState(),@explored),"\n";
            }
        }
    }
    return "";
}

sub breadth_first_tree_search{
    my ($problem)=@_;
    #Search the shallowest nodes in the search tree first.
    return tree_search($problem, FIFOQueue->new());
}

sub depth_first_tree_search{
    my ($problem)=@_;
    #Search the shallowest nodes in the search tree first.
    return graph_search($problem, Stack->new());
}

my $romania_map = Graph->new(
    directed=>0,
    hash=>{
        Arad=>{Zerind=>75, Sibiu=>140, Timisoara=>118},
        Bucharest=>{Urziceni=>85, Pitesti=>101, Giurgiu=>90, Fagaras=>211},
        Craiova=>{Drobeta=>120, Rimnicu=>146, Pitesti=>138},
        Drobeta=>{Mehadia=>75},
        Eforie=>{Hirsova=>86},
        Fagaras=>{Sibiu=>99},
        Hirsova=>{Urziceni=>98},
        Iasi=>{Vaslui=>92, Neamt=>87},
        Lugoj=>{Timisoara=>111, Mehadia=>70},
        Oradea=>{Zerind=>71, Sibiu=>151},
        Pitesti=>{Rimnicu=>97},
        Rimnicu=>{Sibiu=>80},
        Urziceni=>{Vaslui=>142}
    }
);

$romania_map->setLocations(
    {
        Arad=>[91, 492], Bucharest=>[400, 327], Craiova=>[253, 288],
        Drobeta=>[165, 299], Eforie=>[562, 293], Fagaras=>[305, 449],
        Giurgiu=>[375, 270], Hirsova=>[534, 350], Iasi=>[473, 506],
        Lugoj=>[165, 379], Mehadia=>[168, 339], Neamt=>[406, 537],
        Oradea=>[131, 571], Pitesti=>[320, 368], Rimnicu=>[233, 410],
        Sibiu=>[207, 457], Timisoara=>[94, 410], Urziceni=>[456, 350],
        Vaslui=>[509, 444], Zerind=>[108, 531]    
    }
);

my $romania_problem = GraphProblem->new(
    initial=>'Arad', 
    goal=>'Neamt', 
    graph=>$romania_map
);

my $a=depth_first_tree_search($romania_problem);
my @path=$a->path();
for(my $i=0;$i<@path;$i++){
    print $path[$i]->getState();
    if($i<@path-1){
        print " -> ";
    }else{
        print "\n";
    }
}