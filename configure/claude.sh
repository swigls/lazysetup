source libsetup.sh || exit 1

# Add zellij-attention hooks to ~/.claude/settings.json
python3 << 'EOF'
import json, os

settings_path = os.path.expanduser('~/.claude/settings.json')

settings = {}
if os.path.exists(settings_path):
    with open(settings_path) as f:
        try:
            settings = json.load(f)
        except json.JSONDecodeError:
            settings = {}

waiting_cmd = 'zellij pipe --name "zellij-attention::waiting::$ZELLIJ_PANE_ID"'
completed_cmd = 'zellij pipe --name "zellij-attention::completed::$ZELLIJ_PANE_ID"'

hooks = settings.setdefault('hooks', {})

# Notification hook (waiting state)
notif_hooks = hooks.setdefault('Notification', [])
already_has_waiting = any(
    h.get('command') == waiting_cmd
    for entry in notif_hooks
    for h in entry.get('hooks', [])
)
if not already_has_waiting:
    notif_hooks.append({'matcher': '', 'hooks': [{'type': 'command', 'command': waiting_cmd}]})

# Stop hook (completed state)
stop_hooks = hooks.setdefault('Stop', [])
already_has_completed = any(
    h.get('command') == completed_cmd
    for entry in stop_hooks
    for h in entry.get('hooks', [])
)
if not already_has_completed:
    stop_hooks.append({'hooks': [{'type': 'command', 'command': completed_cmd}]})

os.makedirs(os.path.dirname(settings_path), exist_ok=True)
with open(settings_path, 'w') as f:
    json.dump(settings, f, indent=2)
    f.write('\n')

print(f"Updated {settings_path} with zellij-attention hooks")
EOF
