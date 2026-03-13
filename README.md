# Device App Info List

**Version:** 1.0.0

**Device App Info List** (`device_app_info_list`) is a Flutter plugin that provides utilities to interact with installed apps on a device. You can list installed apps, get app info (including installer source), launch apps, open settings, and more.

> ⚠️ Currently, only Android is supported. iOS methods return default/fallback values.

---

## API note

`getInstalledApps` and other methods use **named arguments**. Types like `AppInfo`, `PlatformType`, and `AppCategory` are exported from `package:device_app_info_list`.

## Features

* List installed apps with optional filters:
    * Exclude system apps
    * Exclude non-launchable apps
    * Filter by package name prefix
    * Filter by platform type
* Get detailed app info
* Launch apps by package name
* Open app settings
* Check if an app is system or installed
* Uninstall apps
* Show toast messages

---

## Installation

### Option 1: From pub.dev (when published)

If the package is published on [pub.dev](https://pub.dev), add it with:

```bash
flutter pub add device_app_info_list
```

Or add to your `pubspec.yaml`:

```yaml
dependencies:
  device_app_info_list: ^1.0.0
```

Then run `flutter pub get`.

### Option 2: From GitHub (without pub.dev)

To use the package directly from GitHub (e.g. before publishing or to use a specific branch/commit), add the dependency in your `pubspec.yaml`:

```yaml
dependencies:
  device_app_info_list:
    git:
      url: https://github.com/ushodmonov/device_app_info_list.git
      ref: main   # or: develop, or a tag like v1.0.0, or a commit hash
```

Then run:

```bash
flutter pub get
```

Use the same import in your Dart code in both cases:

```dart
import 'package:device_app_info_list/installed_apps.dart';
```

**Example project:** [GitHub](https://github.com/ushodmonov/device_app_info_list/tree/main/example)

---

## Usage

Add the dependency and import:

```dart
import 'package:device_app_info_list/installed_apps.dart';
```

### Get Installed Apps

```dart
List<AppInfo> apps = await InstalledApps.getInstalledApps(
  // Optional: whether to exclude system apps from the list. Default is true.
  excludeSystemApps: true,

  // Optional: whether to exclude apps that cannot be launched (no launch intent). Default is true.
  excludeNonLaunchableApps: true,

  // Optional: whether to include app icons in the result. Default is false.
  withIcon: false,

  // Optional: filter apps whose package names start with this prefix. Default is null (no filtering).
  packageNamePrefix: "com.example",

  // Optional: filter apps by platform type (Flutter, React Native, etc.). Default is null (no filtering).
  platformType: PlatformType.flutter,
);
```

### Get App Info

```dart
AppInfo? app = await InstalledApps.getAppInfo("com.example.myapp");
```

### AppInfo model

```dart
class AppInfo {
  String name;
  Uint8List? icon; // nullable
  String packageName;
  String versionName;
  int versionCode;
  PlatformType platformType;
  int installedTimestamp;
  bool isSystemApp;
  bool isLaunchableApp;
  AppCategory category;
  String? installer; // nullable, see Installer field below
}
```

### Installer field

`installer` indicates which app/store installed the package (Android only). Possible values:

| Installer | Meaning |
|-----------|---------|
| `com.android.vending` | Play Store |
| `com.amazon.venezia` | Amazon Store |
| `null` | Installed via APK (sideloaded) or unknown source |

### Launch App

```dart
await InstalledApps.startApp("com.example.myapp");
```

### Open App Settings

```dart
InstalledApps.openSettings("com.example.myapp");
```

### Check System App

```dart
bool? isSystem = await InstalledApps.isSystemApp("com.example.myapp");
```

### Uninstall App

```dart
bool? success = await InstalledApps.uninstallApp("com.example.myapp");
```

### Check if Installed

```dart
bool? installed = await InstalledApps.isAppInstalled("com.example.myapp");
```

---

## AppCategory enum

> ⚠️ Only available on Android API 28+. On lower SDK versions, all apps will have `undefined`.

```dart
enum AppCategory {
  game(0, "Game"),
  audio(1, "Audio"),
  video(2, "Video"),
  image(3, "Image"),
  social(4, "Social"),
  news(5, "News"),
  maps(6, "Maps"),
  productivity(7, "Productivity"),
  accessibility(8, "Accessibility"),
  undefined(-1, "Undefined");
}
```

---

## PlatformType enum

```dart
enum PlatformType {
  flutter('flutter', 'Flutter'),
  reactNative('react_native', 'React Native'),
  xamarin('xamarin', 'Xamarin'),
  ionic('ionic', 'Ionic'),
  nativeOrOthers('native_or_others', 'Native or Others');
}
```

---

### QUERY_ALL_PACKAGES Permission and Play Store Review

The `QUERY_ALL_PACKAGES` permission is required for some functionality of `device_app_info_list`, but
including it can cause Play Store rejections if your app doesn’t justify it. To handle this, either
declare its necessity in the Play Store listing or use `tools:node="remove"` in your manifest to
exclude it while still using the plugin (note this will limit visibility to all apps). For
multi-flavor setups, you can include the permission in `src/dev/AndroidManifest.xml` for
internal/dev builds and remove it in `src/playstore/AndroidManifest.xml` for Play Store builds,
ensuring each flavor has the correct manifest without affecting core functionality.

## Notes

* Android requires `QUERY_ALL_PACKAGES` permission for full app visibility. Ensure compliance with
  Play Store policies.
* All methods catch exceptions and return default/fallback values to prevent crashes.
* Platform type detection is heuristic and may misclassify some apps. Improvements are ongoing.

---

## Support

If you encounter any issues or have suggestions,
please [open an issue on GitHub](https://github.com/ushodmonov/device_app_info_list/issues).
Contributions and feedback are welcome!
