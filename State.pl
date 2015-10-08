#**********************************
package AbstractAutomat;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub GotApplication {
    my	( $self )	= @_;
    return ;
} ## --- end sub GotApplication

sub CheckApplication {
    my	( $self )	= @_;
    return ;
} ## --- end sub CheckApplication

sub RentApartment {
    my	( $self )	= @_;
    return ;
} ## --- end sub RentApartment

sub State {
    my	( $self,$state )	= @_;
    return ;
} ## --- end sub State

sub WaitingState {
    my	( $self )	= @_;
    return ;
} ## --- end sub WaitingState

sub ApplicationState {
    my	( $self )	= @_;
    return ;
} ## --- end sub GetGotApplicationState

sub ApartmentRentedState {
    my	( $self )	= @_;
    return ;
} ## --- end sub ApartmentRentedState

sub FullyRentedState {
    my	( $self )	= @_;
    return ;
} ## --- end sub FullyRentedState

sub Count {
    $_[0]->{count} = $_[1] if defined $_[1];$_[0]->{count};
} ## --- end sub Count


#**********************************
package AbstractAutomatState;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    $self->_initialize( @_ );
    return $self;
} ## --- end sub new

sub _initialize {
    my	( $self,%params )	= @_;
    $self->Automat( $params{automat} );
} ## --- end sub _initialize

sub Automat {
    $_[0]->{automat} = $_[1] if defined $_[1]; $_[0]->{automat};
} ## --- end sub Automat

sub GotApplication {
    my	( $self )	= @_;
    return ;
} ## --- end sub GotApplication

sub CheckApplication {
    my	( $self )	= @_;
    return ;
} ## --- end sub CheckApplication

sub RentApartment {
    my	( $self )	= @_;
    return ;
} ## --- end sub RentApartment

sub DispenseKeys {
    my	( $self )	= @_;
    return ;
} ## --- end sub DispenseKeys

#**********************************
package Automat;
use base AbstractAutomat;

sub new {
    my $class = shift;
    my $self = {};
    bless $self,$class;
    $self->_initialize( @_ );
    return $self;
} ## --- end sub new

sub _initialize {
    my	( $self,%params )	= @_;

    $self->Count( $params{count} );

    my $waitingState = WaitingState->new( automat => $self );
    $self->WaitingState( $waitingState );

    my $applicationState = ApplicationState->new( automat => $self );
    $self->ApplicationState( $applicationState );

    my $apartmentRentedState = ApartmentRentedState->new( automat => $self );
    $self->ApartmentRentedState( $apartmentRentedState );

    my $fullyRentedState = FullyRentedState->new( automat => $self );
    $self->FullyRentedState( $fullyRentedState );

    $self->State( $waitingState );
} ## --- end sub _initialize

sub WaitingState {
    $_[0]->{waitingstate} = $_[1] if defined $_[1];$_[0]->{waitingstate};
} ## --- end sub WaitingState

sub ApplicationState {
    $_[0]->{applicationstate} = $_[1] if defined $_[1];$_[0]->{applicationstate};
} ## --- end sub ApplicationState

sub ApartmentRentedState {
    $_[0]->{apartmentrentedstate} = $_[1] if defined $_[1];$_[0]->{apartmentrentedstate};
} ## --- end sub ApartmentRentedState

sub FullyRentedState {
    $_[0]->{fullyrentedstate} = $_[1] if defined $_[1];$_[0]->{fullyrentedstate};
} ## --- end sub FullyRentedState

sub State {
    $_[0]->{state} = $_[1] if defined $_[1];$_[0]->{state};
} ## --- end sub gState

sub Count {
    $_[0]->{count} = $_[1] if defined $_[1];$_[0]->{count};
} ## --- end sub Count

sub GotApplication {
    my	( $self )	= @_;
    print $self->State->GotApplication,"\n";
} ## --- end sub GotApplication

