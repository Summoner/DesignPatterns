#**********************************
package AbstractMath;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub Add {
    my	( $self )	= @_;
    return;
} ## --- end sub Add

sub Sub {
    my	( $self )	= @_;
    return;
} ## --- end sub Sub

sub Mul {
    my	( $self )	= @_;
    return;
} ## --- end sub Mul

sub Div {
    my	( $self )	= @_;
    return;
} ## --- end sub Div

#**********************************
package Math;

use base AbstractMath;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    print "Creating math object, please wait...\n";
    $self->ThreadJob(10);
    return $self;
} ## --- end sub new

sub Add {
    my	( $self,$x,$y )	= @_;
    return $x + $y;
} ## --- end sub Add

sub Sub {
    my	( $self,$x,$y )	= @_;
    return $x - $y;
} ## --- end sub Sub

sub Mul {
    my	( $self,$x,$y )	= @_;
    return $x * $y;
} ## --- end sub Mul

sub Div {
    my	( $self,$x,$y )	= @_;
    return $x / $y;
} ## --- end sub Div

sub ThreadJob {
    my	( $self,$delayTime )	= @_;
    select( undef,undef,undef,$delayTime );
    return;
} ## --- end sub ThreadJob


#**********************************
package mathProxy;

use base AbstractMath;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

my $mathObj = undef;
sub Add {
    my	( $self,$x,$y )	= @_;
    return $x + $y;
} ## --- end sub Add

sub Sub {
    my	( $self,$x,$y )	= @_;
    return $x - $y;
} ## --- end sub Sub

sub Mul {
    my	( $self,$x,$y )	= @_;

    unless ( defined $mathObj ){
        $mathObj = Math->new();
    } 
    return $mathObj->Mul( $x, $y );
} ## --- end sub Mul

sub Div {
    my	( $self,$x,$y )	= @_;

    unless ( defined $mathObj ){
        $mathObj = Math->new();
    } 
    return $mathObj->Div( $x, $y );
} ## --- end sub Div

#***********************************

#!/usr/bin/perl -w
use strict;
use warnings;
use Data::Dumper;
use Benchmark;

my $t0 = new Benchmark;

#open my $input, "/home/fanatic/Summoner/Codeeval-solutions/input.txt" || die "Can't open file: $!\n";
#open my $result, ">D:\\Perl\\output1.txt" || die "Can't open file: $!\n";

my $proxy = mathProxy->new();

my $x = 10;
my $y = 2;

print " $x + $y = ", $proxy->Add( $x,$y ),"\n";
print " $x - $y = ", $proxy->Sub( $x,$y ),"\n";
print " $x * $y = ", $proxy->Mul( $x,$y ),"\n";
print " $x / $y = ", $proxy->Div( $x,$y ),"\n";

my $t1 = new Benchmark;
my $td = timediff($t1, $t0);
print "the code took:",timestr($td),"\n";
