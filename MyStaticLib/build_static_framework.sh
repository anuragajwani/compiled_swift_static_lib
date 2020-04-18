# 0. clean build directories
rm -rf   derived_data   MyStaticLib.framework
# 1.1 Build static library for simulator
xcodebuild build   -scheme MyStaticLib   -derivedDataPath derived_data   -arch x86_64   -sdk iphonesimulator
# 1.2 Build static library for iOS devices
xcodebuild build   -scheme MyStaticLib   -derivedDataPath derived_data   -arch arm64   -sdk iphoneos
# 2. Create framework
mkdir MyStaticLib.framework/
# 3. Create binary compatible with devices and simulators
lipo -create   derived_data/Build/Products/Debug-iphoneos/libMyStaticLib.a   derived_data/Build/Products/Debug-iphonesimulator/libMyStaticLib.a   -o MyStaticLib.framework/MyStaticLib
# 4.1 Create empty public interface directory
mkdir MyStaticLib.framework/MyStaticLib.swiftmodule
# 4.2 Copy public interfaces for device and simulators into static framework public interfaces directory
cp -r derived_data/Build/Products/*/*.swiftmodule/* MyStaticLib.framework/MyStaticLib.swiftmodule
