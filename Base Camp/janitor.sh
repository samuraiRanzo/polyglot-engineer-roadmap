#!/bin/bash

# --- Configuration ---
REGISTRY="port_registry.txt"
TEMP_REGISTRY="registry.tmp"

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
echo "1) START a project (up -d)"
echo "2) STOP a project (hibernation)"
echo "3) RESTART a project"
echo "4) DESTROY a project (Wipes all data/volumes) 🔥"
echo "5) STOP ALL registered projects (RAM Clear)"
echo "6) LIST all registered projects"
echo "7) CLEANUP Registry (Remove missing project folders) 🧹"
echo "8) Exit"
echo "--------------------------------------------------------"
read -p "Select an option [1-8]: " CHOICE

case $CHOICE in
    1|2|3|4)
        read -p "Enter the port number (FE or BE): " TARGET_PORT
        PROJECT_DATA=$(grep ":$TARGET_PORT:" "$REGISTRY")

        if [ -n "$PROJECT_DATA" ]; then
            TARGET_PATH=$(echo "$PROJECT_DATA" | cut -d':' -f4)

            if [ "$CHOICE" == "1" ]; then manage_project "up -d" "$TARGET_PATH"
            elif [ "$CHOICE" == "2" ]; then manage_project "stop" "$TARGET_PATH"
            elif [ "$CHOICE" == "3" ]; then manage_project "restart" "$TARGET_PATH"
            elif [ "$CHOICE" == "4" ]; then
                read -p "⚠️ Are you sure? This wipes the database. [y/N]: " CONFIRM
                if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
                    manage_project "down -v" "$TARGET_PATH"
                else
                    echo "❌ Aborted."
                fi
            fi
        else
            echo "❌ Port $TARGET_PORT is not in the registry."
        fi
        ;;
    5)
        echo "🧨 Stopping all projects in $REGISTRY..."
        while IFS=: read -r id fe be path; do
            manage_project "stop" "$path"
        done < "$REGISTRY"
        ;;
    6)
        echo "📋 Project Registry:"
        printf "%-5s | %-8s | %-8s | %-s\n" "ID" "FE Port" "BE Port" "Path"
        echo "--------------------------------------------------------"
        while IFS=: read -r id fe be path; do
            printf "%-5s | %-8s | %-8s | %-s\n" "$id" "$fe" "$be" "$path"
        done < "$REGISTRY"
        ;;
    7)
        echo "🧹 Scanning for missing folders..."
        > "$TEMP_REGISTRY"
        REMOVED_COUNT=0

        while IFS=: read -r id fe be path; do
            if [ -d "../$path" ]; then
                echo "$id:$fe:$be:$path" >> "$TEMP_REGISTRY"
            else
                echo "🗑️ Removing ghost entry: $id ($path)"
                ((REMOVED_COUNT++))
            fi
        done < "$REGISTRY"

        mv "$TEMP_REGISTRY" "$REGISTRY"
        echo "✨ Done. $REMOVED_COUNT stale entries removed from $REGISTRY."
        ;;
    *)
        exit 0
        ;;
esac