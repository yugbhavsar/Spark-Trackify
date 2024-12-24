class EmployeeModel {
  int? id;
  String? firstname;
  String? lastname;
  String? profileImage;
  bool? isWfhAllowed;
  String? designation;
  String? contactNo;
  String? email;
  Date? joiningDate;
  String? employeeId;
  Date? probationEndDate;
  String? emergencyContactNo;
  String? emergencyContactPerson;
  String? address;
  String? perAddress;
  String? departmentname;
  dynamic reportFullname;
  String? batch;
  List<UserTagList>? userTagList;
  String? workStatus;

  EmployeeModel({
    this.id,
    this.firstname,
    this.lastname,
    this.profileImage,
    this.isWfhAllowed,
    this.designation,
    this.contactNo,
    this.email,
    this.joiningDate,
    this.employeeId,
    this.probationEndDate,
    this.emergencyContactNo,
    this.emergencyContactPerson,
    this.address,
    this.perAddress,
    this.departmentname,
    this.reportFullname,
    this.batch,
    this.userTagList,
    this.workStatus,
  });

  factory EmployeeModel.fromMap(Map<String, dynamic> json) => EmployeeModel(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        profileImage: json["profile_image"],
        isWfhAllowed: json["is_wfh_allowed"],
        designation: json["designation"],
        contactNo: json["contact_no"],
        email: json["email"],
        joiningDate: json["joining_date"] == null ? null : Date.fromMap(json["joining_date"]),
        employeeId: json["employee_id"],
        probationEndDate: json["probation_end_date"] == null ? null : Date.fromMap(json["probation_end_date"]),
        emergencyContactNo: json["emergency_contact_no"],
        emergencyContactPerson: json["emergency_contact_person"],
        address: json["address"],
        perAddress: json["per_address"],
        departmentname: json["departmentname"],
        reportFullname: json["report_fullname"],
        batch: json["batch"],
        userTagList:
            json["user_tag_list"] == null ? [] : List<UserTagList>.from(json["user_tag_list"]!.map((x) => UserTagList.fromMap(x))),
        workStatus: json["work_status"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "profile_image": profileImage,
        "is_wfh_allowed": isWfhAllowed,
        "designation": designation,
        "contact_no": contactNo,
        "email": email,
        "joining_date": joiningDate?.toMap(),
        "employee_id": employeeId,
        "probation_end_date": probationEndDate?.toMap(),
        "emergency_contact_no": emergencyContactNo,
        "emergency_contact_person": emergencyContactPerson,
        "address": address,
        "per_address": perAddress,
        "departmentname": departmentname,
        "report_fullname": reportFullname,
        "batch": batch,
        "user_tag_list": userTagList == null ? [] : List<dynamic>.from(userTagList!.map((x) => x.toMap())),
        "work_status": workStatus,
      };
}

class Date {
  DateTime? date;
  int? timezoneType;
  String? timezone;

  Date({
    this.date,
    this.timezoneType,
    this.timezone,
  });

  factory Date.fromMap(Map<String, dynamic> json) => Date(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        timezoneType: json["timezone_type"],
        timezone: json["timezone"],
      );

  Map<String, dynamic> toMap() => {
        "date": date?.toIso8601String(),
        "timezone_type": timezoneType,
        "timezone": timezone,
      };
}

class UserTagList {
  String? label;
  int? value;
  String? image;

  UserTagList({
    this.label,
    this.value,
    this.image,
  });

  factory UserTagList.fromMap(Map<String, dynamic> json) => UserTagList(
        label: json["label"],
        value: json["value"],
        image: json["image"],
      );

  Map<String, dynamic> toMap() => {
        "label": label,
        "value": value,
        "image": image,
      };
}
