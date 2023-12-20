#!/usr/bin/fish

function humantime -a milliseconds -d 'Print milliseconds into human-readable time'
  builtin set -q milliseconds; or builtin return 0
  builtin string match -q '^[0-9]+$' $milliseconds; or builtin return 23
  builtin test $milliseconds -eq 0; and builtin printf '0ms'; and builtin return 0

  builtin set -l seconds (builtin math $milliseconds / 1000)
  builtin set -l minutes (builtin math $seconds / 60)
  builtin set -l hours (builtin math $minutes / 60)
  builtin set -l days (builtin math $hours / 24)

  builtin set milliseconds (builtin math $milliseconds % 1000)
  builtin set seconds (builtin math $seconds % 60)
  builtin set minutes (builtin math $minutes % 60)
  builtin set hours (builtin math $hours % 24)

  builtin printf '%dd\n%dh\n%dm\n%ds\n%dms' $days $hours $minutes $seconds $milliseconds | command grep -v '^0' | command xargs
end
