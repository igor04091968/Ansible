#!/bin/bash

# A script to run Ansible playbooks from the console.

# Check for the correct number of arguments
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <playbook_name> <project_path> [commit_message]"
    echo ""
    echo "Available playbooks: "
    echo "  - acme_certs"
    echo "  - fix_acme"
    echo "  - git_pull"
    echo "  - git_sync"
    echo "  - ping"
    echo "  - update_system"
    echo ""
    echo "Example: $0 git_sync /mnt/usb_hdd1/Projects/sing-chisel-tel \"My automated commit\""
    exit 1
fi

# --- Configuration ---
ANSIBLE_DIR="/mnt/usb_hdd1/Projects/Ansible"
INVENTORY_FILE="${ANSIBLE_DIR}/inventory"
PLAYBOOK_NAME="$1"
PROJECT_PATH="$2"
COMMIT_MESSAGE="$3" # This will be empty if not provided

PLAYBOOK_FILE="${ANSIBLE_DIR}/${PLAYBOOK_NAME}.yml"

# --- Validation ---
if [ ! -f "$PLAYBOOK_FILE" ]; then
    echo "Error: Playbook '$PLAYBOOK_FILE' not found."
    exit 1
fi

if [ ! -d "$PROJECT_PATH" ]; then
    echo "Error: Project path '$PROJECT_PATH' not found."
    exit 1
fi

# --- Command Execution ---
echo "Running playbook: ${PLAYBOOK_NAME}"

# Construct extra-vars
EXTRA_VARS="project_path=${PROJECT_PATH}"
if [ -n "$COMMIT_MESSAGE" ]; then
    EXTRA_VARS="${EXTRA_VARS} commit_message='${COMMIT_MESSAGE}'"
fi

# Build and run the ansible-playbook command
# We use sudo because the playbooks require root privileges for git operations.
COMMAND="sudo ansible-playbook -i ${INVENTORY_FILE} ${PLAYBOOK_FILE} --extra-vars \"${EXTRA_VARS}\""

echo "Executing: ${COMMAND}"
eval ${COMMAND}
