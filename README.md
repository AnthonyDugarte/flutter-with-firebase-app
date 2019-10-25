# flutter_with_firebase_course

A new Flutter project.

## Setting up environment

### Google app

#### Android

-   On Firebase apps. Select or create Android and download **google-services.json** file.
-   Save **google-services.json** on _android/app_ folder.

#### iOS

-   On Firebase apps. Select or create iOS and download **GoogleService-Info.plist** file.
-   Save **GoogleService-Info.plist** on _ios/Runner_ folder.

### Singing

#### Android

-   [Create a key store](https://flutter.dev/docs/deployment/android#create-a-keystore)

Mac/Linux:

```bash
keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
```

Windows:

```bash
keytool -genkey -v -keystore c:/Users/USER_NAME/key.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias key
```

-   Create _android/key.properties_ file with following content:

```bash
    storePassword=<password from previous step>
    keyPassword=<password from previous step>
    keyAlias=key
    storeFile=<location of the key store file, such as /Users/<user name>/key.jks>
```

### Building APK

```bash
flutter build apk
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

-   [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
-   [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

```

```
