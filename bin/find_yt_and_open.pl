#!/usr/bin/perl
use v5.18;
my $uri ='';
while (my $x = shift @ARGV){
    $uri=$uri.$x.'+';
}
$_ = $uri;
#`xdotool search --name firefox windowkill`;

s/.$//;
#split @ARGV;
my @response = `curl -k https://www.youtube.com/results?search_query=$_`;
#print 'd' for @response;
for (@response){
    chomp; 
    next unless m/yt-lockup-content/;
    m/a\shref=\"(\S+)"/; 
    if (length($1)>10 && length($1)<40){
        system("firefox --no-remote youtube.com$1 &");
        exit;
    }

}
