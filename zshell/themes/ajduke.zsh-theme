
# Directory info.
local current_dir='${PWD/#$HOME/~}'

# VCS
# YS_VCS_PROMPT_PREFIX1=" %{$fg[white]%}on%{$reset_color%} "
YS_VCS_PROMPT_PREFIX2=":%{$fg[cyan]%}"
YS_VCS_PROMPT_SUFFIX="%{$reset_color%}"
YS_VCS_PROMPT_DIRTY=" %{$fg[red]%}✖︎"
YS_VCS_PROMPT_CLEAN=" %{$fg[green]%}●"

# Git info.
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="${YS_VCS_PROMPT_PREFIX1}git${YS_VCS_PROMPT_PREFIX2}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$YS_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$YS_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$YS_VCS_PROMPT_CLEAN"


local node_info='$(node_npm_version)'
node_npm_version(){
  PM=" %{$terminfo[bold]$fg[magenta]%}node%{$terminfo[bold]$fg[white]%}@%{$terminfo[bold]$fg[green]%}$(node -v 2>/dev/null)%{$terminfo[bold]$fg[white]%}/%{$terminfo[bold]$fg[red]%}$(npm -v 2>/dev/null)"
  echo -n $PM
}
# Prompt format: \n # USER at MACHINE in DIRECTORY on git:BRANCH STATE st for [TIME] \n $
PROMPT="
%{$terminfo[bold]$fg[magenta]%}>%{$reset_color%} \
%{$terminfo[bold]$fg[magenta]%}%n \
%{$terminfo[bold]$fg[yellow]%}${current_dir}%{$reset_color%}\
${node_info}%{$fg[white]%} \
${git_info} \
%{$fg[white]%}[%*]
${put_spacing}
%{$terminfo[bold]$fg[magenta]%}→ %{$reset_color%}"
