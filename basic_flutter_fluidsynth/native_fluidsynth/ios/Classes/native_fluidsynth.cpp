#define _LARGEFILE64_SOURCE

#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

#include "fluidsynth.h"
#include "fluidsynth/types.h"
#include "fluidsynth/settings.h"
#include "fluidsynth/synth.h"
#include "fluidsynth/shell.h"
#include "fluidsynth/sfont.h"
#include "fluidsynth/audio.h"
#include "fluidsynth/event.h"
#include "fluidsynth/midi.h"
#include "fluidsynth/seq.h"
#include "fluidsynth/seqbind.h"
#include "fluidsynth/log.h"
#include "fluidsynth/misc.h"
#include "fluidsynth/mod.h"
#include "fluidsynth/gen.h"
#include "fluidsynth/voice.h"
#include "fluidsynth/version.h"
#include "fluidsynth/ladspa.h"
#include <jni.h>


fluid_settings_t *settings;
fluid_synth_t *synth;
fluid_audio_driver_t *adriver;
const char *soundfontPath;


extern "C" __attribute__((visibility("default"))) __attribute__((used))
void initialize_fluidsynth(void) {
    settings = new_fluid_settings();
    synth = new_fluid_synth(settings);
    adriver = new_fluid_audio_driver(settings, synth);
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
void load_soundfont(char *file) {
    fluid_synth_sfload(synth, file, 1);
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
void note_on(int param, int note, int vel) {
    fluid_synth_noteon(synth, param, note, vel);
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
void note_off(int param, int note) {
    fluid_synth_noteoff(synth, param, note);
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
void clean_fluidsynth(void) {
    delete_fluid_audio_driver(adriver);
    delete_fluid_synth(synth);
    delete_fluid_settings(settings);
}