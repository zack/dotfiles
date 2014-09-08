if [ "$TMUX" != "" ]; then
        ARROW="→"
else
        ARROW="⇝"
fi

local ret_status="%(?:%{$fg_bold[green]%}${ARROW} :%{$fg_bold[red]%}${ARROW} %s)"

PROMPT='${ret_status}%{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

if [[ -n "$SSH_CLIENT" ]]; then
        PROMPT="$fg_bold[yellow]%M ${PROMPT}"
fi

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
