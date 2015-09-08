#**********************************
package Abstraction;

sub Implementor {
    $_[0]->{implementor} = $_[1] if defined $_[1];return $_[0]->{implementor};
} ## --- end sub Construct

sub Operation {
    my	( $self )	= @_;
    $self->Implementor->Operation();
} ## --- end sub Operation

#**********************************
package AbstractImplementor;

sub Operation {
    my	( $self )	= @_;
    return;
} ## --- end sub Operation

#**********************************
package RefinedAbstraction;

use base Abstraction;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub Operation {
    my	( $self )	= @_;
    $self->Implementor->Operation( );
} ## --- end sub BuildPartA

#**********************************
package ConcreteImplementorA;

use base AbstractImplementor;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub Operation {
    my	( $self )	= @_;
    print "Concrete implementor A operation performed\n";
} ## --- end sub BuildPartA

#**********************************
package ConcreteImplementorB;

use base AbstractImplementor;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub Operation {
    my	( $self )	= @_;
    print "Concrete implementor B operation performed\n";
} ## --- end sub BuildPartA

#**********************************



#!/usr/bin/perl -w
use strict;
use warnings;
use Data::Dumper;
use Benchmark;

my $t0 = new Benchmark;

#open my $input, "/home/fanatic/Summoner/Codeeval-solutions/input.txt" || die "Can't open file: $!\n";
#open my $result, ">D:\\Perl\\output1.txt" || die "Can't open file: $!\n";

my $ab = RefinedAbstraction->new();
$ab->Implementor( ConcreteImplementorA->new() );
$ab->Operation();

$ab->Implementor( ConcreteImplementorB->new() );
$ab->Operation();


my $t1 = new Benchmark;
my $td = timediff($t1, $t0);
print "the code took:",timestr($td),"\n";
