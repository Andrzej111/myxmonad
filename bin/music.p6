#!/usr/bin/env perl6

my $TCOL="cyan";        # The colour to be used to draw the song title when playing
my $ACOL="lightgreen";    # The colour to be used to draw the song artist when playing
my $PCOL="darkred";      # The colour to be used to draw both the song title and artist when paused
my $OCOL="brown";
my @lines = lines qq:x/mpc/;
my $current = chomp qq:x/mpc current/;
$current .= chop($current.elems - 50);
if @lines <=1 || @lines[1] ~~ m/\[paus/ {
    say "<fc=$PCOL>"~$current~"</fc>" ;
    exit;
};
@lines[*-1] ~~ m/
    volume\:\s*\d*\%\s*
    repeat\:\s*(\w+)\s*
    random\:\s*(\w+)\s*
    single\:\s*(\w+)\s*
    consume\:\s*(\w+)\s*
/;
my $match = $/;
my $options = "";
try {
    my Bool $repeat = so $match[0] ~~ m/on/;
    my Bool $random = so $match[1] ~~ m/on/;
    my Bool $single = so $match[2] ~~ m/on/;
    my Bool $consume = so $match[3] ~~ m/on/;
    $options = "[{"r" if $repeat}{"z" if $random}{"s" if $single}{"c" if $consume}]";
};
my @split = $current.split("-");
if @split {
    say "<fc="~$ACOL~">"~@split[0]~"</fc> - "~"<fc="~$TCOL~">"~@split[1]~"</fc> <fc="~$OCOL~">"~$options~"</fc>";
} else {
    say "<fc="~$TCOL~">"~$current~"</fc><fc="~$OCOL~">"~$options~"</fc>";
}
