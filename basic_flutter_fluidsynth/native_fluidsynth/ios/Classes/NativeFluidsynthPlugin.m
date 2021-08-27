#import "NativeFluidsynthPlugin.h"
#if __has_include(<native_fluidsynth/native_fluidsynth-Swift.h>)
#import <native_fluidsynth/native_fluidsynth-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "native_fluidsynth-Swift.h"
#endif

@implementation NativeFluidsynthPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNativeFluidsynthPlugin registerWithRegistrar:registrar];
}
@end
