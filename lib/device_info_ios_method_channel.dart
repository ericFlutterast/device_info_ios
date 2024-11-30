import 'package:device_info_platform_interface/device_info_platform_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// An implementation of [DeviceInfoIosPlatform] that uses method channels.
class MethodChannelDeviceInfoIos implements DeviceInfoPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('device_info_ios');

  //TODO : изменить проблему возврата нулевого значения
  @override
  Future<num> batteryLevel() async => await methodChannel.invokeMethod<num>('getBatteryLevel') ?? 0;

  @override
  Future<String> deviseName() async =>
      await methodChannel.invokeMethod<String>('getDeviceName') ?? '';

  @override
  Future<String> model() async => await methodChannel.invokeMethod<String>('getDeviceModel') ?? '';

  @override
  Future<String> systemName() async =>
      await methodChannel.invokeMethod<String>('getSystemName') ?? '';

  @override
  Future<String> systemVersion() async =>
      await methodChannel.invokeMethod<String>('getSystemVersion') ?? '';
}
