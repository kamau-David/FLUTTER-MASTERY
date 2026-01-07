# Flutter Mastery - Setup Script (Windows PowerShell)
#
# Run this ONCE, from inside the flutter-mastery folder, on a machine with
# Flutter installed. For each numbered folder, it:
#   1. Backs up your existing lib/, test/, and pubspec.yaml
#   2. Runs `flutter create .` to generate the missing android/ios/etc. scaffold
#   3. Restores your original code and dependencies
#   4. Runs `flutter pub get`
#   5. For 08-local-storage, also runs build_runner to generate Hive adapters
#
# Usage:
#   cd flutter-mastery
#   powershell -ExecutionPolicy Bypass -File setup.ps1

$folders = @(
    @{ Path = "02-flutter-basics-widgets"; Name = "flutter_basics_widgets" },
    @{ Path = "03-layouts-styling"; Name = "layouts_styling" },
    @{ Path = "04-stateful-lifecycle"; Name = "stateful_lifecycle" },
    @{ Path = "05-navigation-routing"; Name = "navigation_routing" },
    @{ Path = "06-forms-validation"; Name = "forms_validation" },
    @{ Path = "07-networking-rest-api"; Name = "networking_rest_api" },
    @{ Path = "08-local-storage"; Name = "local_storage" },
    @{ Path = "09-state-management-provider"; Name = "state_management_provider" },
    @{ Path = "10-state-management-riverpod"; Name = "state_management_riverpod" },
    @{ Path = "11-animations"; Name = "animations_demo" },
    @{ Path = "12-testing"; Name = "testing_demo" },
    @{ Path = "13-clean-architecture"; Name = "clean_architecture_demo" },
    @{ Path = "14-backend-integration-supabase"; Name = "backend_integration_supabase" }
)

$root = Get-Location

foreach ($folder in $folders) {
    $path = $folder.Path
    $name = $folder.Name

    Write-Host "`n========== $path ==========" -ForegroundColor Cyan

    if (-not (Test-Path $path)) {
        Write-Host "SKIP: folder not found" -ForegroundColor Yellow
        continue
    }

    Set-Location (Join-Path $root $path)

    # 1. Back up existing code before flutter create can touch anything
    Write-Host "Backing up existing lib/, test/, pubspec.yaml..."
    if (Test-Path "lib") { Rename-Item "lib" "lib_backup" }
    if (Test-Path "test") { Rename-Item "test" "test_backup" }
    Copy-Item "pubspec.yaml" "pubspec.yaml.backup"

    # 2. Generate the real native scaffold (android/ios/web/etc.) - this
    # requires the actual Flutter SDK and cannot be faked or hand-written
    # reliably, since it's version- and platform-dependent.
    Write-Host "Running flutter create (generates android/ios scaffold)..."
    flutter create . --project-name $name --overwrite --platforms=android,ios

    # 3. Restore our original code and dependencies over the generated defaults
    Write-Host "Restoring original code..."
    if (Test-Path "lib") { Remove-Item "lib" -Recurse -Force }
    Rename-Item "lib_backup" "lib"

    if (Test-Path "test_backup") {
        if (Test-Path "test") { Remove-Item "test" -Recurse -Force }
        Rename-Item "test_backup" "test"
    }

    Remove-Item "pubspec.yaml" -Force
    Rename-Item "pubspec.yaml.backup" "pubspec.yaml"

    # 4. Install dependencies
    Write-Host "Running flutter pub get..."
    flutter pub get

    # 5. Special case: folder 08 needs Hive's generated adapter file
    if ($path -eq "08-local-storage") {
        Write-Host "Generating Hive TypeAdapter (task.g.dart)..."
        dart run build_runner build --delete-conflicting-outputs
    }

    Write-Host "DONE: $path is ready. Open this folder in VS Code and hit Run." -ForegroundColor Green
    Set-Location $root
}

Write-Host "`nAll folders processed. Open any individual folder (not the parent" -ForegroundColor Cyan
Write-Host "flutter-mastery folder) in VS Code as its own workspace to run it." -ForegroundColor Cyan
