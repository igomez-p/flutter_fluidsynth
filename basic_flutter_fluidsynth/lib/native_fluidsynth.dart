import 'dart:ffi'; // For FFI
import 'dart:io';

import 'package:ffi/ffi.dart'; // For Platform.isX

// C function signatures
typedef _init_func = Void Function();
typedef _load_func = Void Function(Pointer<Utf8>);
typedef _on_func = Void Function(Int32, Int32, Int32);
typedef _off_func = Void Function(Int32, Int32);
typedef _clean_func = Void Function();

// Dart function signatures
typedef _InitFunc = void Function();
typedef _LoadFunc = void Function(Pointer<Utf8>);
typedef _OnFunc = void Function(int, int, int);
typedef _OffFunc = void Function(int, int);
typedef _CleanFunc = void Function();

final DynamicLibrary nativeAddLib = Platform.isAndroid
    ? DynamicLibrary.open("libnative_fluidsynth.so")
    : DynamicLibrary.process();

final _InitFunc _init = nativeAddLib
    .lookup<NativeFunction<_init_func>>('initialize_fluidsynth')
    .asFunction();
final _LoadFunc _load = nativeAddLib
    .lookup<NativeFunction<_load_func>>('load_soundfont')
    .asFunction();
final _OnFunc _noteOn = nativeAddLib
    .lookup<NativeFunction<_on_func>>('note_on')
    .asFunction();
final _OffFunc _noteOff = nativeAddLib
    .lookup<NativeFunction<_off_func>>('note_off')
    .asFunction();
final _CleanFunc _clean = nativeAddLib
    .lookup<NativeFunction<_clean_func>>('clean_fluidsynth')
    .asFunction();

// Calling functions
void initFluidsynth() => _init();
void loadFluidsynth(String file) => _load(file.toNativeUtf8());
void noteOn(int param, int note, int vel) => _noteOn(param, note, vel);
void noteOff(int param, int note) => _noteOff(param, note);
void cleanFluidsynth() => _clean();