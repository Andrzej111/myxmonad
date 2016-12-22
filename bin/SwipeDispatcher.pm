#!/usr/bin/perl
use v5.18;
use POSIX ":sys_wait_h";
use threads ('yield',
             'stack_size' => 64*4096,
             'exit' => 'threads_only',
             'stringify');
package SwipeDispatcher;

my $window = `xdotool getwindowfocus getwindowname`;
my $workspace = `xdotool get_desktop`;
my $mouse = `xdotool getmouselocation`;
my %mouse_l;
given ($mouse) {
    m/x\:(\d+)\s+y\:(\d+)\s+screen\:(\d+)\s+window\:(\d+)/;
    $mouse_l{x} = $1;
    $mouse_l{y} = $2;
    $mouse_l{s} = $3;
    $mouse_l{w} = $4;
}

$_ = $window;
sub fork_and_run {
    my $command = shift @_;
    my $thr = threads->create( sub {`$command`;});
    $thr->detach();
}

sub ddefault {
    given (shift @_) {
        `xdotool key ctrl+alt+Right` when m/3left/;
        `xdotool key ctrl+alt+Left` when m/3right/;
    }
}

sub ncmpcpp {
    given (shift @_) {
        `mpc prev` when m/3up/;
        `mpc next` when m/3down/;
        `mpc toggle` when m/3press/;
        `exec gnome-terminal -t ncmpcpp -e ncmpcpp` when m/run/;
        default { ddefault $_; }
    }
}

sub bar {
    given (shift @_) {
        `amixer -q set Master unmute && amixer -q set Master 5%+` when m/3right/;
        `amixer -q set Master 5%-` when m/3left/;
        default { ncmpcpp $_; }
    }
}

sub pycharm {
    given (shift @_) {
        `xdotool key ctrl+Page_Up` when m/3up/;
        `xdotool key ctrl+Page_Down` when m/3down/;
        default { ddefault $_; }
    }
}

sub firefox {
    given (shift @_) {
        `xdotool key ctrl+Page_Up` when m/3up/;
        `xdotool key ctrl+Page_Down` when m/3down/;
        `xdotool key ctrl+w` when m/3press/;
        `exec firefox` when m/run/;
        default { ddefault $_; }
    }
}

sub vim {
    given (shift @_) {
        `xdotool key Escape+Escape+space+h` when m/3up/;
        `xdotool key Escape+Escape+space+l` when m/3down/;
        default { ddefault $_; }
    }
}

sub terminal {
    given (shift @_) {
        `xdotool key alt+shift+k` when m/3up/;
        `xdotool key alt+shift+j` when m/3down/;
        `xdotool key alt+Return` when m/3press/;
        `xdotool key alt+shift+Return` when m/run/;
        default { ddefault $_; }
    }

}

sub thunderbird {
    given (shift @_) {
        fork_and_run("thunderbird") when m/run/; 
        default { ddefault $_; }
    }
}
sub vlc {
    given (shift @_) {
        fork_and_run("vlc") when m/run/;
        default { ddefault $_; }
    }
}



sub dispatcher {
    my $motion = shift @_ ;
    given ($motion){
        if ( $mouse_l{y} < 16 ) { # when swiped on xmobar
            bar $_;
        } elsif ( $window ~~ m/Firefox$/) {
            firefox $_; 
        } elsif ($window ~~ m/Terminal/) {
            terminal $_;
        } elsif ($window ~~ m/ncmpcpp/) {
            ncmpcpp $_;
        } elsif ($window ~~ m/VIM$/) {
            vim $_;
        } elsif ($window ~~ m/^\s*$/ && $motion ~~ m/3press/) { # workspace empty
            given ($workspace) { # first ws is 0
                terminal("run") when /0/;
                firefox("run") when /1/;
                thunderbird("run") when /3/;
                ncmpcpp("run") when /8/;
                default {ddefault $motion; }
            }
        } else {
            ddefault $_;
        }
    }
}
1;
