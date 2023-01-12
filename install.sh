
# Get directory of script - https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
export DOTFILE_ROOT=$(cd "$(dirname "$0")"; pwd)
ZSHRC=`realpath ${ZROOTDIR:-~}/.zshrc`

COMMENT_TAG="# xiot.dotfile install"
SEPERATOR="# --------------------"
NEW_LINE="\n"

if [ `uname` == "Darwin" ]; then
  export IS_OSX=1
fi

if [[ "$1" == "--force" ]]; then
 export IS_FORCE=1
fi

# install antidote (https://getantidote.github.io/)
if [ ! -d ${ZDOTDIR:-~}"/.antidote" ]
then
  echo "Installing antidote"
  git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote
fi

# Install dependencies
$DOTFILE_ROOT/install-deps.sh

# Include link to files
if ! grep -q "$COMMENT_TAG" "$ZSHRC" ; then

  __contents=`node $DOTFILE_ROOT/scripts/resolve.js $DOTFILE_ROOT/config/template.zsh`  

  echo "Adding link to personal.zsh"  
  
  echo "" >> "$ZSHRC"
  echo $COMMENT_TAG >> "$ZSHRC"  
  echo $SEPERATOR >> "$ZSHRC"
  
  printf "%s" "$__contents" >> "$ZSHRC"
  echo "" >> "$ZSHRC"

  echo $SEPERATOR >> "$ZSHRC"

fi

# Link Plugins
if [ ! -f "$HOME/.zsh_plugins.txt" ]; then
  ln "$DOTFILE_ROOT/config/.zsh_plugins.txt" $HOME/.zsh_plugins.txt
fi

if [ ! -f "$HOME/.p10k.zsh" ]; then
  ln "$DOTFILE_ROOT/config/.p10k.zsh" "$HOME/.p10k.zsh"
fi

# Install node_modules for scripts
if [ ! -d "$DOTFILE_ROOT/scripts/node_modules" ]; then
  echo "INSTALLING NODE_MODULES"
  cd $DOTFILE_ROOT/scripts
  npm install
  cd -
fi

