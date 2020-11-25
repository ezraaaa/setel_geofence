# Setel Geofence

Setel Geofence is an app that showcases the ability to detect users' entrance and exit from a region.

## Getting Started

Before we get started, let's make sure your computer is done setting up. Follow this [guide](https://flutter.io/get-started/install/)
To know if your computer is done setting up, run this command in your terminal:
```
flutter doctor
```

Once you are done setting up, run the following command in your terminal

```
flutter channel beta
flutter upgrade
https://github.com/ezraaaa/setel_geofence.git
cd setel_geofence
flutter packages get
open -a Simulator
flutter run
```

## Generating launcher icons

Place your icon into `assets/logo` folder and name it `setel.png` and run the command below
```
flutter pub pub run flutter_launcher_icons:main
```

## Using json_serializable
To watch for changes and generate model, run command:
```
flutter pub run build_runner watch
```

## Build and Release
### Build release APK
To build and release for Android, follow this [guide](https://flutter.io/android-release/) and you can run the following command:

1. Create `key.properties` file in `android` folder and copy the references below as content:
    ```
    storePassword=android
    keyPassword=android
    keyAlias=key
    storeFile=/Users/<username>/codeink_key.jks
    ```
2. Download the keystore and put into the path you defined in step 1
3. Run command:
    ```
    flutter build apk
    ```
    or just simply copy the command below
    ```
    flutter build apk && cd build/app/outputs/flutter-apk/ && open . && cd ../../../../
    ```

### Build App Bundle
1. Follow step 1 and step 2 in `Build release APK`
2. Run command:
    ```
    flutter build appbundle
    ```
    or just simply copy the command below
    ```
    flutter build appbundle && cd build/app/outputs/bundle/productionRelease/ && open . && cd ../../../../../
    ```

To build and release for iOS, follow this [guide](https://flutter.io/ios-release/)

## Known Issues
* Exit of a geofence does not work on Android, however, it works on iOS. [View Issue](https://github.com/DwayneCoussement/flutter_geofence/issues/5)
* 'Always' location permission access needed for Android in order for the app to start listening geofence acitivty
* ScaffoldMessengerState isn't stable causing malfunction of SnackBar [View Issue](https://flutter.dev/docs/release/breaking-changes/scaffold-messenger)

## Possible future enhancement
* Open only 1 station details if both wifi ssid matched and location match (With WiFi as the highest priority)
* Hold a location and prepopulate station form
* Authentication