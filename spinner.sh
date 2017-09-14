#!/bin/sh
# shellcheck disable=SC2034 disable=SC2039
# Config variables, set these after sourcing to change behavior.
SPINNER_COLORNUM=2 # What color? Irrelevent if COLORCYCLE=1.
SPINNER_COLORCYCLE=1 # Does the color cycle?
SPINNER_DONEFILE="stopspinning" # Path/name of file to exit on.
SPINNER_SYMBOLS="UNI_DOTS2" # Name of the variable containing the symbols.
SPINNER_CLEAR=1 # Blank the line when done.

# Handle signals
cleanup () {
	tput rc
	tput cnorm
	return 1
}
# This tries to catch any exit, to reset cursor
trap cleanup INT QUIT TERM

spinner () {
  # Safest option are one of these. Doesn't need Unicode, at all.
  local ASCII_PROPELLER="/ - \\ |"
  local ASCII_PLUS="x +"
  local ASCII_BLINK="o -"
  local ASCII_V="v < ^ >"
  local ASCII_INFLATE=". o O o"

  # Needs Unicode support in shell and terminal.
  # These are ordered most to least likely to be available, in my limited experience.
  local UNI_DOTS="⠋ ⠙ ⠹ ⠸ ⠼ ⠴ ⠦ ⠧ ⠇ ⠏"
  local UNI_DOTS2="⣾ ⣽ ⣻ ⢿ ⡿ ⣟ ⣯ ⣷"
  local UNI_DOTS3="⣷ ⣯ ⣟ ⡿ ⢿ ⣻ ⣽ ⣾"
  local UNI_DOTS4="⠋ ⠙ ⠚ ⠞ ⠖ ⠦ ⠴ ⠲ ⠳ ⠓"
  local UNI_DOTS5="⠄ ⠆ ⠇ ⠋ ⠙ ⠸ ⠰ ⠠ ⠰ ⠸ ⠙ ⠋ ⠇ ⠆"
  local UNI_DOTS6="⠋ ⠙ ⠚ ⠒ ⠂ ⠂ ⠒ ⠲ ⠴ ⠦ ⠖ ⠒ ⠐ ⠐ ⠒ ⠓ ⠋"
  local UNI_DOTS7="⠁ ⠉ ⠙ ⠚ ⠒ ⠂ ⠂ ⠒ ⠲ ⠴ ⠤ ⠄ ⠄ ⠤ ⠴ ⠲ ⠒ ⠂ ⠂ ⠒ ⠚ ⠙ ⠉ ⠁"
  local UNI_DOTS8="⠈ ⠉ ⠋ ⠓ ⠒ ⠐ ⠐ ⠒ ⠖ ⠦ ⠤ ⠠ ⠠ ⠤ ⠦ ⠖ ⠒ ⠐ ⠐ ⠒ ⠓ ⠋ ⠉ ⠈"
  local UNI_DOTS9="⠁ ⠁ ⠉ ⠙ ⠚ ⠒ ⠂ ⠂ ⠒ ⠲ ⠴ ⠤ ⠄ ⠄ ⠤ ⠠ ⠠ ⠤ ⠦ ⠖ ⠒ ⠐ ⠐ ⠒ ⠓ ⠋ ⠉ ⠈ ⠈"
  local UNI_DOTS10="⢹ ⢺ ⢼ ⣸ ⣇ ⡧ ⡗ ⡏"
  local UNI_DOTS11="⢄ ⢂ ⢁ ⡁ ⡈ ⡐ ⡠"
  local UNI_DOTS12="⠁ ⠂ ⠄ ⡀ ⢀ ⠠ ⠐ ⠈"
  local UNI_BOUNCE="⠁ ⠂ ⠄ ⠂"
  local UNI_PIPES="┤ ┘ ┴ └ ├ ┌ ┬ ┐"
  local UNI_HIPPIE="☮ ✌ ☺ ♥"
  local UNI_HANDS="☜ ☝ ☞ ☟"
  local UNI_ARROW_ROT="➫ ➭ ➬ ➭"
  local UNI_CARDS="♣ ♤ ♥ ♦"
  local UNI_TRIANGLE="◢ ◣ ◤ ◥"
  local UNI_SQUARE="◰ ◳ ◲ ◱"
  local UNI_BOX_BOUNCE="▖ ▘ ▝ ▗"
  local UNI_PIE="◴ ◷ ◶ ◵"
  local UNI_CIRCLE="◐ ◓ ◑ ◒"
  local UNI_QTR_CIRCLE="◜ ◝ ◞ ◟"

  # Bigger spinners and progress type bars; takes more space.
  local WIDE_ASCII_PROG="[>----] [=>---] [==>--] [===>-] [====>] [----<] [---<=] [--<==] [-<===] [<====]"
  local WIDE_ASCII_PROPELLER="[|####] [#/###] [##-##] [###\\#] [####|] [###\\#] [##-##] [#/###]"
  local WIDE_ASCII_SNEK="[>----] [~>---] [~~>--] [~~~>-] [~~~~>] [----<] [---<~] [--<~~] [-<~~~] [<~~~~]"
  local WIDE_UNI_GREYSCALE="░░░░░░░ ▒░░░░░░ ▒▒░░░░░ ▒▒▒░░░░ ▒▒▒▒░░░ ▒▒▒▒▒░░ ▒▒▒▒▒▒░ ▒▒▒▒▒▒▒ ▒▒▒▒▒▒░ ▒▒▒▒▒░░ ▒▒▒▒░░░ ▒▒▒░░░░ ▒▒░░░░░ ▒░░░░░░ ░░░░░░░"
  local WIDE_UNI_GREYSCALE2="░░░░░░░ ▒░░░░░░ ▒▒░░░░░ ▒▒▒░░░░ ▒▒▒▒░░░ ▒▒▒▒▒░░ ▒▒▒▒▒▒░ ▒▒▒▒▒▒▒ ░▒▒▒▒▒▒ ░░▒▒▒▒▒ ░░░▒▒▒▒ ░░░░▒▒▒ ░░░░░▒▒ ░░░░░░▒"

  local SPINNER_NORMAL
  SPINNER_NORMAL=$(tput sgr0)

  eval SYMBOLS=\$${SPINNER_SYMBOLS}

  # Get the parent PID
  SPINNER_PPID=$(ps -p "$$" -o ppid=)
  while :; do
    tput civis
    for c in ${SYMBOLS}; do
      if [ $SPINNER_COLORCYCLE -eq 1 ]; then
        if [ $SPINNER_COLORNUM -eq 7 ]; then
          SPINNER_COLORNUM=1
        else
          SPINNER_COLORNUM=$((SPINNER_COLORNUM+1))
        fi
      fi
      local COLOR
      COLOR=$(tput setaf ${SPINNER_COLORNUM})
      tput sc
      env printf "${COLOR}${c}${SPINNER_NORMAL}"
      tput rc
      if [ -f "${SPINNER_DONEFILE}" ]; then
        if [ ${SPINNER_CLEAR} -eq 1 ]; then
          tput el
        fi
        rm ${SPINNER_DONEFILE}
        break 2
      fi
      # This is questionable. sleep with fractional seconds is not
      # always available, but seems to not break things, when not.
      env sleep .2
      # Check to be sure parent is still going; handles sighup/kill
      if [ ! -z "$SPINNER_PPID" ]; then
        # This is ridiculous. ps prepends a space in the ppid call, which breaks
        # this ps with a "garbage option" error.
        # XXX Potential gotcha if ps produces weird output.
        # shellcheck disable=SC2086
        SPINNER_PARENTUP=$(ps --no-headers $SPINNER_PPID)
        if [ -z "$SPINNER_PARENTUP" ]; then
          break 2
        fi
      fi
    done
  done
  tput cnorm
  return 0
}
