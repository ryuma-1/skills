#!/usr/bin/env bash
# ~/bin/link-my-skills.sh
set -euo pipefail
REPO="$HOME/git/skills"
DEST="$HOME/.claude/skills"
mkdir -p "$DEST"

find "$REPO/skills" -name SKILL.md \
  -not -path '*/deprecated/*' -not -path '*/misc/*' -not -path '*/in-progress/*' \
  -print0 |
while IFS= read -r -d '' md; do
  src="$(dirname "$md")"; name="$(basename "$src")"
  target="$DEST/$name"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "skip: $target は実ディレクトリなので触りません" >&2; continue
  fi
  ln -sfn "$src" "$target"
  echo "linked $name"
done
