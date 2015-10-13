#**********************************
package AbstractVisitor;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub VisitConcreteElementA {
    my	( $self )	= @_;
    return;
} ## --- end sub VisitConcreteElementA

sub VisitConcreteElementB {
    my	( $self )	= @_;
    return;
} ## --- end sub VisitConcreteElementB

#**********************************

package ConcreteVisitor1;
use base AbstractVisitor;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub VisitConcreteElementA {
    my	( $self,$concreteElementA )	= @_;
    print ref $self ," visited ", ref $concreteElementA, "\n";
    return;
} ## --- end sub VisitConcreteElementA

sub VisitConcreteElementB {
    my	( $self,$concreteElementB )	= @_;
    print ref $self ," visited ", ref $concreteElementB, "\n";
    return;
} ## --- end sub VisitConcreteElementB

#**********************************

package ConcreteVisitor2;
use base AbstractVisitor;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub VisitConcreteElementA {
    my	( $self,$concreteElementA )	= @_;
    print ref $self ," visited ", ref $concreteElementA, "\n";
    return;
} ## --- end sub VisitConcreteElementA

sub VisitConcreteElementB {
    my	( $self,$concreteElementB )	= @_;
    print ref $self ," visited ", ref $concreteElementB, "\n";
    return;
} ## --- end sub VisitConcreteElementB

#**********************************

package AbstractElement;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub Accept {
    my	( $self )	= @_;

    return;
} ## --- end sub Accept

#**********************************

package ConcreteElementA;
use base AbstractElement;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub Accept {
    my	( $self,$visitor )	= @_;
    $visitor->VisitConcreteElementA( $self );
} ## --- end sub Accept


sub OperationA {
    my	( $par1 )	= @_;
    return ;
} ## --- end sub OperationA

#**********************************

package ConcreteElementB;
use base AbstractElement;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub Accept {
    my	( $self,$visitor )	= @_;
    $visitor->VisitConcreteElementB( $self );
} ## --- end sub Accept

sub OperationB {
    my	( $par1 )	= @_;
    return ;
} ## --- end sub OperationB

#**********************************
package ObjectStructure;

sub new {
    my $class = shift;
    my $self = { @_ };
    bless $self,$class;
    return $self;
} ## --- end sub new

my @_list = ();

sub Attach {
    my	( $self,$element )	= @_;
    push @_list,$element;
} ## --- end sub Attach

sub Detach {
    my	( $self )	= @_;
    pop @_list;
} ## --- end sub Detach


sub Accept {
    my	( $self,$visitor )	= @_;

    foreach my $element ( @_list ) {
        $element->Accept( $visitor );
    }
} ## --- end sub Accept





#!/usr/bin/perl -w
use strict;
use warnings;
use Data::Dumper;
use Benchmark;

my $t0 = new Benchmark;

#open my $input, "/home/fanatic/Summoner/Codeeval-solutions/input.txt" || die "Can't open file: $!\n";
#open my $result, ">D:\\Perl\\output1.txt" || die "Can't open file: $!\n";

my $o = ObjectStructure->new();

my $e1 = ConcreteElementA->new();
my $e2 = ConcreteElementB->new();

$o->Attach( $e1 );
$o->Attach( $e2 );

my $v1 = ConcreteVisitor1->new();
my $v2 = ConcreteVisitor2->new();

$o->Accept( $v1 );

my $t1 = new Benchmark;
my $td = timediff($t1, $t0);
print "the code took:",timestr($td),"\n";
