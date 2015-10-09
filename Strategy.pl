#**********************************
package AbstractStrategy;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub Algoritm {
    my	( $self )	= @_;
    return;
} ## --- end sub Algoritm

#**********************************

package ConcreteStrategy1;
use base AbstractStrategy;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub Algoritm {
    my	( $self )	= @_;
    print "Implementation of algoritm of strategy 1\n";    
} ## --- end sub Algoritm

#**********************************

package ConcreteStrategy2;
use base AbstractStrategy;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub Algoritm {
    my	( $self )	= @_;
    print "Implementation of algoritm of strategy 2\n";    
} ## --- end sub Algoritm

#**********************************

package Context;

sub new {
    my $class = shift;
    my $self = {};
    bless $self,$class;
    $self->_initialize( @_ );
    return $self;
} ## --- end sub new

sub _initialize {
    my	( $self,%params )	= @_;

    $self->Strategy( $params{strategy} );    
} ## --- end sub _initialize

sub Strategy {
    $_[0]->{strategy} = $_[1] if defined $_[1]; $_[0]->{strategy};
} ## --- end sub Strategy

sub ExecuteAlgoritm {
    my	( $self )	= @_;
    $self->Strategy->Algoritm();    
} ## --- end sub Algoritm

#**********************************

#!/usr/bin/perl -w
use strict;
use warnings;
use Data::Dumper;
use Benchmark;

my $t0 = new Benchmark;

#open my $input, "/home/fanatic/Summoner/Codeeval-solutions/input.txt" || die "Can't open file: $!\n";
#open my $result, ">D:\\Perl\\output1.txt" || die "Can't open file: $!\n";

my $strategy1 = ConcreteStrategy1->new();
my $strategy2 = ConcreteStrategy2->new();

my $c = Context->new( strategy => $strategy1 );
$c->ExecuteAlgoritm();

$c->Strategy( $strategy2 );
$c->ExecuteAlgoritm();



my $t1 = new Benchmark;
my $td = timediff($t1, $t0);
print "the code took:",timestr($td),"\n";
