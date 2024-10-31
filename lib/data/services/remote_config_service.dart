import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:ww_2/data/api/api_settings.dart';
import 'package:ww_2/data/api/links.dart';
class RemoteConfigService {
  RemoteConfigService() {
    remoteConfig = FirebaseRemoteConfig.instance;
    init();
  }
  late FirebaseRemoteConfig remoteConfig;
  Future<void> init() async {
    try {
      await remoteConfig.ensureInitialized();
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: Duration.zero,
        ),
      );
      await remoteConfig.fetchAndActivate();
    } on FirebaseException catch (e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    }
  }
  String get termsLink {
    try {
      return remoteConfig.getString('termsLink');
    } catch (_) {
      return AppLinks.terms;
    }
  }
  String get privacyLink {
    try {
      return remoteConfig.getString('privacyLink');
    } catch (_) {
      return AppLinks.privacy;
    }
  }
  String get aboutUsLink {
    try {
      return remoteConfig.getString('aboutUsLink');
    } catch (_) {
      return AppLinks.about;
    }
  }
  String get apphudKey {
    try {
      return remoteConfig.getString('apphudKey');
    } catch (_) {
      return ApiSettings.apphudKey;
    }
  }
}