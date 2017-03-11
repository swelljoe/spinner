
COLORNUM=1
NORMAL=$(tput sgr0)
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

while :; do
  for c in ${SYMBOLS}; do
    if [ $COLORNUM -eq 7 ]; then
      COLORNUM=1
    else
      COLORNUM=$((COLORNUM+1))
    fi
    COLOR=$(tput setaf ${COLORNUM})
    printf '\b%s' "${COLOR}$c${NORMAL}" 
    [ -f results ] && { printf '\n'; break 2; }
    env sleep .4
  done
done
