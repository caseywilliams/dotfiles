_vanagon_actions()
{
  if [[ -d ./configs/projects && -d ./configs/platforms ]]; then
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    projects=`ls ./configs/projects/*.rb 2>/dev/null | xargs -n 1 basename | rev | cut -c 4- | rev`
    platforms=`ls ./configs/platforms/*.rb 2>/dev/null | xargs -n 1 basename | rev | cut -c 4- | rev`

    if [[ ${prev} =~ (^| )(be|exec)($| ) ]]; then
      COMPREPLY=( $(compgen -W "build inspect render build_host_info build_requirements" -- ${cur}) )
    elif [[ ${prev} =~ (^| )bundle($| ) ]]; then
      COMPREPLY=( $(compgen -W "exec install" -- ${cur}) )
    elif [[ ${prev} =~ (^| )(build|inspect|render|build_host_info|build_requirements)($| ) ]] ; then
      # complete projects
      COMPREPLY=( $(compgen -W "${projects}" -- ${cur}) )
    elif [[ $COMP_CWORD -gt 1 ]]; then
      if [[ ${COMP_WORDS[COMP_CWORD-2]} =~ (^| )(build|inspect|render|build_host_info|build_requirements)$ ]]; then
        # complete platforms
        COMPREPLY=( $(compgen -W "${platforms}" -- ${cur}) )
      fi
    fi
  fi
  return 0
}

complete -F _vanagon_actions be
complete -F _vanagon_actions bundle

# ex: filetype=sh
