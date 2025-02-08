PLATFORMS=(OS64 SIMULATORARM64 MAC_ARM64)

for PLATFORM in "${PLATFORMS[@]}"
do
  mkdir -p build/apple
  cd build/apple

  cmake ../.. \
    -B . \
    -G Xcode \
    -DCMAKE_TOOLCHAIN_FILE=ios.toolchain.cmake \
    -DPLATFORM="$PLATFORM" \
    -DENABLE_BITCODE=NO \
    -DENABLE_STRICT_TRY_COMPILE=YES \
    -DCMAKE_INSTALL_PREFIX="../.." \
    -DOS=APPLE \
    -DSHARED=NO
  
  cmake --build . --config Release
  cmake --install . --config Release
  cd ../..

  rm -rf build/apple
done

mkdir -p prebuilt/apple
cd prebuilt/apple

rm -rf general_audio.xcframework
xcodebuild -create-xcframework \
  -framework "OS64/general_audio.framework" \
  -framework "SIMULATORARM64/general_audio.framework" \
  -framework "MAC_ARM64/general_audio.framework" \
  -output "general_audio.xcframework"

cp -r ios.general_audio_Privacy.bundle "general_audio.xcframework/ios-arm64/general_audio_Privacy.bundle"
cp -r ios.general_audio_Privacy.bundle "general_audio.xcframework/ios-arm64-simulator/general_audio_Privacy.bundle"
