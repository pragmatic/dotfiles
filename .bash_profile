# Determine system architecture to set appropriate Homebrew prefix
UNAME_MACHINE="$(/usr/bin/uname -m)"

if [[ "${UNAME_MACHINE}" == "arm64" ]]; then
    # ARM64 (Apple Silicon) macOS configuration
    HOMEBREW_PREFIX="/opt/homebrew"
else
    # Intel macOS configuration
    HOMEBREW_PREFIX="/usr/local"
fi

# Homebrew init
export HOMEBREW_PREFIX
export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar"
# Add Homebrew bins to PATH
export PATH="${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin${PATH+:$PATH}"
# Add Homebrew man pages to MANPATH
export MANPATH="${HOMEBREW_PREFIX}/share/man${MANPATH+:$MANPATH}:"
# Add Homebrew info pages to INFOPATH
export INFOPATH="${HOMEBREW_PREFIX}/share/info:${INFOPATH:-}"

# Add personal bin directory to PATH
PATH="$HOME/bin:$PATH"

# Add coreutils to PATH (GNU versions)
PATH="${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin:$PATH"
# Add GNU sed to PATH (required for eks-creds TF bin script)
PATH="${HOMEBREW_PREFIX}/opt/gnu-sed/libexec/gnubin:$PATH"
# Add findutils to PATH (GNU versions)
PATH="${HOMEBREW_PREFIX}/opt/findutils/libexec/gnubin:$PATH"
# Add Go binary directory to PATH
PATH="$HOME/go/bin:$PATH"
# Add curl from Homebrew to PATH (more recent version)
PATH="${HOMEBREW_PREFIX}/opt/curl/bin:$PATH"

# Add Docker CLI to PATH (macOS)
PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"
# Add OpenSSL 1.1 to PATH (required by some tools)
PATH="${HOMEBREW_PREFIX}/opt/openssl@1.1/bin:$PATH"

# Add asdf to PATH (version manager)
PATH="${HOMEBREW_PREFIX}/opt/asdf/bin:$PATH"
# Add asdf shims to PATH (to use tools installed with asdf)
PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
. <(asdf completion bash)
# Add Krew (kubectl plugin manager) to PATH
PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Add Python to PATH (for development)
PATH="${HOMEBREW_PREFIX}/opt/python@3.13/libexec/bin:$PATH"
# Add Ansible to PATH (for automation)
PATH="/opt/homebrew/opt/ansible@9/bin:$PATH"

# Load local custom configuration (if it exists)
[[ -f "${HOME}/.bash_local" ]] && . "${HOME}/.bash_local"

[[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]] && . "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"

# Source smartcd configuration if available (for project context switching)
[ -r "$HOME/.smartcd_config" ] && ( [ -n $BASH_VERSION ] || [ -n $ZSH_VERSION ] ) && source ~/.smartcd_config

[[ -r "${HOMEBREW_PREFIX}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc" ]] && source "${HOMEBREW_PREFIX}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc"
[[ -r "${HOMEBREW_PREFIX}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc" ]] && source "${HOMEBREW_PREFIX}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc"

# Set AWS STS regional endpoints to use regional endpoints instead of global
export AWS_STS_REGIONAL_ENDPOINTS="regional"

# Enable GKE GCLOUD AUTH plugin for Kubernetes cluster authentication
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# Set history format to include timestamps (YYYY-MM-DD HH:MM:SS)
HISTTIMEFORMAT="%F %T "
# Configure history control to ignore space-prefixed commands
HISTCONTROL="ignorespace${HISTCONTROL:+:$HISTCONTROL}"
# Configure history control to ignore duplicate commands
HISTCONTROL="ignoredups${HISTCONTROL:+:$HISTCONTROL}"
# Configure history to ignore specific commands (commonly used ones)
HISTIGNORE="ls:ls -l:ls l:ls l-:ls -lart:la:tig:git st:git diff:git log:pwd:\:q:"
# Set history size to unlimited (negative value)
HISTSIZE=-1
# HSTR configuration (history search tool)
alias hh=hstr                    # hh to be alias for hstr
export HSTR_CONFIG=raw-history-view,keywords-matching,hicolor # get more colors
# Append new history items to .bash_history file
shopt -s histappend
# Ensure synchronization between bash memory and history file
PROMPT_COMMAND="history -a; history -n${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
# If this is an interactive shell, bind hstr to Ctrl-r and Ctrl-x k
if [[ $- =~ .*i.* ]]; then
    bind '"\C-r": "\C-a hstr -- \C-j"'  # bind hstr to Ctrl-r (for Vi mode check doc)
    bind '"\C-xk": "\C-a hstr -k \C-j"' # bind 'kill last command' to Ctrl-x k
fi

# Initialize zoxide for smarter directory navigation
eval "$(zoxide init bash)"
alias cd=z  # Make cd use zoxide

