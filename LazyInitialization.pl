#**********************************
package BigObject;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    print "BigObject exemplar has been created\n";
    return $self;
} ## --- end sub new

my $_instance = undef;

sub GetInstance {
    my	( $class )	= @_;

    unless ( defined $_instance ){
        {
            lock( $_instance );
            unless ( defined $_instance ){
                $_instance = BigObject->new();
            }
        }   
    }
    return $_instance;
} ## --- end sub GetInstance
#**********************************
#!/usr/bin/perl -w
use strict;
use warnings;
use Data::Dumper;
use Benchmark;

my $t0 = new Benchmark;

#open my $input, "/home/fanatic/Summoner/Codeeval-solutions/input.txt" || die "Can't open file: $!\n";
#open my $result, ">D:\\Perl\\output1.txt" || die "Can't open file: $!\n";

print "First attend to BigObject\n";
my $firstInstance = BigObject->GetInstance();
print Dumper \$firstInstance;

print "Second attend to BigObject\n";
my $secondInstance = BigObject->GetInstance();
print Dumper \$secondInstance;

my $t1 = new Benchmark;
my $td = timediff($t1, $t0);
print "the code took:",timestr($td),"\n";
