#!/bin/bash
# Flutter Mastery - Setup Script (macOS/Linux/WSL/Git Bash)
#
# Run this ONCE, from inside the flutter-mastery folder, on a machine with
# Flutter installed. See setup.ps1's header comment for what it does.
#
# Usage:
#   cd flutter-mastery
#   chmod +x setup.sh
#   ./setup.sh

set -e

declare -A folders=(
  ["02-flutter-basics-widgets"]="flutter_basics_widgets"
  ["03-layouts-styling"]="layouts_styling"
  ["04-stateful-lifecycle"]="stateful_lifecycle"
  ["05-navigation-routing"]="navigation_routing"
  ["06-forms-validation"]="forms_validation"
  ["07-networking-rest-api"]="networking_rest_api"
  ["08-local-storage"]="local_storage"
  ["09-state-management-provider"]="state_management_provider"
  ["10-state-management-riverpod"]="state_management_riverpod"
  ["11-animations"]="animations_demo"
  ["12-testing"]="testing_demo"
  ["13-clean-architecture"]="clean_architecture_demo"
  ["14-backend-integration-supabase"]="backend_integration_supabase"
)

root_dir=$(pwd)

for path in "${!folders[@]}"; do
  name="${folders[$path]}"
  echo ""
  echo "========== $path =========="

  if [ ! -d "$path" ]; then
    echo "SKIP: folder not found"
    continue
  fi

  cd "$root_dir/$path"

  echo "Backing up existing lib/, test/, pubspec.yaml..."
  [ -d "lib" ] && mv lib lib_backup
  [ -d "test" ] && mv test test_backup
  cp pubspec.yaml pubspec.yaml.backup

  echo "Running flutter create (generates android/ios scaffold)..."
  flutter create . --project-name "$name" --overwrite --platforms=android,ios

  echo "Restoring original code..."
  rm -rf lib
  mv lib_backup lib

  if [ -d "test_backup" ]; then
    rm -rf test
    mv test_backup test
  fi

  rm pubspec.yaml
  mv pubspec.yaml.backup pubspec.yaml

  echo "Running flutter pub get..."
  flutter pub get

  if [ "$path" == "08-local-storage" ]; then
    echo "Generating Hive TypeAdapter (task.g.dart)..."
    dart run build_runner build --delete-conflicting-outputs
  fi

  echo "DONE: $path is ready."
  cd "$root_dir"
done

echo ""
echo "All folders processed. Open any individual folder (not the parent"
echo "flutter-mastery folder) in VS Code as its own workspace to run it."
