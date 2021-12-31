#!/usr/bin/sh

dir="$HOME/.config/polybar/manas"

launch_bar() {
    killall -q polybar
    while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

    polybar -q mid -c "$dir/config.ini" &
    polybar -q left -c "$dir/config.ini" &
    polybar -q my_right -c "$dir/config.ini" &


    polybar -q monitor_mid -c "$dir/config.ini" &
    polybar -q monitor_left -c "$dir/config.ini" &
    polybar -q monitor_right -c "$dir/config.ini" &
}

launch_bar
