#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "SndFile::sndfile" for configuration ""
set_property(TARGET SndFile::sndfile APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(SndFile::sndfile PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libsndfile.so"
  IMPORTED_SONAME_NOCONFIG "libsndfile.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS SndFile::sndfile )
list(APPEND _IMPORT_CHECK_FILES_FOR_SndFile::sndfile "${_IMPORT_PREFIX}/lib/libsndfile.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
