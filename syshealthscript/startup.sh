#!/usr/bin/env bash
set -euo pipefail

echo "Pleas enter the information about your remote host:"

read -rp "Enter host IP: " HOST_IP
read -rp "Enter SSH user: " SSH_USER
read -rsp "Enter SSH user password: " USER_PASS

TEMPLATE="inventory.tpl"
OUTPUT="inventory.ini"

sed \
  -e "s|{{ANSIBLE_HOST}}|$HOST_IP|g" \
  -e "s|{{ANSIBLE_USER}}|$SSH_USER|g" \
  -e "s|{{ANSIBLE_PASS}}|$USER_PASS|g" \
  "$TEMPLATE" > "$OUTPUT"

echo ""
echo "Inventory generated at $OUTPUT"


read -rp "Enter SERVICE value: " SERVICE_VALUE

if [[ -z "$SERVICE_VALUE" ]]; then
    echo "Error: SERVICE value cannot be empty"
    exit 1
fi

TARGET_FILE="./system_monitor.sh"

if [[ ! -f "$TARGET_FILE" ]]; then
    echo "Error: file not found: $TARGET_FILE"
    exit 1
fi

# Escape special characters for sed safety
ESCAPED_VALUE=$(printf '%s\n' "$SERVICE_VALUE" | sed 's/[\/&]/\\&/g')

# Replace SERVICE="..."
sed -i -E "s|^([[:space:]]*SERVICE=).*|\1\"$ESCAPED_VALUE\"|" "$TARGET_FILE"

echo "SERVICE updated to: $SERVICE_VALUE"

# Run ansible
ansible-playbook -i inventory.ini monitor.yaml

echo "Destroying inventory file"
rm $OUTPUT

echo "Done."
