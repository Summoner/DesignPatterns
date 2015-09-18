#!/usr/bin/perl -w
use strict;
use warnings;
use Data::Dumper;
use Benchmark;

#**********************************
package AbstractCharacter;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub Symbol{
    $_[0]->{symbol} = $_[1] if defined $_[1];$_[0]->{symbol};
} ## --- end sub Symbol

sub Width{
    $_[0]->{width} = $_[1] if defined $_[1];$_[0]->{width};
} ## --- end sub Width

sub Heigth{
    $_[0]->{heigth} = $_[1] if defined $_[1];$_[0]->{heigth};
} ## --- end sub Heigth

sub Ascent{
    $_[0]->{ascent} = $_[1] if defined $_[1];$_[0]->{ascent};
} ## --- end sub Ascent

sub Descent{
    $_[0]->{descent} = $_[1] if defined $_[1];$_[0]->{descent};
} ## --- end sub Descent

sub PointSize{
    $_[0]->{pointsize} = $_[1] if defined $_[1];$_[0]->{pointsize};
} ## --- end sub PointSize

sub Display {
    my	( $self )	= @_;
    return;
} ## --- end sub Display

#**********************************

package CharacterA;
use base qw ( AbstractCharacter );

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    $self->Symbol("A");
    $self->Heigth(100);
    $self->Width(120);
    $self->Ascent(70);
    $self->Descent(0);
    return $self;
} ## --- end sub new

sub Display {
    my	( $self,$pointSize )	= @_;
    $self->PointSize( $pointSize );
    print $self->Symbol," (pointsize ",$self->PointSize,")\n";
} ## --- end sub Display

#**********************************

package CharacterB;
use base qw ( AbstractCharacter );

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    $self->Symbol("B");
    $self->Heigth(100);
    $self->Width(140);
    $self->Ascent(72);
    $self->Descent(0);
    return $self;
} ## --- end sub new

sub Display {
    my	( $self,$pointSize )	= @_;
    $self->PointSize( $pointSize );
    print $self->Symbol," (pointsize ",$self->PointSize,")\n";
} ## --- end sub Display

#**********************************

package CharacterFactory;

sub new {
    my $class	= shift;
    my $self = {};
    bless $self,$class;
    return $self;
} ## --- end sub new

    my $_objects = {};
    my $a = CharacterA->new();
    my $b = CharacterB->new();

    $_objects->{"A"} = $a;
    $_objects->{"B"} = $b;

sub Characters {
    my	( $self,$key,$character )	= @_;
    if ( defined $key && defined $character ){

        $self->{characters}->{$key} = $character;
    }
    return $self->{characters};
} ## --- end sub Characters


sub CharactersObjects {
    my	( $self,$key )	= @_;

    my $objectForReturn = $_objects->{$key};
    return $objectForReturn;
} ## --- end sub CharactersObjects

sub GetCharacter {
    my	( $self,$key )	= @_;
    my $characters = $self->Characters();
    my $character = $characters->{$key};

    unless( defined $character ){

        $character = $self->CharactersObjects( $key );
        $self->Characters( $key,$character );
    }
    return $character;
} ## --- end sub GetCharacter

#**********************************

#!/usr/bin/perl -w
use strict;
use warnings;
use Data::Dumper;
use Benchmark;

my $t0 = new Benchmark;

#open my $input, "/home/fanatic/Summoner/Codeeval-solutions/input.txt" || die "Can't open file: $!\n";
#open my $result, ">D:\\Perl\\output1.txt" || die "Can't open file: $!\n";

my $doc = "AABA";
my @docSymbols = split //,$doc;
my $pointSize = 10;
my $f = CharacterFactory->new();

foreach my $symbol ( @docSymbols ) {

    $pointSize++;
    my $c = AbstractCharacter->new();
    $c = $f->GetCharacter( $symbol );
    $c->Display( $pointSize );
}

my $t1 = new Benchmark;
my $td = timediff($t1, $t0);
print "the code took:",timestr($td),"\n";
