TASKPAPER_STYLES_DIR=$HOME/Library/Containers/com.hogbaysoftware.TaskPaper3/Data/Library/Application\ Support/TaskPaper/StyleSheets
if [[ -d $TASKPAPER_STYLES_DIR ]] ; then
    echo "Adding taskpaper styles"
    rsync -ar "$TASKPAPER_STYLES_DIR/" "$DOTFILES/modules/taskpaper/styles"
fi