sub CheckApplication {
    my	( $self )	= @_;
    print $self->State->CheckApplication,"\n";
} ## --- end sub CheckApplication

sub RentApartment {
    my	( $self )	= @_;
    print $self->State->RentApartment,"\n";
    print $self->State->DispenseKeys,"\n";
} ## --- end sub RentApartment

#**********************************
package WaitingState;
use base AbstractAutomatState;

sub GotApplication {
    my	( $self )	= @_;
    $self->Automat->State( $self->Automat->ApplicationState );
    return "Thanks for the Application";
} ## --- end sub GotApplication

sub CheckApplication {
    my	( $self )	= @_;
    return "You have to submit Application";
} ## --- end sub CheckApplication

sub RentApartment {
    my	( $self )	= @_;
    return "You have to submit Application";
} ## --- end sub RentApartment

sub DispenseKeys {
    my	( $self )	= @_;
    return "You have to submit Application";
} ## --- end sub DispenseKeys

#**********************************
package ApplicationState;
use base AbstractAutomatState;

sub GotApplication {
    my	( $self )	= @_;
    return "We already got your Application";
} ## --- end sub GotApplication

sub CheckApplication {
    my	( $self )	= @_;
    my $yesNo = int(rand(10));
    if ( $yesNo > 4 && $self->Automat->Count > 0 ){
        $self->Automat->State( $self->Automat->ApartmentRentedState );
        return "Congratulations,you were approved";
    }else{
        $self->Automat->State( $self->Automat->WaitingState );
        return "You were not approved";
    }
} ## --- end sub CheckApplication

sub RentApartment {
    my	( $self )	= @_;
    return "You must have your application checked";
} ## --- end sub RentApartment

sub DispenseKeys {
    my	( $self )	= @_;
    return "You must have your application checked";
} ## --- end sub DispenseKeys

#**********************************

package ApartmentRentedState;
use base AbstractAutomatState;

sub GotApplication {
    my	( $self )	= @_;
    return "Hang on, we are renting you an apartment";
} ## --- end sub GotApplication

sub CheckApplication {
    my	( $self )	= @_;
    return "Hang on, we are renting you an apartment";

} ## --- end sub CheckApplication

sub RentApartment {
    my	( $self )	= @_;
    my $count = $self->Automat->Count;
    $self->Automat->Count( $count-- );
    return "Renting you an apartment...";
} ## --- end sub RentApartment

sub DispenseKeys {
    my	( $self )	= @_;

    if ( $self->Automat->Count < 0 ){
        $self->Automat->State( $self->Automat->FullyRentedState );
    }else{
        $self->Automat->State( $self->Automat->WaitingState );
        return "Here are your keys";
    }
} ## --- end sub DispenseKeys

#**********************************
package FullyRentedState;
use base AbstractAutomatState;

sub GotApplication {
    my	( $self )	= @_;
    return "Sorry, we are fully rented";
} ## --- end sub GotApplication

sub CheckApplication {
    my	( $self )	= @_;
    return "Sorry, we are fully rented";

} ## --- end sub CheckApplication

sub RentApartment {
    my	( $self )	= @_;
    return "Sorry, we are fully rented";
} ## --- end sub RentApartment

sub DispenseKeys {
    my	( $self )	= @_;
    return "Sorry, we are fully rented";
} ## --- end sub DispenseKeys

#**********************************





#!/usr/bin/perl -w
use strict;
use warnings;
use Data::Dumper;
use Benchmark;

my $t0 = new Benchmark;

#open my $input, "/home/fanatic/Summoner/Codeeval-solutions/input.txt" || die "Can't open file: $!\n";
#open my $result, ">D:\\Perl\\output1.txt" || die "Can't open file: $!\n";

my $automat = Automat->new( count => 9 );
$automat->GotApplication();
$automat->CheckApplication();
$automat->RentApartment();

my $t1 = new Benchmark;
my $td = timediff($t1, $t0);
print "the code took:",timestr($td),"\n";
