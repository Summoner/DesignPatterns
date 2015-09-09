#!/usr/bin/perl -w
use strict;
use warnings;
use Data::Dumper;
use Benchmark;

#**********************************
package AbstractComponent;

sub new {
    my ( $class,@args ) = @_;
    my $self = { @args };
    bless $self,$class;
    return $self->_init( @args );
} ## --- end sub new

sub Name {
    $_[0]->{Name} = $_[1] if defined $_[1];$_[0]->{Name};    
} ## --- end sub Name

sub Add {
    my	( $self )	= @_;
} ## --- end sub Add

sub Remove {
    my	( $self )	= @_;
} ## --- end sub Remove

sub Display {
    my	( $self )	= @_;
} ## --- end sub Display

#**********************************
package Compozite;

use base qw ( AbstractComponent );

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub Add {
    my	( $self,$component )	= @_;
    push @{ $self->{children} },$component;
} ## --- end sub Add

sub Remove {
    my	( $self,$component )	= @_;
    
    for ( my $i = 0; $i <= $#{ $self->{children} }; $i++ ) {
        if ( $self->{children}->[$i] eq $component ){
            splice ( @{ $self->{children} },$i,1 );
            last;
        }
    }
} ## --- end sub Remove

sub Display {
    my	( $self,$depth )	= @_;
    print "-",$depth," ",$self->Name,"\n";

    foreach my $component ( @{ $self->{children} } ) {
        $component->Display( $depth + 2 );
    }
} ## --- end sub Display

#**********************************
package Leaf;

use base qw ( AbstractComponent );

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub Add {
    my	( $self,$component )	= @_;
    print "Cannon add component to leaf\n";
} ## --- end sub Add

sub Remove {
    my	( $self,$component )	= @_;    
    print "Cannon remove component from leaf\n";
} ## --- end sub Remove

sub Display {
    my	( $self,$depth )	= @_;
    print "-", $depth," ",$self->Name,"\n";
} ## --- end sub Display

#**********************************



#!/usr/bin/perl -w
use strict;
use warnings;
use Data::Dumper;
use Benchmark;

my $t0 = new Benchmark;

#open my $input, "/home/fanatic/Summoner/Codeeval-solutions/input.txt" || die "Can't open file: $!\n";
#open my $result, ">D:\\Perl\\output1.txt" || die "Can't open file: $!\n";

my $root = Compozite->new( Name => "Root" );

my $leafA = Leaf->new( Name => "leafA" );
$root->Add( $leafA );

my $leafB = Leaf->new( Name => "leafB" );
$root->Add( $leafB );

my $branch = Compozite->new( Name => "CompoziteX" );
my $leafXA = Leaf->new( Name => "leafXA" );
$branch->Add( $leafXA );

my $leafXB = Leaf->new( Name => "leafXB" );
$branch->Add( $leafXB );

$root->Add( $branch );

my $leafC = Leaf->new( Name => "leafC" );
$root->Add( $leafC );

my $leafD = Leaf->new( Name => "leafD" );
$root->Add( $leafD );

$DB::single = 2;

$root->Display( 1 );



my $t1 = new Benchmark;
my $td = timediff($t1, $t0);
print "the code took:",timestr($td),"\n";
