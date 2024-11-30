import Flutter
import UIKit

public class DeviceInfoIosPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "device_info_ios", binaryMessenger: registrar.messenger())
    let instance = DeviceInfoIosPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }



  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "getBatteryLevel" { batteryLevel(result: result) }
    if call.method == "getDeviceName" { deviceName(result: result)  }
    if call.method == "getDeviceModel" { deviceName(result: result)  }
    if call.method == "getSystemName" { deviceName(result: result)  }
    if call.method == "getSystemVersion" { deviceName(result: result)  }
  }

    private func batteryLevel(result: FlutterResult) {
       UIDevice.current.isBatteryMonitoringEnabled = true
       result(Int(UIDevice.current.batteryLevel * 100))
    }

    private func deviceName(result: FlutterResult) {
       result(UIDevice.current.name)
    }

    private func deviceModel(result: FlutterResult) {
           result(UIDevice.current.model)
    }

    private func systemName(result: FlutterResult) {
           result(UIDevice.current.systemName)
    }

    private func systemVersion(result: FlutterResult) {
           result(UIDevice.current.systemVersion)
    }
}

enum PlatformErrors: Error{
   case methodNotImplement
}

