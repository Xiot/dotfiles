
# Get directory of script - https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
# SCRIPT_DIR=`greadlink -f ${BASH_SOURCE[0]} || readlink -f ${BASH_SOURCE[0]}`
# SCRIPT_DIR=`dirname $SCRIPT_DIR`
DOTFILE_ROOT=$(cd "$(dirname "$0")"; pwd)

COMMENT_TAG="# xiot.dotfile install"
SEPERATOR="# --------------------"
NEW_LINE="\n"

IS_FORCE="0"
if [[ "$1" == "--force" ]]; then
 IS_FORCE="1"
fi


# install antidote (https://getantidote.github.io/)
if [ ! -d ${ZDOTDIR:-~}"/.antidote" ]
then
  echo "Installing antidote"
  git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote
fi

ZSHRC=`realpath ${ZROOTDIR:-~}"/.zshrc"`

# Include link to files
if ! grep -q "$COMMENT_TAG" "$ZSHRC" ; then

  echo "Adding link to personal.zsh"  
  
  echo "" >> "$ZSHRC"
  echo $COMMENT_TAG >> "$ZSHRC"  
  echo $SEPERATOR >> "$ZSHRC"
  echo "source \"$DOTFILE_ROOT/config/personal.zsh\"" >> "$ZSHRC"
  echo "source ${ZDOTDIR:-~}/.antidote/antidote.zsh" >> "$ZSHRC"

  echo "antidote load"
  echo $SEPERATOR >> "$ZSHRC"

fi

# Link Plugins
if [ ! -f "$HOME/.zsh_plugins.txt" ]; then
  ln "$DOTFILE_ROOT/config/.zsh_plugins.txt" $HOME/.zsh_plugins.txt
fi

# Install node_modules for scripts
if [ ! -d "$DOTFILE_ROOT/scripts/node_modules" ]; then
  echo "INSTALLING NODE_MODULES"
  cd $DOTFILE_ROOT/scripts
  npm install
  cd -
fi

