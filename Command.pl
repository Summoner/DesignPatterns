#!/usr/bin/perl -w
use strict;
use warnings;
use Data::Dumper;
use Benchmark;

#**********************************
package AbstractCommand;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub Execute {
    my	( $self )	= @_;
    return;
} ## --- end sub Execute

sub UnExecute {
    my	( $self )	= @_;
    return;
} ## --- end sub UnExecute

#**********************************
package CalculatorCommand;
use base qw ( AbstractCommand );

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

sub Operator {
    $_[0]->{operator} = $_[1] if defined $_[1];$_[0]->{operator};
} ## --- end sub Operator

sub Operand {
    $_[0]->{operand} = $_[1] if defined $_[1];$_[0]->{operand};
} ## --- end sub Operand

sub Calculator {
    $_[0]->{calculator} = $_[1] if defined $_[1];$_[0]->{calculator};
} ## --- end sub Calculator

sub Execute {
    my	( $self )	= @_;
    $self->Calculator->Operation( $self->Operator,$self->Operand );
} ## --- end sub Execute

sub UnExecute {
    my	( $self )	= @_;
    $self->Calculator->Operation( $self->Undo( $self->Operator ),$self->Operand );
} ## --- end sub UnExecute

sub Undo {
    my	( $self,$operator )	= @_;

    my %operators = ();
    $operators{"+"} = "-";
    $operators{"-"} = "+";
    $operators{"/"} = "*";
    $operators{"*"} = "/";

    return $operators{ $operator };
} ## --- end sub Undo

#**********************************
package Calculator;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

my $current = 0;

sub Operation {
    my	( $self,$operator,$operand )	= @_;

    my %operations = ();
    $operations{"+"} = sub{ $current += $operand };
    $operations{"-"} = sub{ $current -= $operand };
    $operations{"/"} = sub{ $current /= $operand };
    $operations{"*"} = sub{ $current *= $operand };

    $current = &{ $operations{ $operator } };

    print "Current value = $current following $operator and $operand\n";
}
#**********************************

package User;

sub new {
    my $class = shift;
    my $self = {@_};
    bless $self,$class;
    return $self;
} ## --- end sub new

my $_calculator = Calculator->new();
my @Commands = ();
my $_current = 0;

sub Redo {
    my	( $self,$levels )	= @_;

    print "Redo: $levels levels\n";

    for ( my $i = 0; $i < $levels; $i++ ) {

        if ( $_current < scalar @Commands - 1 ){

            my $command = $Commands[$_current++];

            $command->Execute();
        }
    }
}

sub Undo {
    my	( $self,$levels )	= @_;

    print "Undo: $levels levels\n";

    for ( my $i = 0; $i < $levels; $i++ ) {

        if ( $_current > 0 ){

            my $command = $Commands[--$_current];
            $command->UnExecute();
        }
    }
}

sub Compute {
    my	( $self,$operator,$operand )	= @_;

    my $command = CalculatorCommand->new( calculator => $_calculator,operator => $operator,operand => $operand );
    $command->Execute();

    push @Commands,$command;
    $_current++;
} ## --- end sub Compute

#**********************************






#!/usr/bin/perl -w
use strict;
use warnings;
use Data::Dumper;
use Benchmark;

my $t0 = new Benchmark;

#open my $input, "/home/fanatic/Summoner/Codeeval-solutions/input.txt" || die "Can't open file: $!\n";
#open my $result, ">D:\\Perl\\output1.txt" || die "Can't open file: $!\n";

my $user = User->new();
$user->Compute("+",100);
$user->Compute("-",50);
$user->Compute("/",2);
$user->Compute("*",10);

$user->Undo(4);
$user->Redo(3);

my $t1 = new Benchmark;
my $td = timediff($t1, $t0);
print "the code took:",timestr($td),"\n";
