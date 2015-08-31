#**********************************
package AbstractProduct;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

#**********************************
package ConcreteProductA;
use base AbstractProduct;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

#**********************************
package ConcreteProductB;
use base AbstractProduct;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

#**********************************
package AbstractCreator;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new


sub FactoryMethod {
    my	( $self )	= @_;
    
    return $self;
} ## --- end sub FactoryMethod

#**********************************
package ConcreteCreatorA;
use base AbstractCreator;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub FactoryMethod {
    my	( $self )	= @_;
    my $product = ConcreteProductA->new();
    return $product;
} ## --- end sub FactoryMethod

#**********************************
package ConcreteCreatorB;
use base AbstractCreator;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub FactoryMethod {
    my	( $self )	= @_;
    my $product = ConcreteProductB->new();
    return $self;
} ## --- end sub FactoryMethod

#**********************************



#!/usr/bin/perl -w
use strict;
use warnings;
use Data::Dumper;
use Benchmark;

my $t0 = new Benchmark;

#open my $input, "/home/fanatic/Summoner/Codeeval-solutions/input.txt" || die "Can't open file: $!\n";
#open my $result, ">D:\\Perl\\output1.txt" || die "Can't open file: $!\n";

my $creator1 = ConcreteCreatorA->new();
my $creator2 = ConcreteCreatorB->new();

my $creators = [];
push @$creators,$creator1;
push @$creators,$creator2;


foreach my $creator ( @$creators ) {
    my $product = $creator->FactoryMethod();
    print Dumper \$product;
}


my $t1 = new Benchmark;
my $td = timediff($t1, $t0);
print "the code took:",timestr($td),"\n";
