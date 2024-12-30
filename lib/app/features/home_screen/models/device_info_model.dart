class DeviceInfoModel {
  String deviceName;
  String deviceId;
  String modelName;
  String version;
  String os;

  DeviceInfoModel({
    required this.deviceName,
    required this.deviceId,
    required this.modelName,
    required this.version,
    required this.os,
  });

  @override
  String toString() {
    return 'DeviceInfoModel{deviceName: $deviceName, deviceId: $deviceId, modelName: $modelName, version: $version, os: $os}';
  }
}
