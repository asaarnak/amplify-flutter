# Amplify Flutter Repo Tool (aft)

A CLI tool for managing the Amplify Flutter repository.

## Commands

- `bootstrap`/`bs`: Sets up repo for development work
- `clean`: Cleans temporary files and build artifacts for all packages
- `deps check`: Checks dependencies of all packages against `aft.yaml`
- `generate`: Generates various repo items
  - `workflows`: Generates GitHub actions workflows for all packages in the repo
- `link`: Links all packages together using `pubspec_overrides.yaml`
- `list`: Lists all packages in the repo
- `pub`: Run pub commands for all packages in the repo
  - `get`: Runs `dart pub get`/`flutter pub get` for all packages
  - `upgrade`: Runs `dart pub upgrade`/`flutter pub upgrade` for all packages
  - `publish`: Runs `dart pub publish`/`flutter pub publish` for all packages which need publishing
