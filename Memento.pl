#!/usr/bin/perl -w


#**********************************
package AbstractOriginator;


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

sub Memento {
    my ( $self,$memento ) = @_;
    unless ( defined $memento ){

        my $memento = Memento->new( intproperty => $self->IntProperty, stringproperty => $self->StringProperty );
        return $memento;
    }else{
        $self->IntProperty( $memento->IntProperty );
        $self->StringProperty( $memento->StringProperty );
    }
} ## --- end sub Memento

#**********************************

package Foo;
use base qw 'AbstractOriginator';

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub StringProperty {

    $_[0]->{stringproperty} = $_[1] if defined $_[1];$_[0]->{stringproperty};
} ## --- end sub StringProperty

sub IntProperty {

    $_[0]->{intproperty} = $_[1] if defined $_[1];$_[0]->{intproperty};
} ## --- end sub IntProperty

sub Print {
    my	( $self )	= @_;
    print "*********************************\n";
    print "String propery value: ",$self->StringProperty,"\n";
    print "Int propery value: ",$self->IntProperty,"\n";
    print "*********************************\n";
} ## --- end sub Print

#**********************************

package Memento;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub StringProperty {

    $_[0]->{stringproperty} = $_[1] if defined $_[1];$_[0]->{stringproperty};
} ## --- end sub StringProperty

sub IntProperty {

    $_[0]->{intproperty} = $_[1] if defined $_[1];$_[0]->{intproperty};
} ## --- end sub IntProperty

#**********************************

package CareTaker;
sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub Memento {
    $_[0]->{memento} = $_[1] if defined $_[1];$_[0]->{memento};
} ## --- end sub Memento

sub SaveState {
    my	( $self,$originator )	= @_;
    my $memento = $originator->Memento();
    $self->Memento( $memento );

} ## --- end sub SaveState

sub RestoreState {
    my	( $self,$originator )	= @_;
    my $memento = $self->Memento();
    $originator->Memento( $memento );

} ## --- end sub SaveState





#!/usr/bin/perl -w
use strict;
use warnings;
use Data::Dumper;
use Benchmark;

my $t0 = new Benchmark;

#open my $input, "/home/fanatic/Summoner/Codeeval-solutions/input.txt" || die "Can't open file: $!\n";
#open my $result, ">D:\\Perl\\output1.txt" || die "Can't open file: $!\n";

my $foo = Foo->new( stringproperty => "Test",intproperty => 115 );

$foo->Print();
my $ct1 = CareTaker->new();
my $ct2 = CareTaker->new();

$ct1->SaveState( $foo );
$foo->IntProperty( 200 );
$foo->Print();
$ct2->SaveState( $foo );
$ct1->RestoreState( $foo );
$foo->Print();
$ct2->RestoreState( $foo );
$foo->Print();

my $t1 = new Benchmark;
my $td = timediff($t1, $t0);
print "the code took:",timestr($td),"\n";
