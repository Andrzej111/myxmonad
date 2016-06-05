#!/usr/bin/perl
use v5.18;
my %commands = (
    '1' => 'play',
    '2' => 'pause',
    '3' => 'stop',
    '4' => 'next',
    '5' => 'prev'
    );
my @elements;
push @elements, $_ while ($_ = shift @ARGV);
my $search_string = join (' ',@elements);
if (length($elements[0]) == 1 && grep (/^$elements[0]$/,keys %commands)){
    `mpc $commands{$elements[0]}`;
    exit;
} 
`killall firefox`;
`mpc stop`;
my @search = `mpc search any "$search_string"`;
say @search;

if (scalar (@search) >0){
    for (@search){
        chomp; 
        `mpc add "$_"`; 
    }
    my $num = `mpc playlist | wc -l`; 
    chomp $num; 
    $num=$num-$#search; 
    say $num;
    `mpc play $num`;
} else {
    `find_yt_and_open.pl $search_string`;
}
#mpc search any "$1" | perl -nE 'chomp; say;'
