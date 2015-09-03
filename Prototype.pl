#**********************************
package AbstractPrototype;

sub Id {
    $_[0]->{id} = $_[1] if defined $_[1]; return $_[0]->{id};
} ## --- end sub Id

sub Clone {
    my	( $par1 )	= @_;
    return ;
} ## --- end sub Clone

#**********************************
package ConcretePrototype1;
use base AbstractPrototype;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub Clone {
    my	( $self )	= @_;
    my $copy = bless { %$self },ref $self;
    return $copy;
} ## --- end sub Clone

#**********************************
package ConcretePrototype2;
use base AbstractPrototype;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub Clone {
    my	( $self )	= @_;
    my $copy = bless { %$self },ref $self;
    return $copy;
} ## --- end sub Clone

#**********************************



#!/usr/bin/perl -w
use strict;
use warnings;
use Data::Dumper;
use Benchmark;

my $t0 = new Benchmark;

#open my $input, "/home/fanatic/Summoner/Codeeval-solutions/input.txt" || die "Can't open file: $!\n";
#open my $result, ">D:\\Perl\\output1.txt" || die "Can't open file: $!\n";

my $p1 = ConcretePrototype1->new( id => 1);
my $c1 = $p1->Clone();
print "Cloned: ",$c1->Id,"\n";

my $p2 = ConcretePrototype2->new( id => 2);
my $c2 = $p2->Clone();
print "Cloned: ",$c2->Id,"\n";

my $t1 = new Benchmark;
my $td = timediff($t1, $t0);
print "the code took:",timestr($td),"\n";
