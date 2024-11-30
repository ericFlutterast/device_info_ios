import 'dart:async';

import 'package:device_info_ios/device_info_ios_method_channel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int? batteryLevel;
  String? deviceName;

  @override
  void initState() {
    super.initState();
  }

  final future = Future<_DeviceInfoData>(() async {
    try {
      final deviceInfo = MethodChannelDeviceInfoIos();
      final deviceBatteryLevel = await deviceInfo.batteryLevel();
      final deviceName = await deviceInfo.deviseName();

      final result = await Future.wait([
        deviceInfo.batteryLevel(),
        deviceInfo.deviseName(),
        deviceInfo.model(),
        deviceInfo.systemName(),
        deviceInfo.systemVersion(),
      ]);

      return _DeviceInfoData(
        batteryLevel: (result[0] as num).toInt(),
        deviceName: result[1].toString(),
        deviceModel: result[2].toString(),
        systemName: result[3].toString(),
        systemVersion: result[4].toString(),
      );

      // final a = await Future.forEach(
      //   [deviceInfo.batteryLevel(), deviceInfo.deviseName()],
      //   (action) {
      //     return action;
      //   },
      // );
    } on PlatformException {
      rethrow;
    }
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: const Text('device info ios'),
          ),
          body: FutureBuilder<_DeviceInfoData>(
            future: future,
            initialData: null,
            builder: (context, snapShot) {
              if (snapShot.data == null) {
                return const Center(child: CircularProgressIndicator());
              }

              return Center(
                child: Column(
                  children: [
                    const SizedBox(height: 120),
                    Text('battery level: ${snapShot.data?.batteryLevel}'),
                    const SizedBox(height: 20),
                    Text('device name: ${snapShot.data?.deviceName}'),
                    const SizedBox(height: 20),
                    Text('device model: ${snapShot.data?.deviceModel}'),
                    const SizedBox(height: 20),
                    Text('system name: ${snapShot.data?.systemName}'),
                    const SizedBox(height: 20),
                    Text('system version: ${snapShot.data?.systemVersion}'),
                  ],
                ),
              );
            },
          )),
    );
  }
}

final class _DeviceInfoData {
  _DeviceInfoData({
    required String deviceName,
    required String deviceModel,
    required String systemName,
    required String systemVersion,
    required int batteryLevel,
  })  : _batteryLevel = batteryLevel,
        _deviceName = deviceName,
        _deviceModel = deviceModel,
        _systemName = systemName,
        _systemVersion = systemVersion;

  final int _batteryLevel;
  final String _deviceName;
  final String _deviceModel;
  final String _systemName;
  final String _systemVersion;

  int get batteryLevel => _batteryLevel;
  String get deviceName => _deviceName;
  String get deviceModel => _deviceModel;
  String get systemName => _systemName;
  String get systemVersion => _systemVersion;
}
