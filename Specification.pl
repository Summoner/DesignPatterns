#**********************************
package AbstractSpecification;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub IsSatisfiedBy {
    my	( $self )	= @_;
    return;
} ## --- end sub IsSatisfiedBy

#**********************************
package AndSpecification;
use base AbstractSpecification;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub Spec1{
    $_[0]->{spec1} = $_[1] if defined $_[1];return $_[0]->{spec1};
} ## --- end sub Spec1

sub Spec2{
    $_[0]->{spec2} = $_[1] if defined $_[1];return $_[0]->{spec2};
} ## --- end sub Spec2

sub IsSatisfiedBy {
    my	( $self,$candidat )	= @_;

    return $self->Spec1->IsSatisfiedBy( $candidate ) && $self->Spec1->IsSatisfiedBy( $candidate );
} ## --- end sub IsSatisfiedBy

#**********************************

package OrSpecification;
use base AbstractSpecification;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub Spec1{
    $_[0]->{spec1} = $_[1] if defined $_[1];return $_[0]->{spec1};
} ## --- end sub Spec1

sub Spec2{
    $_[0]->{spec2} = $_[1] if defined $_[1];return $_[0]->{spec2};
} ## --- end sub Spec2

sub IsSatisfiedBy {
    my	( $self,$candidat )	= @_;

    return $self->Spec1->IsSatisfiedBy( $candidate ) || $self->Spec1->IsSatisfiedBy( $candidate );
} ## --- end sub IsSatisfiedBy

#**********************************

package NotSpecification;
use base AbstractSpecification;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub Wrapped{
    $_[0]->{wrapped} = $_[1] if defined $_[1];return $_[0]->{wrapped};
} ## --- end sub Wrapped

sub IsSatisfiedBy {
    my	( $self,$candidat )	= @_;

    return !$self->Wrapped->IsSatisfiedBy( $candidat );
} ## --- end sub IsSatisfiedBy

#**********************************





#!/usr/bin/perl -w
use strict;
use warnings;
use Data::Dumper;
use Benchmark;

my $t0 = new Benchmark;

#open my $input, "/home/fanatic/Summoner/Codeeval-solutions/input.txt" || die "Can't open file: $!\n";
#open my $result, ">D:\\Perl\\output1.txt" || die "Can't open file: $!\n";


my $t1 = new Benchmark;
my $td = timediff($t1, $t0);
print "the code took:",timestr($td),"\n";
