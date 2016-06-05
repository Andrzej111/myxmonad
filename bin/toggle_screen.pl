#!/usr/bin/env perl
use v5.18;
# number of active screens
$_ = `xrandr | grep \\* | wc -l`;
chomp;
say;
if (m/1/) {
    `xrandr --output LVDS2 --primary --auto --output VGA2 --right-of LVDS2 --auto`;
    `xmonad --restart`;
} else {
    `xrandr --output LVDS2  --primary --auto --output VGA2 --off`;
    `xmonad --restart`;
}