# COLOURS
# Color definitions for prompt coloring based on day of week
# CLR_1_A="38;5;3;1"      CLR_1_B="38;5;11"   CLR_1_C="38;5;100"  # Yellow
CLR_1_A="38;5;215;1"    CLR_1_B="38;5;179"  CLR_1_C="38;5;202"  # Orange
CLR_2_A="38;5;99;1"     CLR_2_B="38;5;98"   CLR_2_C="38;5;54"   # Indigo
CLR_3_A="38;5;2;1"      CLR_3_B="38;5;10"   CLR_3_C="38;5;22"   # Green
CLR_4_A="38;5;5;1"      CLR_4_B="38;5;13"   CLR_4_C="38;5;89"   # Magenta
CLR_5_A="38;5;6;1"      CLR_5_B="38;5;14"   CLR_5_C="38;5;23"   # Cyan
CLR_6_A="38;5;124;1"    CLR_6_B="38;5;88"   CLR_6_C="38;5;52"   # Red
CLR_7_A="38;5;75;1"     CLR_7_B="38;5;39"   CLR_7_C="38;5;25"   # Blue
# CLR_7_A="38;5;7;1"      CLR_7_B="38;5;15"   CLR_7_C="38;5;8"    # Grey

# Monday in light orange
# Tuesday in indigo
# Wednesday in medium green
# Thursday in deep pink
# Friday in dark turquoise
# Saturday in red
# Sunday in azure blue

# Set color variables based on current day (1=Monday, 7=Sunday)
THEME="$(date +'%u')"
COLOR_A="CLR_${THEME}_A" COLOR_B="CLR_${THEME}_B" COLOR_C="CLR_${THEME}_C"

# macOS specific configurations
case $OSTYPE in
    darwin* )
        # Disable Homebrew analytics (for privacy)
        export HOMEBREW_NO_ANALYTICS=1
        # Disable Homebrew emojis (for better terminal compatibility)
        export HOMEBREW_NO_EMOJI=1
        # Enable color output in terminal
        export CLICOLOR=true
        # Set vim as default editor (from Homebrew)
        export EDITOR="${HOMEBREW_PREFIX}/bin/vim"
        # Increase file descriptor limit (for better performance)
        ulimit -n 1024
        ;;
esac

# ALIASES
alias ls="ls --color=auto"              # Enable color output for ls command
alias vi="vim"                          # Use vim as default editor
alias ykman="/Applications/YubiKey\ Manager.app/Contents/MacOS/ykman"  # YubiKey manager alias
alias grep="grep --color=auto"          # Enable color output for grep command

# FUNCTIONS

# Function to list outdated Homebrew casks
brewoutdated() {
  {
    echo -e "\e[1;m"                    # Reset color
    echo -n  "CASK CURRENT LATEST"      # Header for output
    echo -e "\e[0;m"                    # Reset color
    # List outdated casks using brew info and jq to parse JSON output
    brew info --cask --json=v2 $(brew list --cask) | jq -r '.casks[] | select(.installed != .version) | .token +" "+ .installed +" "+ .version'
  } | column -t                       # Format output in columns
}

# Function to generate passwords with various character sets
# shellcheck shell=bash disable=SC2034
genpasswd() {
    # Character sets for password generation (with exclusions of ambiguous chars)
    CHARS_PLAIN="abcdefghijkmnpqrstuvwxyz23456789ABCDEFGHJKLMNPQRSTUVWXYZ"
    CHARS_YUBI="cbdefghijklnrtuvCBDEFGHIJKLNRTUV0123456789"
    CHARS_ALPHA="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    CHARS_HEX="0123456789abcdef"
    CHARS_PIN="0123456789"
    CHARS_BASE32="234567ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    CHARS_DEFAULT="@$-_*&%abcdefghijkmnpqrstuvwxyz23456789ABCDEFGHJKLMNPQRSTUVWXYZ"
    CHARS_ID="abcdefghijkmnpqrstuvwxyz23456789"
    CHARS_AWSID="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ" # normally 20 chars
    CHARS_AWSSECRET="0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ/+" # normally 40 chars
    CHARS_DJANGO="abcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*(_=+\-)"

    # Set character set based on input parameter (convert to uppercase)
    CHAR_SET="CHARS_${2^^}"

    # If specified character set doesn't exist, use default
    if [ -z "${!CHAR_SET}" ]; then
        CHAR_SET=CHARS_DEFAULT
        [ -n "${2}" ] && >&2 echo "Using default char set"
    fi

    local l=$1
    [ "$l" == "" ] && l=16  # Default password length of 16
    # Generate random password using tr and /dev/urandom
    LC_CTYPE=C tr -dc "${!CHAR_SET}" < /dev/urandom | head -c ${l} | xargs
}

