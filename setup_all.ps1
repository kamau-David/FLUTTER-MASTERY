# Run this ONCE from inside the flutter-mastery\ folder (PowerShell) to
# scaffold every project - adds the android/ios native folders that
# `flutter create` generates against YOUR installed Flutter/Gradle/Xcode
# versions, which is why this needs to run on your machine.

$projects = @{
    "02-flutter-basics-widgets"        = "flutter_basics_widgets"
    "03-layouts-styling"               = "layouts_styling"
    "04-stateful-lifecycle"            = "stateful_lifecycle"
    "05-navigation-routing"            = "navigation_routing"
    "06-forms-validation"              = "forms_validation"
    "07-networking-rest-api"           = "networking_rest_api"
    "08-local-storage"                 = "local_storage"
    "09-state-management-provider"     = "state_management_provider"
    "10-state-management-riverpod"     = "state_management_riverpod"
    "11-animations"                    = "animations_demo"
    "12-testing"                       = "testing_demo"
    "13-clean-architecture"            = "clean_architecture_demo"
    "14-backend-integration-supabase"  = "backend_integration_supabase"
}

foreach ($dir in $projects.Keys) {
    $name = $projects[$dir]
    Write-Host ""
    Write-Host "=================================================="
    Write-Host "Setting up: $dir  (project name: $name)"
    Write-Host "=================================================="

    if (-not (Test-Path $dir)) {
        Write-Host "  Skipping - folder not found: $dir"
        continue
    }

    Push-Location $dir

    flutter create . --project-name $name --overwrite --platforms=android,ios

    Write-Host "  Running flutter pub get..."
    flutter pub get

    Pop-Location
    Write-Host "  Done: $dir"
}

Write-Host ""
Write-Host "=================================================="
Write-Host "Folder 01 (dart-fundamentals) needs NO Flutter setup - it's pure Dart."
Write-Host "Run its files directly with: dart run <filename>.dart"
Write-Host ""
Write-Host "Folder 08 (local-storage) needs ONE extra step for Hive's generated code:"
Write-Host "  cd 08-local-storage; dart run build_runner build"
Write-Host ""
Write-Host "Folder 15 (deployment-play-store) is documentation only - nothing to run."
Write-Host "=================================================="
Write-Host ""
Write-Host "All done! Open any numbered folder individually in VS Code (not the"
Write-Host "flutter-mastery root) and hit Run / F5 to launch it."
