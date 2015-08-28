#**********************************
package Director;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub Construct {
    my	( $self,$builder)	= @_;
    $builder->BuildPartA();
    $builder->BuildPartB();
} ## --- end sub Construct

#**********************************
package AbstractBuilder;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub BuildPartA {
    my	( $self )	= @_;
    return;
} ## --- end sub BuildPartA

sub BuildPartB {
    my	( $self )	= @_;
    return;
} ## --- end sub BuildPartB

sub GetResult {
    my	( $self )	= @_;
    return;
} ## --- end sub GetResult

#**********************************
package ConcreteBuilder1;

use base AbstractBuilder;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

my $_product1 = Product->new();

sub BuildPartA {
    my	( $self )	= @_;
    $_product1->Add( "add PartA" );
} ## --- end sub BuildPartA

sub BuildPartB {
    my	( $self )	= @_;
    $_product1->Add( "add PartB" );
    return;
} ## --- end sub BuildPartB

sub GetResult {
    my	( $self )	= @_;
    return $_product1;
} ## --- end sub GetResult
1;
#**********************************
package ConcreteBuilder2;

use base AbstractBuilder;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

my $_product2 = Product->new();

sub BuildPartA {
    my	( $self )	= @_;
    $_product2->Add( "add PartX" );
} ## --- end sub BuildPartA

sub BuildPartB {
    my	( $self )	= @_;
    $_product2->Add( "add PartY" );
    return;
} ## --- end sub BuildPartB

sub GetResult {
    my	( $self )	= @_;
    return $_product2;
} ## --- end sub GetResult

#**********************************
package Product;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

my $_parts = [];

sub Add {
    my	( $self,$part )	= @_;
    push @$_parts,$part;
    return ;
} ## --- end sub Add

sub Show {
    my	( $self )	= @_;
    foreach my $part ( @$_parts ) {
        print "$part\n";
    }
} ## --- end sub Show



#!/usr/bin/perl -w
use strict;
use warnings;
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
