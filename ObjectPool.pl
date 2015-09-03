#**********************************
package AbstractCreation;

sub Create {
    my	( $self )	= @_;
    return;
} ## --- end sub Construct

#**********************************
package ObjectPool;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    $self->{instanceCount} = 0;
    $self->{pool} = [];
    $self->{semaphore} = Thread::Semaphore->new(0);
    return $self;
} ## --- end sub new

#my $_semaphore = undef;
#my $_pool = [];
#my $_creator = undef;
#my $_instanceCount = undef;
#my $_maxInstances = undef;

sub Size {
    my	( $self )	= @_;
    {
    lock( $self );
        return scalar @{$self->{pool}};
    }
} ## --- end sub Size

sub InstanceCount {
    my	( $self )	= @_;
    return $self->{instanceCount};
} ## --- end sub InstanceCount

sub MaxInstances {
    $_[0]->{maxInstances} = $_[1] if defined $_[1]; return $_[0]->{maxInstances};    
} ## --- end sub MaxInstances





#**********************************



#!/usr/bin/perl -w
use strict;
use warnings;
use Thread::Semaphore;
use Data::Dumper;
use Benchmark;

my $t0 = new Benchmark;

#open my $input, "/home/fanatic/Summoner/Codeeval-solutions/input.txt" || die "Can't open file: $!\n";
#open my $result, ">D:\\Perl\\output1.txt" || die "Can't open file: $!\n";

my $director = Director->new();
my $builder1 = ConcreteBuilder1->new();
my $builder2 = ConcreteBuilder2->new();

$director->Construct( $builder1 );
my $product1 = $builder1->GetResult();
$product1->Show();

$director->Construct( $builder2 );
my $product2 = $builder2->GetResult();
$product2->Show();

my $t1 = new Benchmark;
my $td = timediff($t1, $t0);
print "the code took:",timestr($td),"\n";
