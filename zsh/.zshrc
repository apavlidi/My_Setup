# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"        


# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=( command-not-found z zsh-autosuggestions )
plugins+=( node npm git )
plugins+=( docker docker-compose )


source $ZSH/oh-my-zsh.sh

# Random emoji prompt
_emojis=(🐶 🐱 🦊 🐻 🐼 🐨 🦁 🐯 🐸 🐙 🦋 🌈 🍕 🚀 🎸 🌊 🔥 ⚡ 🎯 🍀)
_random_emoji=${_emojis[$RANDOM % ${#_emojis[@]}]}
PROMPT="${_random_emoji} %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi


# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
export NVM_DIR="$HOME/.nvm"
# Lazy-load nvm: only initialise on first use of nvm/node/npm/npx
_nvm_load() {
  unset -f nvm node npm npx
  [ -s "${HOMEBREW_PREFIX}/opt/nvm/nvm.sh" ] && . "${HOMEBREW_PREFIX}/opt/nvm/nvm.sh"
  [ -s "${HOMEBREW_PREFIX}/opt/nvm/etc/bash_completion.d/nvm" ] && . "${HOMEBREW_PREFIX}/opt/nvm/etc/bash_completion.d/nvm"
}
nvm()  { _nvm_load; nvm  "$@"; }
node() { _nvm_load; node "$@"; }
npm()  { _nvm_load; npm  "$@"; }
npx()  { _nvm_load; npx  "$@"; }
[ -f ${GOPATH}/src/github.com/monzo/starter-pack/zshrc ] && source $HOME/src/github.com/monzo/starter-pack/zshrc
alias monzo='cd ~/src/github.com/monzo/worktrees/wearedev'

export EDITOR=nano
export VISUAL="$EDITOR"
export JAVA_HOME=$(/usr/libexec/java_home -v 19)
# ANDROID_HOME is used by gradle when an sdk path is not specified in another way
export ANDROID_HOME="$HOME/Library/Android/sdk"
# Add this line in addition to any other changes to the PATH already in the .zshrc file
export PATH="$ANDROID_HOME/emulator":"$ANDROID_HOME/tools":"$ANDROID_HOME/platform-tools":$PATH
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"


worktree() {
	# This shell function is provided by Monzo's Worktree tool.
	# It wraps the 'worktree' command to change the shell's working
	# directory.
	#
	# github.com/monzo/wearedev/tools/worktree

  if [[ "$1" == "path" ]] && ! [ -x "$(command -v worktree)" ]; then
    # Worktree should be installed by Monzo Developer Tools but I
    # imagine it's possible to depend on 'worktree path wearedev'
    # before it's installed. This path is hard coded to the path
    # set by the engineering onboarding scripts, and attempts to
    # use the project argument, or "wearedev" if none is given.
    echo "$GOPATH/src/github.com/monzo/${2:-wearedev}"
    return $?
  fi

  case "$1" in
    path|shell)
      # These commands never require the tmp file so don't bother creating it.
      # Especially a concern for the path command as it's used so frequently.
      command worktree "$@"
      return $?;;
  esac

  local tempfile=$(mktemp "${TMPDIR:-/tmp/}worktree.XXXXXX")
  command worktree "$@" --tmp-output="$tempfile"
  local exit_code=$?

  if [[ $exit_code -eq 0 && -e $tempfile ]]; then
    local worktree_path=$(command head -1 "$tempfile")
    cd "$worktree_path"
  fi

  return $exit_code
}

# Override git_prompt_info to show git:(worktreename:branchname) when in a worktree
function git_prompt_info() {
  local ref
  ref=$(git symbolic-ref HEAD 2>/dev/null) || return
  local branch="${ref#refs/heads/}"

  local git_dir
  git_dir=$(git rev-parse --git-dir 2>/dev/null) || return

  local display_ref="$branch"
  if [[ "$git_dir" == *"/.git/worktrees/"* ]]; then
    local worktree_name="${git_dir##*/.git/worktrees/}"
    display_ref="${worktree_name}:${branch}"
  fi

  echo "${ZSH_THEME_GIT_PROMPT_PREFIX}${display_ref}$(parse_git_dirty)${ZSH_THEME_GIT_PROMPT_SUFFIX}"
}


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zsh-autosuggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh


# zoxide
eval "$(zoxide init zsh)"
