#!/bin/sh

# export ABIS="armeabi-v7a arm64-v8a x86 x86_64"
export ABIS="arm64-v8a"

for ABI in ABIS; do
  mkdir -p build/android
  cd build/android

  cmake ../.. \
    -DCMAKE_TOOLCHAIN_FILE="$ANDROID_NDK/build/cmake/android.toolchain.cmake" \
    -DANDROID_ABI="$ABI" \
    -DANDROID_PLATFORM=26 \
    -DCMAKE_INSTALL_PREFIX="../../build/android/$ABI" \
    -DOS=ANDROID \
    -DSHARED=YES

  cmake --build . --config Release
  cmake --install . --config Release
  cd ../..

  mkdir -p prebuilt/android/$ABI
  cp "build/android/libgeneral_audio.so" prebuilt/android/$ABI/libgeneral_audio.so

  rm -rf build/android
done
