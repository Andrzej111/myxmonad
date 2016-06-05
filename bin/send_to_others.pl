#!/usr/bin/perl
use v5.18;

my $start_window = `xdotool getwindowfocus`;
my $command = join (' ',@ARGV);
`xdotool key alt+Tab`;
my $window = `xdotool getwindowfocus`;
while ($window ne $start_window){
    `xdotool type '$command'`;
    `xdotool key Return`;
    `xdotool key alt+Tab`;
    $window = `xdotool getwindowfocus`;
#    sleep 1;
};

