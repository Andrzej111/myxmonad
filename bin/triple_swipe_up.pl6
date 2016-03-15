#!/usr/bin/env perl6

my $window = qx/xdotool getwindowfocus getwindowname/;
if ($window ~~ m/Firefox/) {
    qx/xdotool key ctrl+Page_Up/;
} else {
    qx/xdotool key super+Return/;
}
