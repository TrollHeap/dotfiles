
for i in $(cat brew_list.txt); do
  brew install $i
done
