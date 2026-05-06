#!/bin/sh
# Display a menu of existing tmux sessions plus a "New session..." entry,
# and move the current window to the chosen session.

items=""
while IFS= read -r name; do
    [ -n "$name" ] || continue
    items="$items \"$name\" \"\" \"move-window -t '$name' ; switch-client -t '$name'\""
done <<EOF
$(tmux list-sessions -F '#S')
EOF

eval "tmux display-menu -t \"\$TMUX_PANE\" -T 'Move window to session' -x C -y C $items '' 'New session...' n 'command-prompt -p \"new session name:\" \"new-session -d -s %1 ; move-window -a -t %1: ; kill-window -t %1:^ ; switch-client -t %1\"'"
