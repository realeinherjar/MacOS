# Enable colors and change prompt:
autoload -U colors && colors # Load colors
autoload -U promptinit
promptinit
PS1="%B%~$%b "
stty stop undef # Disable ctrl-s to freeze terminal.
setopt extendedglob

# History
HISTSIZE=1000000
HISTFILE=~/.zsh_history
SAVEHIST=1000000
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry
setopt HIST_VERIFY               # Don't execute immediately upon history expansion

# Basic auto/tab complete:
autoload -Uz compinit select-word-style
select-word-style bash
zstyle ':completion:*' menu select, use-cache 1
zstyle ':autocomplete:*' fzf-completion yes
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files.

# Alt + left/right
# check out: https://superuser.com/a/1307657
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

# User specific environment variables
export JULIA_NUM_THREADS=auto
export GPG_TTY=$(tty)

alias ls="ls -h --color=auto"
alias yt="yt-dlp --add-metadata -i --format mp4 --restrict-filenames --sponsorblock-remove all"
alias yta="yt -x -f bestaudio/best --format mp4 --audio-format opus --restrict-filenames --sponsorblock-remove all"
alias ffmpeg="ffmpeg -hide_banner"
alias myip="curl ipinfo.io/ip"
alias testtor="curl -x socks5h://localhost:9050 -s https://check.torproject.org/api/ip"
alias g="git"

# Functions
einherjar() {
    git config core.sshCommand 'ssh -o IdentitiesOnly=yes -i ~/.ssh/id_einherjar -F /dev/null'
    git config user.signingKey '0xE7ED7E35F072CA83!'
    git config user.email 'realeinherjar@proton.me'
    git config user.name Einherjar
}
ytp() {
    PLAYLISTID="$1"
    YTURL="https://www.youtube.com/playlist?list=$PLAYLISTID"
    
    printf "#!/bin/sh\nyt-dlp --add-metadata -i --format mp4 --restrict-filenames --sponsorblock-remove all -o '%%(playlist_index)s-%%(title)s.%%(ext)s' --download-archive archive.txt '%s'" "$YTURL" >command.sh
    
    chmod +x command.sh
    ./command.sh
}
btc() {
    params=()
    for arg in "${@:3}"
    do
        params+=("$arg, ")
    done

    if (( $# > 2 ))
    then
        params="${params//, $/}"
        params="[$params]"
    else
        params='[""]'
    fi

    method="\"method\": \"$1\""
    params="\"params\": $params"
    payload="{$method, $params}"

    proxy_url="socks5h://localhost:9050"
    auth_credentials="$BTC_USER:$BTC_PASS"
    content_type="Content-Type: text/plain;"
    target_address="$BTC_ONION_ADDRESS"
    target_port="$BTC_ONION_PORT"
    url="$target_address:$target_port"

    curl -x "$proxy_url" --user "$auth_credentials" -H "$content_type" -d "$payload" -w "formatted string" "$url"
}


# System binaries
PATH="/usr/local/bin:$PATH"
# Local binaries
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
# Brew binaries
if ! [[ "$PATH" =~ "/opt/homebrew/bin:" ]]
then
    PATH="/opt/homebrew/bin:$PATH"
fi
if ! [[ "$PATH" =~ "/opt/homebrew/sbin:" ]]
then
    PATH="/opt/homebrew/sbin:$PATH"
fi
export PATH

# Brew completions
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi

# Zsh functions
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fpath+=/opt/homebrew/share/zsh/site-functions

# Zsh Plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
