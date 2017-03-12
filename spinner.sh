# Config variables, set these after sourcing to change behavior.
SPINNER_COLORNUM=2 # What color? Irrelevent if COLORCYCLE=1.
SPINNER_COLORCYCLE=1 # Does the color cycle?
SPINNER_DONEFILE="stopspinning" # Path/name of file to exit on.
SPINNER_SYMBOLS="UNI_BRAILLE2" # Name of the variable containing the symbols.

spinner () {
  # Safest option are one of these. Doesn't need Unicode, at all.
  local ASCII_LINE="/ - \\ \|"
  local ASCII_PLUS="x +"
  local ASCII_SPLAT='. o O @ \*'
  local ASCII_BLINK="o -"
  local ASCII_V="v < ^ >"
  local ASCII_INFLATE=". o O o"

  # Needs Unicode support in shell and terminal.
  # These are ordered most to least likely to be available, in my limited experience.
  local UNI_BRAILLE="⠋ ⠙ ⠹ ⠸ ⠼ ⠴ ⠦ ⠧ ⠇ ⠏"
  local UNI_BRAILLE2="⣷ ⣯ ⣟ ⡿ ⢿ ⣻ ⣽ ⣾"
  local UNI_BRAILLE2_COUNTER="⣾ ⣽ ⣻ ⢿ ⡿ ⣟ ⣯ ⣷"
  local UNI_BOUNCE="⠁ ⠂ ⠄ ⡀ ⢀ ⠠ ⠐ ⠈"
  local UNI_HIPPIE="☮ ✌ ☺ ♥"
  local UNI_HANDS="☜ ☝ ☞ ☟"
  local UNI_ARROW_ROT="➫ ➭ ➬ ➭"
  local UNI_CARDS="♣ ♤ ♥ ♦"
  local UNI_TRIANGLE="◢ ◣ ◤ ◥"
  local UNI_SQUARE="◰ ◳ ◲ ◱"
  local UNI_PIE="◴ ◷ ◶ ◵"
  local UNI_CIRCLE="◐ ◓ ◑ ◒"
  local UNI_QTR_CIRCLE="◜ ◝ ◞ ◟" 

  local NORMAL=$(tput sgr0)

  eval SYMBOLS=\$${SPINNER_SYMBOLS}

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
      local COLOR=$(tput setaf ${SPINNER_COLORNUM})
      tput sc
      env printf "${COLOR}${c}${NORMAL}"
      tput rc
      if [ -f "${SPINNER_DONEFILE}" ]; then
        printf '\n'
	rm ${SPINNER_DONEFILE}
	break 2
      fi
      env sleep .4
    done
  done
  tput cnorm
}
