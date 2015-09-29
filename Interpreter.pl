#**********************************
package Context;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

#**********************************
package AbstractExpression;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub Interpret {
    my	( $self )	= @_;

} ## --- end sub Interpret

#**********************************
package TerminalExpression;
use base AbstractExpression;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub Interpret {
    my	( $self )	= @_;
    print "Called Terminal->Interpret()\n";
} ## --- end sub Interpret

#**********************************
package NonterminalExpression;
use base AbstractExpression;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub Interpret {
    my	( $self )	= @_;
    print "Called Nonterminal->Interpret()\n";
} ## --- end sub Interpret

#**********************************

#!/usr/bin/perl -w
use strict;
use warnings;
use Data::Dumper;
use Benchmark;

my $t0 = new Benchmark;

#open my $input, "/home/fanatic/Summoner/Codeeval-solutions/input.txt" || die "Can't open file: $!\n";
#open my $result, ">D:\\Perl\\output1.txt" || die "Can't open file: $!\n";

my @List = ();

my $context = Context->new();

my $expr1 = TerminalExpression->new();
push @List,$expr1;

my $expr2 = NonterminalExpression->new();
push @List,$expr2;

my $expr3 = TerminalExpression->new();
push @List,$expr3;

my $expr4 = TerminalExpression->new();
push @List,$expr4;

foreach my $expr ( @List ) {
    $expr->Interpret( $context );
}


my $t1 = new Benchmark;
my $td = timediff($t1, $t0);
print "the code took:",timestr($td),"\n";
