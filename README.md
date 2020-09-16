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
[✓] Flutter (Channel stable, 1.20.3, on Mac OS X 10.15.6 19G2021, locale ja-JP)

[✓] Android toolchain - develop for Android devices (Android SDK version 29.0.3)
[✓] Xcode - develop for iOS and macOS (Xcode 11.7)
[✓] Android Studio (version 4.0)
[✓] IntelliJ IDEA Ultimate Edition (version 2020.2.1)
[✓] IntelliJ IDEA Community Edition (version 2019.2.3)
[!] VS Code (version 1.49.0)
    ✗ Flutter extension not installed; install from
      https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter
[✓] Connected device (2 available)

! Doctor found issues in 1 category.
```
