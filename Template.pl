#**********************************
package GameObject;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub PlayersCount{
    $_[0]->{playerscount} = $_[1] if defined $_[1];$_[0]->{playerscount};
}

sub InitializeGame {
    my	( $self )	= @_;
    return;
} ## --- end sub InitializeGame

sub MakePlay {
    my	( $self )	= @_;
    return;
} ## --- end sub MakePlay

sub EndOfGame {
    my	( $self )	= @_;
    return;
} ## --- end sub EndOfGame

sub PrintWinner {
    my	( $self )	= @_;
    return;
} ## --- end sub PrintWinner

sub PlayOneGame {
    my	( $self,$playersCount )	= @_;

    $self->PlayersCount( $PlayersCount );
    my $j = 0;

    while ( !$self->EndOfGame() ){
        $self->MakePlay( $j );
        $j = ( $j +1 )% $playersCount;
    }
    $self->PrintWinner();
} ## --- end sub PlayOneGame

#**********************************
package Monopoly;
use base GameObject;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub InitializeGame {
    my	( $self )	= @_;
    return;
} ## --- end sub InitializeGame

sub MakePlay {
    my	( $self )	= @_;
    return;
} ## --- end sub MakePlay

sub EndOfGame {
    my	( $self )	= @_;
    return 1;
} ## --- end sub EndOfGame

sub PrintWinner {
    my	( $self )	= @_;
    return;
} ## --- end sub PrintWinner

#**********************************
package Chess;
use base GameObject;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub InitializeGame {
    my	( $self )	= @_;
    return;
} ## --- end sub InitializeGame

sub MakePlay {
    my	( $self )	= @_;
    return;
} ## --- end sub MakePlay

sub EndOfGame {
    my	( $self )	= @_;
    return 1;
} ## --- end sub EndOfGame

sub PrintWinner {
    my	( $self )	= @_;
    return;
} ## --- end sub PrintWinner
#**********************************

#!/usr/bin/perl -w
use strict;
use warnings;
use Data::Dumper;
use Benchmark;

my $t0 = new Benchmark;

#open my $input, "/home/fanatic/Summoner/Codeeval-solutions/input.txt" || die "Can't open file: $!\n";
#open my $result, ">D:\\Perl\\output1.txt" || die "Can't open file: $!\n";

my $m = Monopoly->new();

$m->PlayOneGame(2);



my $t1 = new Benchmark;
my $td = timediff($t1, $t0);
print "the code took:",timestr($td),"\n";
