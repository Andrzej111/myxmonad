#!/usr/bin/env perl
use v5.18;
use warnings;
use strict;
my $window = `xdotool getwindowfocus getwindowname`;
say $window;
$_ = $window;
if (m/Firefox/) {
    `xdotool key ctrl+Page_Down`;
} else {
    `xdotool key alt+shift+c`;
}


