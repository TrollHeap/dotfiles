s=("Howdy my Sigma!" "Consider taking a bath?" "Arch is so GOATed UwU" "VScode > Neovim FrFr")
scripttext=~/.config/hypr/scripts/text_animation/scripttext
ptx=0

while [ $ptx -lt ${#s[@]} ]; do
    ans=""
    for ((i = 0; i < ${#s[ptx]}; i++)); do
        ans+="${s[ptx]:i:1}"
	echo "$ans"
        echo "$ans" > "$scripttext"
        sleep 0.3
    done
    sleep 10
    for ((i = ${#s[ptx]} - 1; i >= 0; i--)); do
        ans="${ans:0:i}"
	echo "$ans"
        echo "$ans" > "$scripttext"
        sleep 0.3
    done
    ptx=$((ptx + 1))
    if [ $ptx -eq ${#s[@]} ]; then
        ptx=0
    fi
done
