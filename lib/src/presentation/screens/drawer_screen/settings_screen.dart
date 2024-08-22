import 'package:flutter/material.dart';
import 'package:flutter_programming_question_collection/src/data/datasources/local/notification_prefs_service.dart';
import 'package:simple_app_cache_manager/simple_app_cache_manager.dart';
import 'package:version_tracker/version_tracker.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with WidgetsBindingObserver, CacheMixin, VersionMixin, NotificationMixin {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    notificationPrefs = NotificationPrefsServiceImpl();
    updateNotificationSetting();

    cacheManager = SimpleAppCacheManager();
    updateCacheSize();

    versionTracker = VersionTracker();
    updateVersion();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      recheckNotificationPermission();
    }
  }

  void recheckNotificationPermission() async {
    notificationPrefs.askPermission().then((status) {
      notificationPrefs.getNotificationState().then((status) {
        updateNotificationSetting(status: status);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
    );
  }
}

mixin NotificationMixin on State<SettingsScreen> {
  late final NotificationPrefsServiceImpl notificationPrefs;
  final notificationPrefsNotifier = ValueNotifier<bool>(false);

  void updateNotificationSetting({bool? status}) async {
    var isEnabled = await notificationPrefs.getNotificationState();
    notificationPrefsNotifier.value = status ?? isEnabled ?? false;
  }
}

mixin CacheMixin on State<SettingsScreen> {
  late final SimpleAppCacheManager cacheManager;
  final cacheSizeNotifier = ValueNotifier<String>('');

  void updateCacheSize() async {
    final cacheSize = await cacheManager.getTotalCacheSize();
    cacheSizeNotifier.value = cacheSize;
  }
}

mixin VersionMixin on State<SettingsScreen> {
  late final VersionTracker versionTracker;
  final versionNotifier = ValueNotifier<String>('');

  void updateVersion() async {
    await versionTracker.track();
    versionNotifier.value = versionTracker.currentVersion!;
  }
}
