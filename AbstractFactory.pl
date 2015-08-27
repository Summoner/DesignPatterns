#**********************************
package AbstractFactory;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub CreateProductA {
    my	( $self)	= @_;
    return ;
} ## --- end sub CreateProductA

sub CreateProductB {
    my	( $self )	= @_;
    return ;
} ## --- end sub CreateProductB

#**********************************
package ConcretFactory1;

use base AbstractFactory;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub CreateProductA {
    my	( $self )	= @_;
    return ProductA1->new();
} ## --- end sub CreateProductA

sub CreateProductB {
    my	( $self )	= @_;
    return ProductB1->new();
} ## --- end sub CreateProductB

#**********************************
package ConcretFactory2;

use base AbstractFactory;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub CreateProductA {
    my	( $self )	= @_;
    return ProductA2->new();
} ## --- end sub CreateProductA

sub CreateProductB {
    my	( $self )	= @_;
    return ProductB2->new();
} ## --- end sub CreateProductB

#**********************************
package AbstractProductA;
sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

package AbstractProductB;
sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub Interact {
    my	( $self )	= @_;
    return ;
} ## --- end sub CreateProductB

package ProductA1;
use base AbstractProductA;

package ProductB1;
use base AbstractProductB;

sub Interact {
    my	( $self,$product )	= @_;
    print "products A1 and B1 interacted\n";
    return ;
} ## --- end sub Interact

package ProductA2;
use base AbstractProductA;

package ProductB2;
use base AbstractProductB;

sub Interact {
    my	( $self,$product )	= @_;
    print "products A2 and B2 interacted\n";
    return ;
} ## --- end sub Interact

package Client;

my $_abstractProductA;
my $_abstractProductB;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;

    my $factory = $self->{factory};
    $_abstractProductA = $factory->CreateProductA();
    $_abstractProductB = $factory->CreateProductB();
    return $self;
} ## --- end sub new

sub Run {
    my	( $self )	= @_;
    $_abstractProductB->Interact( $_abstractProductA );
    return ;
} ## --- end sub Run

#!/usr/bin/perl -w
use strict;
use warnings;
use Data::Dumper;
use Benchmark;

my $t0 = new Benchmark;

#open my $input, "/home/fanatic/Summoner/Codeeval-solutions/input.txt" || die "Can't open file: $!\n";
#open my $result, ">D:\\Perl\\output1.txt" || die "Can't open file: $!\n";

my $factory1 = ConcretFactory1->new();
my $factory2 = ConcretFactory2->new();

my $client1 = Client->new( factory => $factory1 );
$client1->Run;

my $client2 = Client->new( factory => $factory2 );
$client2->Run;


my $t1 = new Benchmark;
my $td = timediff($t1, $t0);
print "the code took:",timestr($td),"\n";
