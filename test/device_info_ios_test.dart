import 'package:device_info_ios/device_info_ios_method_channel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDeviceInfoIosPlatform with MockPlatformInterfaceMixin {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  test('$MethodChannelDeviceInfoIos is the default instance', () {});

  test('getPlatformVersion', () async {
    MockDeviceInfoIosPlatform fakePlatform = MockDeviceInfoIosPlatform();
  });
}