# Function to set AWS environment variables for account switching
ar() {
    # Unset all existing AWS-related environment variables to prevent conflicts
    unset GEO_ENV
    unset ROLE_SESSION_START
    unset AWS_ACCESS_KEY_ID
    unset AWS_ACCOUNT_ID
    unset AWS_ACCOUNT_NAME
    unset AWS_ACCOUNT_ROLE
    unset AWS_DEFAULT_REGION
    unset AWS_PROFILE_ASSUME_ROLE
    unset AWS_REGION
    unset AWS_SECRET_ACCESS_KEY
    unset AWS_SECURITY_TOKEN
    unset AWS_SESSION_ACCESS_KEY_ID
    unset AWS_SESSION_SECRET_ACCESS_KEY
    unset AWS_SESSION_SECURITY_TOKEN
    unset AWS_SESSION_SESSION_TOKEN
    unset AWS_SESSION_START
    unset AWS_SESSION_TOKEN

    # Parse input arguments (account, role, totp)
    local account=$1; shift;
    local role=$1; shift;
    local totp=$1; shift;

    # If no account provided, exit function
    [[ -z $account ]] && return;

    # Set default values for AWS profile and MFA serial if not already set
    AWS_PROFILE_ASSUME_ROLE="${AWS_PROFILE:-default}"
    mfa_slot="${AR_AWS_MFA_SLOT:-AWS}"
    role="${role:-${AR_AWS_ROLE:-default}}"
    # Get TOTP token from YubiKey if not provided
    totp="${totp:-$(ykman oath accounts code --single ${mfa_slot})}"

    # Set session start time
    export ROLE_SESSION_START="$(date +%s)"
    # Execute assume-role command and set environment variables from its output
    eval $(AWS_PROFILE_ASSUME_ROLE="${AWS_PROFILE_ASSUME_ROLE}" assume-role ${account} ${role} ${totp})
}

# Completion function for ar command (AWS account switcher)
_ar_completions() {
    # Only provide completions if we're not in the first position
    (( COMP_CWORD > 1 )) && return
    COMPREPLY=()

    # Read AWS account names from JSON file and populate completions
    while IFS='' read -r line; do
       COMPREPLY+=("$line")
    done < <(jq -r 'keys[]' ~/.aws/accounts)

    # Generate completions based on current word being completed
    COMPREPLY=($(compgen -W "${COMPREPLY[*]}" -- ${COMP_WORDS[COMP_CWORD]}))
}

# Register completion function for ar command
complete -F _ar_completions assume-role ar

# Enhanced man page coloring (custom color definitions)
man () {
    # Set terminal color capabilities for better man page formatting
    LESS_TERMCAP_md=$'\e'"[38;5;75m" \
    LESS_TERMCAP_me=$'\e'"[0m" \
    LESS_TERMCAP_se=$'\e'"[0m" \
    LESS_TERMCAP_so=$'\e'"[103;30m" \
    LESS_TERMCAP_ue=$'\e'"[0m" \
    LESS_TERMCAP_us=$'\e'"[1;37m" \
    command man "$@"
}

# PROMPT SETUP

# Powerline-go binary location (for enhanced prompt)
POWERLINE_GO="${HOMEBREW_PREFIX}/bin/powerline-go"
# Base modules to display in prompt (not including Kubernetes context)
POWERLINE_GO_MODULES_BASE="aws,assume-role,ssh,cwd,dotenv,perms,git,exit"

# Timer file for command execution duration tracking
INTERACTIVE_BASHPID_TIMER="/tmp/${USER}.START.$$"

# Set timer for command duration tracking
PS0='$(echo $SECONDS > "$INTERACTIVE_BASHPID_TIMER")'

# Function to update PS1 prompt (command line display)
function _update_ps1() {
  local __ERRCODE=$?

  local __DURATION=0
  # Calculate command execution time if timer file exists
  if [ -e $INTERACTIVE_BASHPID_TIMER ]; then
    local __END=$SECONDS
    local __START=$(cat "$INTERACTIVE_BASHPID_TIMER")
    __DURATION="$(($__END - ${__START:-__END}))"
    rm -f "$INTERACTIVE_BASHPID_TIMER"
  fi

  # Add Kubernetes context module if kubie is active
  if [ "$KUBIE_ACTIVE" == 1 ]; then
    POWERLINE_GO_MODULES="kube,${POWERLINE_GO_MODULES_BASE}"
  else
    POWERLINE_GO_MODULES="${POWERLINE_GO_MODULES_BASE}"
  fi

  # Update PS1 with powerline-go prompt
  PS1="$(${POWERLINE_GO} -modules ${POWERLINE_GO_MODULES} -duration $__DURATION -error $__ERRCODE -shell bash -shorten-eks-names -shorten-gke-names -condensed -mode patched -modules-right duration)"
}

# Initialize powerline-go prompt if available and not in Linux terminal
if [ "$TERM" != "linux" ] && [ -f "${HOMEBREW_PREFIX}/bin/powerline-go" ]; then
  PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi


# Added by LM Studio CLI (lms)
export PATH="$PATH:${HOME}/.lmstudio/bin"
# End of LM Studio CLI section

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/homebrew/share/google-cloud-sdk/path.bash.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/homebrew/share/google-cloud-sdk/completion.bash.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/completion.bash.inc'; fi
