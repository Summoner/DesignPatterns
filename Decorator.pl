#**********************************
package AbstractComponent;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub Operation {
    my	( $self )	= @_;
    return $self;
} ## --- end sub Operation

#**********************************
package ConcreteComponent;
use base AbstractComponent;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub Operation {
    my	( $self )	= @_;
    print "Concrete component Operation()\n";    
} ## --- end sub Operation

#**********************************
package AbstractDecorator;
use base AbstractComponent;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub Component {
    $_[0]->{component} = $_[1] if defined $_[1];$_[0]->{component};
} ## --- end sub Component

sub Operation {
    my	( $self )	= @_;
    my $component = $self->Component();
    $component->Operation() if defined $component;
} ## --- end sub Operation

#**********************************
package ConcreteDecoratorA;
use base AbstractDecorator;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub AddedState {
    $_[0]->{addedState} = $_[1] if defined $_[1];$_[0]->{addedState};
} ## --- end sub AddedState

sub Operation {
    my	( $self )	= @_;
    $self->SUPER::Operation();
    $self->AddedState( "Added new state" );
    print "Concrete decorator A Operation()\n";
} ## --- end sub Operation

#**********************************
package ConcreteDecoratorB;
use base AbstractDecorator;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub AddedBehavior {
    
} ## --- end sub AddedBehavior

sub Operation {
    my	( $self )	= @_;
    $self->SUPER::Operation();
    $self->AddedBehavior( );
    print "Concrete decorator B Operation()\n";
} ## --- end sub Operation
#**********************************






#!/usr/bin/perl -w
use strict;
use warnings;
use Data::Dumper;
use Benchmark;

my $t0 = new Benchmark;

#open my $input, "/home/fanatic/Summoner/Codeeval-solutions/input.txt" || die "Can't open file: $!\n";
#open my $result, ">D:\\Perl\\output1.txt" || die "Can't open file: $!\n";

my $component = ConcreteComponent->new();
my $decoratorA = ConcreteDecoratorA->new();
my $decoratorB = ConcreteDecoratorB->new();
$decoratorA->Component( $component );
$decoratorB->Component( $decoratorA );
$decoratorB->Operation();

my $t1 = new Benchmark;
my $td = timediff($t1, $t0);
print "the code took:",timestr($td),"\n";
