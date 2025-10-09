# Replaces cat calls with bat calls whenever highlighting matters
# makes sure piping works 

#making sure that aliases don't break 
real_cat=$(whence -p cat)

if command -v bat > /dev/null 2>&1; then
  function cat() {   

  # Handles no args and stdin correctly
    if [ $# -eq 0 ] || [ "$1" = "-" ]; then 
      "$real_cat" "$@"
      return
    fi 

    # Only works if shell is interacitve 
    [[ $- == *i* ]] || { "$real_cat" "$@"; return; }

    # Only works in TTY so to not mess up pipes 
    if [ -t 1 ]; then 
      bat -P --style=plain "$@"
    else 
      "$real_cat" "$@"
    fi 
  }
fi 
