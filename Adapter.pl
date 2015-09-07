#**********************************
package Target;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub Request {
    my	( $self )	= @_;
    print "Called target request()\n";
} ## --- end sub Request

#**********************************
package Adapter;
use base Target;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

my $_adaptee = Adaptee->new();

sub Request {
    my	( $self )	= @_;
    $_adaptee->SpecificRequest();    
} ## --- end sub Request

#**********************************
package Adaptee;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub SpecificRequest {
    my	( $self )	= @_;
    print "Called SpecificRequest\n";
} ## --- end sub SpecificRequest

#**********************************


#!/usr/bin/perl -w
use strict;
use warnings;
use Data::Dumper;
use Benchmark;

my $t0 = new Benchmark;

#open my $input, "/home/fanatic/Summoner/Codeeval-solutions/input.txt" || die "Can't open file: $!\n";
#open my $result, ">D:\\Perl\\output1.txt" || die "Can't open file: $!\n";

my $a = Adapter->new();
$a->Request();

my $t1 = new Benchmark;
my $td = timediff($t1, $t0);
print "the code took:",timestr($td),"\n";
