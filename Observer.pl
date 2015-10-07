#!/usr/bin/perl -w

#**********************************
package Subject;
use strict;
use warnings;
use Data::Dumper;
use Benchmark;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub SubjectState {
    $_[0]->{subjectstate} = $_[1] if defined $_[1];$_->{subjectstate};
} ## --- end sub SubjectState

my $_callbacks = [];

sub Callbacks {
    my ( $self,$callback ) = @_;
    
    unless ( defined  $callback ){
        return $_callbacks;
    }else{
        push @$_callbacks,$callback;
    }    
} ## --- end sub Callback

sub Go {
    my	( $self )	= @_;
#    my $pid = undef;
#    if ( !defined( $pid = fork()) ) ){
#        die "Can't fork() child process: $!";
#    }elsif( $pid == 0 ){
#        print "Printed by child process\n";
#        exec( Run() ) || die "Can't exec Run(): $!";
#    }
#    return ;
    $self->Run();
} ## --- end sub Go

sub Run {
    my	( $self )	= @_;
    my $simulator = Simulator->new();
    my $states = Simulator->StatesCount;

    foreach my $state ( 1..$states ) {
        my $subjectState = Simulator->GetNextState();
        print "Subject: $subjectState\n";
        $self->SubjectState( $subjectState );
        $self->Notify( $subjectState );
    }
} ## --- end sub Run

sub Notify {
    my	( $self,$state )	= @_;
    my $callbacks = $self->Callbacks();

    foreach my $callback ( @$callbacks ) {
        $callback->( $state );
    }    
} ## --- end sub Notify

#**********************************
package Simulator;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

my $arr = [1,2,3,4,5,6];

sub iterate( $$ ) {
    my $class = shift;
    my $iter = shift;

    my $nextval = $iter->();
    return unless defined $nextval;
    local *_ = \$nextval;
    return $nextval;
} ## --- end sub myIterator

sub GetElement {
    my ( $class ) = @_;
    my $i = -1;
    return sub{
        $i++;
        return if ( $i > $#{ $arr } );
        return $arr->[$i];
    }
} ## --- end sub GetElement

sub StatesCount {
    my	( $class )	= @_;
    return scalar @$arr;
} ## --- end sub StateCount

my $next = GetElement;

sub GetNextState {
    my	( $class )	= @_;

    my $nextState =  Simulator->iterate( $next );
    return $nextState;
} ## --- end sub GetNextState
#**********************************

package Observer;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    $self->_init();
    return $self;
} ## --- end sub new

sub _init {
    my	( $self )	= @_;
    $self->CreateCallback;
} ## --- end sub _init

sub Name {
    $_[0]->{name} = $_[1] if defined $_[1];$_[0]->{name};
} ## --- end sub Name

sub State {
    $_[0]->{state} = $_[1] if defined $_[1];$_[0]->{state};
} ## --- end sub State

sub Gap {
    $_[0]->{gap} = $_[1] if defined $_[1];$_[0]->{gap};
} ## --- end sub Gap

sub Subject1 {
    $_[0]->{subject} = $_[1] if defined $_[1];$_[0]->{subject};
} ## --- end sub Subject

sub CreateCallback {
    my	( $self )	= @_;

    my $callback = sub{ my $state = shift; $self->Update( $state ) };
    $self->Subject1->Callbacks( $callback );
} ## --- end sub CreateCallback

sub Update {
    my	( $self,$state )	= @_;

    $self->State($state);
    print $self->Gap, $self->Name, ": ", $self->State,"\n";
} ## --- end sub Update


#!/usr/bin/perl -w
use strict;
use warnings;
use Data::Dumper;

my $subject = Subject->new();
my $observer1 = Observer->new( subject => $subject, gap => "\t\t",name => "Center" );
my $observer2 = Observer->new( subject => $subject, gap => "\t\t\t\t",name => "Right" );

$subject->Go();

