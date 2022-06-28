# Fluidsynth with Flutter
A basic app to migrate the fluidsynth lib with flutter
***

## General Info
[FuidSynth](https://www.fluidsynth.org/) is a **real-time synthesizer** based on the **SoundFont 2** specifications, which permit convert midi notes into a signal audio without the need for a SoundFont compatible sound card.

This open source software is programmed in **C language** and all the mobile applications which implemented it are only for Android, using Native Development Kit (NDK). But i needed to implement it on a Flutter app.

On the other hand, using a native C or C++ code in a Dart language is not a easy task although there is a dependency to do this: [dart:ffi](https://flutter.dev/docs/development/platform-integration/c-interop)

For this reason, i have decided to program this basic application to help someone who needs it.

## Resources
The first step is donwload the Fluidsynth for Android and Source-code files from https://github.com/FluidSynth/fluidsynth/releases

Once the two folders are unzipped, we will have four folders inside Flutter Android lib: **arm64-v8a**, **armeabi-v7a**, **x86** **and x86_64**; and from Source-code we are going to need only the **src** folder. Later, we copy the src folder in flutter folder remaining as follow:

```
fluidsynth/
    include/
    lib/
    src/
```

Also you should have the **Android Studio** and **Flutter** installed on your PC and create a new Flutter project.

## Implementation

### Generate the plugin
At the project terminal we should corroborate the route of the project. Then, we create the plugin with the following command:
```sh
flutter create --platforms=android,ios --template=plugin native_fluidsynth
```
A new folder *native_fluidsynth* will be create in our project. To avoid compilation problems, we comment the .dart code by default in the test folder of the generated plugin.

From now on, in order not to confuse directories, we will call **NATIVE\_DIR** the one corresponding to the plugin and **PROJECT\_DIR** the general one of the project; where the second includes the first.

We have to add the dependency **ffi** and the plugin path at the PROJECT\_DIR/pubspec.yaml like:

```
dependencies:
    ffi: ^1.1.2
    native_fluidsynth:
        path: native_fluidsynth
```

### Adding the fluidsynth lib
We are going to copy the **folder fluidsynth** that we obtained in the Resources section to the project path **NATIVE\_DIR/ios/Classes/** . At this path we create a ***native_fluidsynth.cpp*** file too that we are going to use later. Remaining:

```
NATIVE_DIR/ios/Classes/
    fluidsynth/
    native_fluidsynth.cpp
```

The next step will be to generate a call to these files and libraries. For this we will create a [CMakeLists.txt](https://github.com/igomez-p/flutter_fluidsynth/blob/main/basic_flutter_fluidsynth/native_fluidsynth/android/CMakeLists.txt) file in path **NATIVE\_DIR/android/** .

This file should be called too, so at the [build.gradle](https://github.com/igomez-p/flutter_fluidsynth/blob/main/basic_flutter_fluidsynth/native_fluidsynth/android/build.gradle) in **NATIVE\_DIR/android/** we'll add the following lines:

```
android {
    [...]
    externalNativeBuild {
        // Encapsulates your CMake build configurations.
        cmake {
            // Provides a relative path to your CMake build script.
            path "CMakeLists.txt"
        }
    }
}
```

We can now fill our [native_fluidsynth.cpp](https://github.com/igomez-p/flutter_fluidsynth/blob/main/basic_flutter_fluidsynth/native_fluidsynth/ios/Classes/native_fluidsynth.cpp) file with the required calls to fluidsynth.

### Back to Dart
Now, we are going to call the C functions from a new *dart* file. The [native_fluidsynth.dart](https://github.com/igomez-p/flutter_fluidsynth/blob/main/basic_flutter_fluidsynth/lib/native_fluidsynth.dart) that we have to create is at **PROJECT\_DIR/lib/** path.

### Generating a sound
To reproduce a sound with fluidsynth, we need a **SoundFont file** whose extension is **.sf2**. I have donwloaded one from Internet.

To add it to the project, we have to create a folder **assets** at **PROJECT\_DIR/**. I have added another folder **sndfnt** to differentiate from other elements that we add. Then, we copy the sound in the folder.

Flutter also needs to detect the file, so we modify the **PROJECT\_DIR/pubspec.yaml** by adding:

```
flutter:
    assets:
        - assets/sndfnt/sndfnt.sf2
```

Finally, to start the sound with fluidsynth, it is necessary to **load it in the cache** beforehand. In our [main.dart](https://github.com/igomez-p/flutter_fluidsynth/blob/main/basic_flutter_fluidsynth/lib/main.dart) we create the following function that requires the use of the **path_provider** dependency (see final [pubspec.yaml](https://github.com/igomez-p/flutter_fluidsynth/blob/main/basic_flutter_fluidsynth/pubspec.yaml)).

```dart
Future<void> loadFluidsynthFile(String fileName) async {
  ByteData sound = await rootBundle.load('assets/sndfnt/$fileName');

  File soundFile = File('${(await getTemporaryDirectory()).path}/$fileName');

  Future.wait([soundFile.writeAsBytes(sound.buffer.asUint8List(sound.offsetInBytes, sound.lengthInBytes))])
  .then((value) => loadFluidsynth(soundFile.path));
}
```

**We can now use the fluidsynth functions in flutter.** In this app, the audio driver is initialized and the sound is loaded into the main program, and the different buttons on the screen will be charging the different notes.

