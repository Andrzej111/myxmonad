module mySwipes;
sub triple_up is export(:MANDATORY) {
    my $window = qx/xdotool getwindowfocus getwindowname/;
    if ($window ~~ m/Firefox/) {
	qx/xdotool key ctrl+Page_Up/;
    } else {
	qx/xdotool key super+Return/;
    }
}
sub triple_down is export(:MANDATORY) {
    my $window = qx/xdotool getwindowfocus getwindowname/;
    if ($window ~~ m/Firefox/) {
	qx/xdotool key ctrl+Page_Down/;
    } else {
	qx/xdotool key super+shift+c/;
    }

}

