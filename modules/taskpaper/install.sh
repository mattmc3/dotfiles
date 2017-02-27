TASKPAPER_STYLES_DIR=$HOME/Library/Containers/com.hogbaysoftware.TaskPaper3/Data/Library/Application\ Support/TaskPaper/StyleSheets
if [[ -d $TASKPAPER_STYLES_DIR ]] ; then
    echo "Installing taskpaper styles"
    rsync -ar "$DOTFILES/modules/taskpaper/styles/" "$TASKPAPER_STYLES_DIR"
fi
