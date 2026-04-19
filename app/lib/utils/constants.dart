import 'package:flutter/foundation.dart';
import 'package:resonate/proto/common.pbenum.dart';
import 'package:universal_io/io.dart';
// import 'package:device_info_plus/device_info_plus.dart';

// class DeviceInfo {
//   DeviceInfo() {
//     init();
//   }

//   Future<void> init() async {
//     DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//     if (Platform.isAndroid) {
//       AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//       androidInfo.

//     } else if (Platform.isIOS) {
//       IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

//     }
//   }
// }

String get BASE_URL {
  if (kReleaseMode) {
    return const String.fromEnvironment("BASE_URL");
  } else if (Platform.isAndroid) {
    // Android uses 10.0.2.2 for localhost
    return 'https://10.0.2.2';
  }
  return 'https://localhost';
}

const String CLIENT_VERSION = String.fromEnvironment("CLIENT_VERSION");

ClientPlatform get CLIENT_PLATFORM {
  if (kIsWeb) {
    return ClientPlatform.CLIENT_PLATFORM_WEB;
  } else if (Platform.isAndroid) {
    return ClientPlatform.CLIENT_PLATFORM_ANDROID;
  } else if (Platform.isIOS) {
    return ClientPlatform.CLIENT_PLATFORM_IOS;
  } else {
    return ClientPlatform.CLIENT_PLATFORM_UNKNOWN;
  }
}

// Whether to enable the feature to upload contacts
// from the user's phone book.
const bool ENABLED_CONTACTS = bool.fromEnvironment(
  "ENABLED_CONTACTS",
  defaultValue: false,
);

const bool ENABLE_DOWNLOADS = bool.fromEnvironment(
  "ENABLE_DOWNLOADS",
  defaultValue: false,
);

const bool ENABLE_PLAYLIST = bool.fromEnvironment(
  "ENABLE_PLAYLIST",
  defaultValue: true,
);
