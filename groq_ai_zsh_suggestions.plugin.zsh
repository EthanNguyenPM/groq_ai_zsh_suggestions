zsh_llm_suggestions_spinner() {
  local pid=$1
  local delay=0.1
  local spinstr='|/-\'

  cleanup() {
    kill $pid
    echo -ne "\e[?25h"
  }
  trap cleanup SIGINT

  echo -ne "\e[?25l"
  while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
    local temp=${spinstr#?}
    printf " [%c]" "$spinstr"
    local spinstr=$temp${spinstr%"$temp"}
    sleep $delay
    printf "\b\b\b\b"
  done
  printf "    \b\b\b\b"

  echo -ne "\e[?25h"
  trap - SIGINT
}

zsh_llm_suggestions_run_query() {
  local llm="$1"
  local query="$2"
  local result_file="$3"
  local mode="$4"
  echo -n "$query" | eval $llm $mode >$result_file
}

zsh_completion() {
  local llm="$1"
  local mode="$2"
  local query=${BUFFER}

  # Empty prompt, nothing to do
  if [[ "$query" == "" ]]; then
    return
  fi

  # If the prompt is the last suggestions, just get another suggestion for the same query
  if [[ "$mode" == "generate" ]]; then
    if [[ "$query" == "$ZSH_LLM_SUGGESTIONS_LAST_RESULT" ]]; then
      query=$ZSH_LLM_SUGGESTIONS_LAST_QUERY
    else
      ZSH_LLM_SUGGESTIONS_LAST_QUERY="$query"
    fi
  fi

  # Temporary file to store the result of the background process
  local result_file="/tmp/zsh-llm-suggestions-result"
  # Run the actual query in the background (since it's long-running, and so that we can show a spinner)
  read < <(
    zsh_llm_suggestions_run_query $llm $query $result_file $mode &
    echo $!
  )
  # Get the PID of the background process
  local pid=$REPLY
  # Call the spinner function and pass the PID
  zsh_llm_suggestions_spinner $pid

  if [[ "$mode" == "generate" ]]; then
    print -s $query
    ZSH_LLM_SUGGESTIONS_LAST_RESULT=$(cat $result_file)
    BUFFER="${ZSH_LLM_SUGGESTIONS_LAST_RESULT}"
    CURSOR=${#ZSH_LLM_SUGGESTIONS_LAST_RESULT}
  elif [[ "$mode" == "explain" ]]; then
    echo ""
    eval "cat $result_file"
    echo ""
    zle reset-prompt
  elif [[ "$mode" == "script" ]]; then
    local script_path=$(cat $result_file)
    BUFFER="zsh $script_path"
    CURSOR=${#BUFFER}
    zle reset-prompt
    echo "\nShell script generated and saved to: $script_path"
    echo "The command to execute script has been added to your prompt."
    echo "Press Enter to execute, or modify as needed."
  fi
}

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" &>/dev/null && pwd)

groq_ai_zsh_suggestions_generate () {
  zsh_completion "$SCRIPT_DIR/groq_ai_zsh_suggestions.py" "generate"
}

groq_ai_zsh_suggestions_explain () {
  zsh_completion "$SCRIPT_DIR/groq_ai_zsh_suggestions.py" "explain"
}

groq_ai_zsh_suggestions_script() {
  zsh_completion "$SCRIPT_DIR/groq_ai_zsh_suggestions.py" "script"
}

#zle -N zsh_llm_suggestions_anthropic
zle -N groq_ai_zsh_suggestions_generate
zle -N groq_ai_zsh_suggestions_explain
zle -N groq_ai_zsh_suggestions_script
