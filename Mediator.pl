use Scalar::Util 'refaddr';

#**********************************
package AbstractMediator;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub Send {
    my	( $self )	= @_;
    return;
} ## --- end sub Send

#**********************************
package ConcreteMediator;
use base AbstractMediator;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub Colleague1 {
    $_[0]->{colleague1} = $_[1] if defined $_[1];$_[0]->{colleague1};
} ## --- end sub Colleague1

sub Colleague2 {
    $_[0]->{colleague2} = $_[1] if defined $_[1];$_[0]->{colleague2};
} ## --- end sub Colleague2

sub Send {
    my	( $self,$message,$colleague )	= @_;

    if ( Scalar::Util::refaddr( $colleague ) == Scalar::Util::refaddr( $self->Colleague1 ) ){

        $self->Colleague2->Notify( $message );
    }else{
        $self->Colleague1->Notify( $message );
    }
} ## --- end sub Send

#**********************************
package AbstractColleague;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

#**********************************
package ConcreteColleague1;
use base AbstractColleague;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub Mediator{
    $_[0]->{mediator} = $_[1] if defined $_[1];$_[0]->{mediator};
}## --- end sub Mediator

sub Send {
    my	( $self,$message )	= @_;
    $self->Mediator->Send( $message,$self );    
} ## --- end sub Send

sub Notify {
    my	( $self,$message )	= @_;
    print "Colleague 1 gets a message: $message\n";
} ## --- end sub Notify

#**********************************
package ConcreteColleague2;
use base AbstractColleague;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub Mediator{
    $_[0]->{mediator} = $_[1] if defined $_[1];$_[0]->{mediator};
}## --- end sub Mediator

sub Send {
    my	( $self,$message )	= @_;
    $self->Mediator->Send( $message,$self );    
} ## --- end sub Send

sub Notify {
    my	( $self,$message )	= @_;
    print "Colleague 2 gets a message: $message\n";
} ## --- end sub Notify

#**********************************




#!/usr/bin/perl -w
use strict;
use warnings;
use Data::Dumper;
use Benchmark;

my $t0 = new Benchmark;

#open my $input, "/home/fanatic/Summoner/Codeeval-solutions/input.txt" || die "Can't open file: $!\n";
#open my $result, ">D:\\Perl\\output1.txt" || die "Can't open file: $!\n";

my $mediator = ConcreteMediator->new();

my $c1 = ConcreteColleague1->new( mediator => $mediator );
my $c2 = ConcreteColleague2->new( mediator => $mediator );

$mediator->Colleague1( $c1 );
$mediator->Colleague2( $c2 );


$c1->Send( "How are you?");
$c2->Send( "Fine,thanks!");



my $t1 = new Benchmark;
my $td = timediff($t1, $t0);
print "the code took:",timestr($td),"\n";
