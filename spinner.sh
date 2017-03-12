
# Safest option are one of these. Doesn't need Unicode, at all.
ASCII_LINE="/ - \\ \|"
ASCII_PLUS="x +"
ASCII_SPLAT='. o O @ \*'
ASCII_BLINK="o -"
ASCII_V="v < ^ >"
ASCII_INFLATE=". o O o"

# Needs Unicode support in shell and terminal.
# These are ordered most to least likely to be available, in my limited experience.
UNI_BRAILLE="⠋ ⠙ ⠹ ⠸ ⠼ ⠴ ⠦ ⠧ ⠇ ⠏"
UNI_BRAILLE2="⣷ ⣯ ⣟ ⡿ ⢿ ⣻ ⣽ ⣾"
UNI_BRAILLE2_COUNTER="⣾ ⣽ ⣻ ⢿ ⡿ ⣟ ⣯ ⣷"
UNI_BOUNCE="⠁ ⠂ ⠄ ⡀ ⢀ ⠠ ⠐ ⠈"
UNI_HIPPIE="☮ ✌ ☺ ♥"
UNI_HANDS="☜ ☝ ☞ ☟"
UNI_ARROW_ROT="➫ ➭ ➬ ➭"
UNI_CARDS="♣ ♤ ♥ ♦"
UNI_TRIANGLE="◢ ◣ ◤ ◥"
UNI_SQUARE="◰ ◳ ◲ ◱"
UNI_PIE="◴ ◷ ◶ ◵"
UNI_CIRCLE="◐ ◓ ◑ ◒"
UNI_QTR_CIRCLE="◜ ◝ ◞ ◟" 

SYMBOLS=$UNI_BRAILLE2
COLORNUM=3
NORMAL=$(tput sgr0)
COLORCYCLE=0

while :; do
  tput civis
  for c in ${SYMBOLS}; do
    if [ $COLORCYCLE -eq 1 ]; then
      if [ $COLORNUM -eq 7 ]; then
        COLORNUM=1
      else
        COLORNUM=$((COLORNUM+1))
      fi
    fi
    COLOR=$(tput setaf ${COLORNUM})
    tput sc
    env printf "${COLOR}${c}${NORMAL}"
    tput rc
    [ -f results ] && { printf '\n'; break 2; }
    env sleep .4
  done
  tput cnorm
done
