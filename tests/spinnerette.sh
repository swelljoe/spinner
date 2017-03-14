#!/bin/sh

. ../spinner.sh

SPINNER_DONEFILE="donespinning"

clear
# Run one with color cycling, just for fun
printf "Default spinner and settings: "
spinner &
sleep 5
touch "donespinning"
sleep 1
printf "\n"

# Turn of color cycling, as it can make it harder to see the design
SPINNER_COLORCYCLE=0
SPINNER_COLORNUM=1

run_test () {
  SPINNER_SYMBOLS=$1
  # Auto cycle through colors
  if [ $SPINNER_COLORNUM -eq 7 ]; then
    SPINNER_COLORNUM=1
  else
    SPINNER_COLORNUM=$((SPINNER_COLORNUM+1))
  fi

  printf "${SPINNER_SYMBOLS}: "
  spinner &
  sleep 5
  touch "donespinning"
  sleep 1
  printf "\n"
}

clear
echo "Single character ASCII spinners"
for s in ASCII_PROPELLER ASCII_PLUS ASCII_BLINK ASCII_INFLATE ASCII_V; do
  run_test ${s}
done
 
clear
echo "Single character Unicode spinners"
for s in UNI_DOTS UNI_DOTS2 UNI_DOTS3 UNI_DOTS4 UNI_DOTS5 UNI_DOTS6 UNI_DOTS7 UNI_DOTS8 UNI_DOTS9 UNI_DOTS10 UNI_DOTS11 UNI_DOTS12 UNI_BOUNCE UNI_PIPES UNI_ARROW_ROT; do
  run_test ${s}
done

clear
echo "Wide ASCII spinners"
for s in WIDE_ASCII_PROG WIDE_ASCII_PROPELLER WIDE_ASCII_SNEK; do
  run_test ${s}
done

clear
echo "Wide Unicode spinners"
for s in WIDE_UNI_GREYSCALE; do
  run_test ${s}
done
