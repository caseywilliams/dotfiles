# vim: ai ts=2 sw=2 et sts=2 ft=sh
# via: https://raw.githubusercontent.com/josuah/Config/4da46f6f89131a5fcbaf5ae760ef7a8e8c392b92/.local/bin/git-prompt

git_prompt() {
  git rev-parse 2> /dev/null && git status --porcelain -b | awk '
    /^## / {
      branch = $0;
      sub(/^## /, "", branch);
      sub(/\.\.\..*/, "", branch);

      if ($0 ~ /ahead /) {
        ahead = $0;
        sub(/.*ahead /,  "", ahead);
        sub(/\].*|, .*/, "", ahead);
      }

      if ($0 ~ /behind /) {
        behind = $0;
        sub(/.*behind /, "", behind);
        sub(/\].*|, .*/, "", behind);
      }

      m = 1;
    }

  m == 0 && /^\?\? /  { untracked++; m = 1; }
  m == 0 && /^U. /    { conflicts++; m = 1; }
  m == 0 && /^.U /    { conflicts++; m = 1; }
  m == 0 && /^DD /    { conflicts++; m = 1; }
  m == 0 && /^AA /    { conflicts++; m = 1; }
  m == 0 && /^.M /    { changed++;          }
  m == 0 && /^.D /    { changed++;          }
  m == 0 && /^[^ ]. / { staged++;           }
  m == 1              { m = 0;              }

  END {
    printf("  \033[1m%s\033[0m", branch);

    if (untracked + conflicts + changed + staged + behind + ahead == 0) {
      printf " \033[32mok\033[0m";
    } else {
      if (untracked) printf " \033[33m?\033[0m%d", untracked;
      if (conflicts) printf " \033[31m!\033[0m%d", conflicts;
      if (changed  ) printf " \033[32m+\033[0m%d", changed  ;
      if (staged   ) printf " \033[34m*\033[0m%d", staged   ;
      if (behind   ) printf " \033[31m↓\033[0m%d", behind   ;
      if (ahead    ) printf " \033[36m↑\033[0m%d", ahead    ;
    }
  }'
}
