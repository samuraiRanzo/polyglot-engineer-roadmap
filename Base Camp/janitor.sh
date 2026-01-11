#!/bin/bash

# --- Configuration ---
REGISTRY="port_registry.txt"

# --- Validation ---
if [[ "$PWD" != *"/Base Camp" ]]; then
    echo "❌ Error: Please run this script from inside the 'Base Camp' directory."
    exit 1
fi

if [ ! -f "$REGISTRY" ]; then
    echo "⚠️ No port_registry.txt found. No projects are currently registered."
    exit 0
fi

# --- Helper: Docker Action ---
manage_project() {
    local action=$1
    local project_path=$2
    local full_path="../$project_path"

    if [ -d "$full_path" ]; then
        echo "🚀 Executing [$action] on project: $(basename "$project_path")"
        # -d flag ensures start/restart happens in the background
        (cd "$full_path" && docker compose $action)
        echo "✅ Action [$action] completed."
    else
        echo "❌ Directory not found: $full_path"
    fi
}

# --- Main Menu ---
echo "========================================================"
echo "🐳 DOCKER MANAGER: Homelab Resource Orchestrator"
echo "========================================================"
echo "1) START a project (by Port)"
echo "2) STOP a project (by Port)"
echo "3) RESTART a project (by Port)"
echo "4) STOP ALL registered projects (Emergency RAM Clear)"
echo "5) LIST all registered projects"
echo "6) Exit"
echo "--------------------------------------------------------"
read -p "Select an option [1-6]: " CHOICE

case $CHOICE in
    1|2|3)
        read -p "Enter the port number (FE or BE): " TARGET_PORT
        PROJECT_DATA=$(grep ":$TARGET_PORT:" "$REGISTRY")

        if [ -n "$PROJECT_DATA" ]; then
            TARGET_PATH=$(echo "$PROJECT_DATA" | cut -d':' -f4)

            if [ "$CHOICE" == "1" ]; then manage_project "up -d" "$TARGET_PATH"
            elif [ "$CHOICE" == "2" ]; then manage_project "stop" "$TARGET_PATH"
            elif [ "$CHOICE" == "3" ]; then manage_project "restart" "$TARGET_PATH"
            fi
        else
            echo "❌ Port $TARGET_PORT is not in the registry."
        fi
        ;;
    4)
        echo "🧨 Stopping all projects in $REGISTRY..."
        while IFS=: read -r id fe be path; do
            manage_project "stop" "$path"
        done < "$REGISTRY"
        ;;
    5)
        echo "📋 Project Registry:"
        printf "%-5s | %-8s | %-8s | %-s\n" "ID" "FE Port" "BE Port" "Path"
        echo "--------------------------------------------------------"
        while IFS=: read -r id fe be path; do
            printf "%-5s | %-8s | %-8s | %-s\n" "$id" "$fe" "$be" "$path"
        done < "$REGISTRY"
        ;;
    *)
        echo "👋 Manager exiting."
        exit 0
        ;;
esac