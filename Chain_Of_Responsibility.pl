#**********************************
package AbstractHandler;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub Successor {
    $_[0]->{successor} = $_[1] if defined $_[1];$_[0]->{successor};    
} ## --- end sub Successor

sub HandleRequest {
    my	( $self )	= @_;
    return ;
} ## --- end sub HandleRequest

#**********************************
package ConcreteHandler1;
use base AbstractHandler;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub HandleRequest {
    my	( $self,$request )	= @_;

    if ( $request >= 0 && $request < 10 ){

        print "Handled request: $request"," by ", ref $self, "\n";

    }elsif ( defined $self->Successor ){

        my $successor = $self->Successor;
        $successor->HandleRequest( $request );
    }
} ## --- end sub HandleRequest

#**********************************
package ConcreteHandler2;
use base AbstractHandler;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub HandleRequest {
    my	( $self,$request )	= @_;

    if ( $request >= 10 && $request < 20 ){

        print "Handled request: $request"," by ", ref $self, "\n";

    }elsif ( defined $self->Successor ){

        my $successor = $self->Successor;
        $successor->HandleRequest( $request );
    }
} ## --- end sub HandleRequest

#**********************************
package ConcreteHandler3;
use base AbstractHandler;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub HandleRequest {
    my	( $self,$request )	= @_;

    if ( $request >= 20 && $request < 30 ){

        print "Handled request: $request"," by ", ref $self, "\n";

    }elsif ( defined $self->Successor ){

        my $successor = $self->Successor;
        $successor->HandleRequest( $request );
    }
} ## --- end sub HandleRequest

#**********************************







#!/usr/bin/perl -w
use strict;
use warnings;
use Data::Dumper;
use Benchmark;

my $t0 = new Benchmark;

#open my $input, "/home/fanatic/Summoner/Codeeval-solutions/input.txt" || die "Can't open file: $!\n";
#open my $result, ">D:\\Perl\\output1.txt" || die "Can't open file: $!\n";

my $h1 = ConcreteHandler1->new();
my $h2 = ConcreteHandler2->new();
my $h3 = ConcreteHandler3->new();

$h1->Successor( $h2 );
$h2->Successor( $h3 );

my @requests = (1,13,2,17,21,2,7);

foreach my $request ( @requests ) {

    $h1->HandleRequest( $request );
}

my $t1 = new Benchmark;
my $td = timediff($t1, $t0);
print "the code took:",timestr($td),"\n";
