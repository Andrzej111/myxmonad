Config {
    font = "xft:Fixed-8",
    bgColor = "#000000",
    fgColor = "#ffffff",
    position = Static { xpos = 0, ypos = 0, width = 1600, height = 16 },
    lowerOnStart = True,
    commands = [
        Run Weather "EPKK" ["-t","<tempC>C <skyCondition>","-L","64","-H","77","-n","#CEFFAC","-h","#FFB6B0","-l","#96CBFE"] 36000,
        Run MultiCpu ["-t","Cpu: <total0> <total1> <total2> <total3>","-L","30","-H","60","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC","-w","3"] 10,
        Run Memory ["-t","M: <usedratio>%","-H","8192","-L","4096","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10,
        Run Swap ["-t","Swap: <usedratio>%","-H","1024","-L","512","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10,
        Run Com "volume" [""] "volume" 10,
        Run Network "wlan0" ["-t","Net: <rx>/ <tx>","-H","200","-L","10","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10,
        Run Com "/bin/bash" ["-c", "~/.xmonad/bin/volume"] "vol" 10,
        Run Com "/bin/bash" ["-c", "~/.xmonad/bin/music"] "muss" 3,
        Run Com "/bin/bash" ["-c", "~/.xmonad/bin/battery"] "batt" 10,
        Run Com "/bin/bash" ["-c", "~/.xmonad/bin/wlan0_ip"] "ip" 600,
        Run Date "%b %_d %a %k:%M:%S" "date" 10,
        Run UnsafeStdinReader
    ],
    sepChar = "%",
    alignSep = "}{",
    template = "%UnsafeStdinReader% }   <action=`mpc toggle`>%muss%</action> {<fc=#FFCCAA>%date%</fc> V: %vol% B: %batt% %memory% %wlan0% <action=`wicd-curses`>%ip%</action>"
}
