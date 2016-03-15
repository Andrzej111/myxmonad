#!/usr/bin/env perl
use v5.18;
my $window = `xdotool getwindowfocus getwindowname`;
say $window;
$_ = $window;
if (m/Firefox/) {
    `xdotool key ctrl+Page_Up`;
} else {
    `xdotool key super+Return`;
}
