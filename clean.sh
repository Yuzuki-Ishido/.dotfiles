source stow_folders.sh
for folder in $(echo $(STOW_FOLDERS))
do
  echo "REMOVE $folder"
  stow -D $folder
done
