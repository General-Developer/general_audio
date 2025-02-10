#!/bin/bash

export ANDROID_NDK=$HOME/Android/Sdk/ndk/27.2.12479018
ANDROID_ABIS="arm64-v8a armeabi-v7a x86 x86_64"

for ANDROID_ABI in $ANDROID_ABIS; do
  mkdir -p build/android
  cd build/android

  cmake ../.. \
    -DCMAKE_TOOLCHAIN_FILE="$ANDROID_NDK/build/cmake/android.toolchain.cmake" \
    -DANDROID_ABI="$ANDROID_ABI" \
    -DANDROID_PLATFORM=23 \
    -DCMAKE_INSTALL_PREFIX="../../build/android/$ABI" \
    -DOS=ANDROID \
    -DSHARED=YES

  cmake --build . --config Release
  cmake --install . --config Release
  cd ../..

  mkdir -p prebuilt/android/$ANDROID_ABI
  cp "build/android/libgeneral_audio.so" prebuilt/android/$ANDROID_ABI/libgeneral_audio.so

  rm -rf build/android
done
