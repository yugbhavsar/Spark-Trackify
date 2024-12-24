class DeviceDataModel {
  String? deviceId;
  String? deviceName;
  String? modelName;
  String? version;
  String? deviceImage;
  String? os;
  CurrentActiveUser? currentActiveUser;
  List<CurrentActiveUser>? history;

  DeviceDataModel({
    this.deviceId,
    this.deviceName,
    this.modelName,
    this.version,
    this.deviceImage,
    this.os,
    this.currentActiveUser,
    this.history,
  });

  factory DeviceDataModel.fromMap(String? id, Map<dynamic, dynamic> json) => DeviceDataModel(
        deviceId: id,
        deviceName: json["deviceName"],
        modelName: json["modelName"],
        version: json["version"],
        deviceImage: json["deviceImage"],
        os: json["os"],
        currentActiveUser: json["currentActiveUser"] == null ? null : CurrentActiveUser.fromMap(json["currentActiveUser"]),
        history:
            json["history"] == null ? [] : List<CurrentActiveUser>.from(json["history"]!.map((x) => CurrentActiveUser.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": deviceId,
        "deviceName": deviceName,
        "modelName": modelName,
        "version": version,
        "deviceImage": deviceImage ?? "",
        "os": os,
        "currentActiveUser": currentActiveUser?.toMap() ?? {},
        "history": history == null ? [] : List<dynamic>.from(history!.map((x) => x.toMap())),
      };
}

class CurrentActiveUser {
  String? empId;
  String? firstName;
  String? lastName;
  String? empImage;
  String? assignFor;
  String? note;
  DateTime? createdAt;
  DateTime? deletedAt;

  CurrentActiveUser({
    this.empId,
    this.firstName,
    this.lastName,
    this.empImage,
    this.assignFor,
    this.note,
    this.createdAt,
    this.deletedAt,
  });

  factory CurrentActiveUser.fromMap(Map<dynamic, dynamic> json) => CurrentActiveUser(
        empId: json["empId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        empImage: json["empImage"],
        assignFor: json["assignFor"],
        note: json["note"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        deletedAt: json["deletedAt"] == null ? null : DateTime.parse(json["deletedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "empId": empId,
        "firstName": firstName,
        "lastName": lastName,
        "empImage": empImage,
        "assignFor": assignFor,
        "note": note,
        "createdAt": createdAt?.toIso8601String(),
        "deletedAt": deletedAt?.toIso8601String(),
      };
}