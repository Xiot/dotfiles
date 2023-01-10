
CONFIG_DIR=$(cd "$(dirname "$0")"; pwd)
DOTFILES_ROOT=`dirname "$CONFIG_DIR"`

export EDITOR="code --wait"
alias ports="sudo lsof -PiTCP -sTCP:LISTEN"
alias ts="node $DOTFILES_ROOT/scripts/ts.js"

# Use `jq` with both JSON and non-JSON lines.
function jjq {
    jq -R -r "${1:-.} as \$line | try fromjson catch \$line"
}

# EXAMPLES
# These are refrerences on how to accomplish certian tasks
# Not needed currently.

# Example of how to set profile and connect to tmux
# function connect-pod() {
#     echo -e "\033]50;SetProfile=DevPod\a"
#     ssh -t tchrs.devpod-us-or "tmux -CC attach || tmux -CC"
# }

# SSH Tunnel
# ssh -fNL 3000:localhost:3000 tchrs.devpod-us-or