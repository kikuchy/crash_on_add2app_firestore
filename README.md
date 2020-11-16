The repository to reproduce crashing on add2app using app.

## Problem

Crash will cause at the conditions below.

* Using add-to-app on iOS
* Accessing to Firestore instance from Platform(iOS) app before accessing to it from Flutter app

## Cause

cloud_firestore plugin [is caching initialized Firestore instances](https://github.com/FirebaseExtended/flutterfire/blob/c95c7ef9608a699106bb280d8a2e173b09e2368f/packages/cloud_firestore/cloud_firestore/ios/Classes/FLTFirebaseFirestoreReader.m#L215-L231).

After initializing Firestore instances from Platform app,
`[FIRFirestore firestoreForApp:app]` will return cached Firestore instance.
And `firestore.settings = settings` will cause crash by the hard assertion.


## Flutter doctor

```
$ flutter doctor
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 1.22.4, on Mac OS X 10.15.7 19H15 darwin-x64,
    locale ja-JP)

[✓] Android toolchain - develop for Android devices (Android SDK version 29.0.3)
[✓] Xcode - develop for iOS and macOS (Xcode 12.0)
[!] Android Studio (version 4.1)
    ✗ Flutter plugin not installed; this adds Flutter specific functionality.
    ✗ Dart plugin not installed; this adds Dart specific functionality.
[!] Android Studio (version 4.1)
    ✗ Flutter plugin not installed; this adds Flutter specific functionality.
    ✗ Dart plugin not installed; this adds Dart specific functionality.
[✓] IntelliJ IDEA Ultimate Edition (version 2020.2.2)
[✓] IntelliJ IDEA Community Edition (version 2019.2.3)
[!] VS Code (version 1.51.0)
    ✗ Flutter extension not installed; install from
      https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter
[✓] Connected device (1 available)

! Doctor found issues in 3 categories.
```
