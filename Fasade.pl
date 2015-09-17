#**********************************
package SubSystemA;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub A1 {
    my	( $self )	= @_;
    return "SubSystemA method A1 ";
} ## --- end sub A1

sub A2 {
    my	( $self )	= @_;
    return "SubSystemA method A2 ";
} ## --- end sub A2

#**********************************

package SubSystemB;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub B1 {
    my	( $self )	= @_;
    return "SubSystemB method B1 ";
} ## --- end sub B1

#**********************************

package SubSystemC;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub C1 {
    my	( $self )	= @_;
    return "SubSystemC method C1 ";
} ## --- end sub C1

#**********************************

package Fasade;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

my $subA = SubSystemA->new();
my $subB = SubSystemB->new();
my $subC = SubSystemC->new();

sub Operation1 {
    my	( $self )	= @_;
    print $subA->A1(),$subA->A2(),$subB->B1(),"\n";
} ## --- end sub Operation1

sub Operation2 {
    my	( $self )	= @_;
    print $subB->B1(),$subC->C1(),"\n";
} ## --- end sub Operation1

#**********************************



#!/usr/bin/perl -w
use strict;
use warnings;
use Data::Dumper;
use Benchmark;

my $t0 = new Benchmark;

#open my $input, "/home/fanatic/Summoner/Codeeval-solutions/input.txt" || die "Can't open file: $!\n";
#open my $result, ">D:\\Perl\\output1.txt" || die "Can't open file: $!\n";

my $f = Fasade->new();
$f->Operation1();
$f->Operation2();



my $t1 = new Benchmark;
my $td = timediff($t1, $t0);
print "the code took:",timestr($td),"\n";
