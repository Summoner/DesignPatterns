#**********************************
package AbstractAggregate;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub CreateIterator {
    return;
} ## --- end sub Iterator

sub Count {
    return;
} ## --- end sub Count

sub This {
    return;
} ## --- end sub This

#**********************************
package ConcreteAggregate;
use base AbstractAggregate;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

my @_items = ();

sub CreateIterator {
    my $iterator = ConcreteIterator->new();
    return $iterator;
} ## --- end sub Iterator

sub Count {
    return scalar @_items;
} ## --- end sub Count

sub This {
    my ( $self,$index,$value ) = @_;

    if ( defined $value ){
        $_items[$index] = $value;
    }else{
        return $_items[$index];
    }
} ## --- end sub This

#**********************************
package AbstractIterator;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub First {
    return;
} ## --- end sub First

sub Next {
    return;
} ## --- end sub Next

sub IsDone {
    return;
} ## --- end sub IsDone

sub CurrentItem {
    return;
} ## --- end sub CurrentItem

#**********************************
package ConcreteIterator;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

my $_current = 0;

sub Aggregate {
    $_[0]->{aggregate} = $_[1] if defined $_[1];$_[0]->{aggregate};
} ## --- end sub Aggregate

sub First {
    my ( $self ) = @_;

    return $self->Aggregate->This(0);
} ## --- end sub First

sub Next {
    my ( $self ) = @_;
    my $result = undef;

    if ( $_current < $self->Aggregate->Count - 1 ){
        return $result = $self->Aggregate->This( ++$_current );
    }
    return $result;
} ## --- end sub Next

sub IsDone {
    my ( $self ) = @_;
    return $_current >= $self->Aggregate->Count;
} ## --- end sub IsDone

sub CurrentItem {
    my ( $self ) = @_;
    return $self->Aggregate->This( $_current );
} ## --- end sub CurrentItem

#**********************************


#!/usr/bin/perl -w
use strict;
use warnings;
use Data::Dumper;
use Benchmark;

my $t0 = new Benchmark;

#open my $input, "/home/fanatic/Summoner/Codeeval-solutions/input.txt" || die "Can't open file: $!\n";
#open my $result, ">D:\\Perl\\output1.txt" || die "Can't open file: $!\n";

my $a = ConcreteAggregate->new();

$a->This(0,"Item A");
$a->This(1,"Item B");
$a->This(2,"Item C");
$a->This(3,"Item D");

my $iterator = ConcreteIterator->new( aggregate => $a );
print "Iterating over collection:\n";

my $item = $iterator->First();

while( defined $item ){

    print "$item\n";
    $item = $iterator->Next;
}


my $t1 = new Benchmark;
my $td = timediff($t1, $t0);
print "the code took:",timestr($td),"\n";
