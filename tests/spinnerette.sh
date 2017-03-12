#!/bin/sh

. ../spinner.sh

printf "Spinner with default settings for five seconds: "
spinner &
sleep 5
touch "stopspinning"

sleep 1

SPINNER_COLORCYCLE=0
SPINNER_COLORNUM=2
SPINNER_DONEFILE="donespinning"
SPINNER_SYMBOLS="ASCII_PLUS"
printf "Spinner with some custom settings for five seconds: "
spinner &
sleep 5
touch "donespinning"

sleep 1
