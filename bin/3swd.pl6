#!/usr/bin/env perl6
use v6;
use warnings;
use strict;
my $window = qx/xdotool getwindowfocus getwindowname/;
if ($window ~~ m/Firefox/) {
    qx/xdotool key ctrl+Page_Down/;
} else {
    qx/xdotool key super+shift+c/;
}


