# File: ~/.zshrc

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    ######################################
    history
    jsontools
    safe-paste
    copypath
    ######################################
    command-not-found
    sudo
    systemadmin
    ssh-agent
    ######################################
    colorize
    themes
    ######################################
    # last-working-dir
    # per-directory-history
    ######################################
    zsh-completions
    zsh-interactive-cd
    zsh-navigation-tools
    zsh-autosuggestions
    zsh-syntax-highlighting
    fast-syntax-highlighting
    zsh-history-substring-search # load after zsh-syntax-highlighting
    ######################################
    fzf
    poetry
    ######################################
    auto-color-ls
    autoupdate
    ######################################
    zsh-bat
    zsh-safe-rm
    ######################################
)

# zsh-completions
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

source $ZSH/oh-my-zsh.sh

# User configuration
# You may need to manually set your language environment
export LANG=ko_KR.UTF-8
export LC_MESSAGES=POSIX

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Example aliases
alias zshconfig="nano ~/.zshrc"
alias ohmyzsh="nano ~/.oh-my-zsh"

##############################################################################################
# Plugins

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# colorls
source $(dirname $(gem which colorls))/tab_complete.sh
alias lc='colorls -lA --sd'
alias ls='colorls'

##############################################################################################
# History

[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
HISTORY_IGNORE="(l|ls|ls *|la|la *|lc|cd|cd -|cd *|pwd|history|history-delete|hsd)"

setopt HIST_IGNORE_DUPS         # don't record an entry that was just recorded again.
setopt HIST_IGNORE_SPACE        # remove command line from history when first character is a space
setopt HIST_REDUCE_BLANKS       # remove unnecessary blanks
setopt HIST_EXPIRE_DUPS_FIRST   # delete duplicates first when HISTSIZE is exceeded
setopt HIST_SAVE_NO_DUPS        # don't write duplicate entries in the history file
setopt INC_APPEND_HISTORY_TIME  # append command to history file immediately after execution
setopt EXTENDED_HISTORY         # record command start time
setopt EXTENDED_GLOB

# https://github.com/junegunn/fzf/issues/3522#issuecomment-1872415948
history-delete() {
  local +h HISTORY_IGNORE=
  local -a ignore
  fc -pa "$HISTFILE"
  selection=$(fc -rl 1 |
        awk '{ cmd=$0; sub(/^[ \t]*[0-9]+\**[ \t]+/, "", cmd); if (!seen[cmd]++)  print $0}' |
        fzf --multi --bind 'ctrl-a:toggle-all,enter:become:echo {+f1}' --header="Tab: select, Ctrl+a: toggle all, Enter: confirm, Esc: quit" --prompt="Search: " --no-sort --cycle
      )
  if [ -n "$selection" ]; then
    while IFS= read -r line; do ignore+=("${(b)history[$line]}"); done < "$selection"
    HISTORY_IGNORE="(${(j:|:)ignore})"
    # Write history excluding lines that match `$HISTORY_IGNORE` and read new history.
    fc -W && fc -p "$HISTFILE"
  else
    echo "Nothing deleted from history"
  fi
}
alias hsd=history-delete

##############################################################################################
