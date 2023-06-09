import 'dart:developer' as developer;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteConfigService {
  const FirebaseRemoteConfigService({
    required this.firebaseRemoteConfig,
  });

  final FirebaseRemoteConfig firebaseRemoteConfig;

  Future<void> init() async {
    try {
      await firebaseRemoteConfig.ensureInitialized();

      await firebaseRemoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 5),
          minimumFetchInterval: const Duration(seconds: 5),
        ),
      );
      await firebaseRemoteConfig.fetchAndActivate();
    } on FirebaseException catch (e, st) {
      developer.log(
        'Unable to initialize Firebase Remote Config',
        error: e,
        stackTrace: st,
      );
    }
  }

  String getEventInfoJson() => firebaseRemoteConfig.getString('event_info');

  String getAppVersionJson() => firebaseRemoteConfig.getString('app_version');

  String getStreamLink() => firebaseRemoteConfig.getString('stream_link');

  bool getStreamLive() => firebaseRemoteConfig.getBool('stream_live');

  bool getFavoritesEnabled() =>
      firebaseRemoteConfig.getBool('favorites_enabled');

  String getFavoriteButtonType() =>
      firebaseRemoteConfig.getString('favorite_button_type');
}
