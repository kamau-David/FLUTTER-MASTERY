#!/usr/bin/env bash
# Run this ONCE from inside the flutter-mastery/ folder to scaffold every
# project (adds the android/ios/ native folders that `flutter create` needs
# to actually generate against YOUR installed Flutter/Gradle/Xcode versions -
# that's why this has to run on your machine, not be pre-built).
set -e

declare -A PROJECTS=(
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

for dir in "${!PROJECTS[@]}"; do
  name="${PROJECTS[$dir]}"
  echo ""
  echo "=================================================="
  echo "Setting up: $dir  (project name: $name)"
  echo "=================================================="

  if [ ! -d "$dir" ]; then
    echo "  Skipping - folder not found: $dir"
    continue
  fi

  cd "$dir"

  # --overwrite keeps our existing lib/, test/, pubspec.yaml, only adding
  # the missing android/ios/other platform scaffold files around them
  flutter create . --project-name "$name" --overwrite --platforms=android,ios

  echo "  Running flutter pub get..."
  flutter pub get

  cd ..
  echo "  Done: $dir"
done

echo ""
echo "=================================================="
echo "Folder 01 (dart-fundamentals) needs NO Flutter setup - it's pure Dart."
echo "Run its files directly with: dart run <filename>.dart"
echo ""
echo "Folder 08 (local-storage) needs ONE extra step for Hive's generated code:"
echo "  cd 08-local-storage && dart run build_runner build"
echo ""
echo "Folder 15 (deployment-play-store) is documentation only - nothing to run."
echo "=================================================="
echo ""
echo "All done! Open any numbered folder individually in VS Code (not the"
echo "flutter-mastery root) and hit Run / F5 to launch it."
