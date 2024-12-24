import 'package:flutter/material.dart';
import 'package:spark_trackify/app/core/common/ThemeColors.dart';
import 'package:spark_trackify/app/widgets/base_textfield.dart';
import 'package:spark_trackify/gen/assets.gen.dart';

class AssignDetailScreen extends StatefulWidget {
  final bool isForAssign;

  AssignDetailScreen({
    super.key,
    this.isForAssign = false,
  });

  @override
  State<AssignDetailScreen> createState() => _AssignDetailScreenState();
}

class _AssignDetailScreenState extends State<AssignDetailScreen> {
  final String imageName = Assets.images.iphone11.path;

  final String deviceName = "iPhone 11";

  @override
  void initState() {
    super.initState();
    // context.read<AssignDetailsBloc>().add(FetchEmployeesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      Assets.images.backArrow.path,
                      fit: BoxFit.fill,
                      height: 30,
                      width: widget.isForAssign ? 0 : 30,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    deviceName,
                    style: appTextStyle(textColor: AppColors.darkColor, fontSize: 22, style: FontStyle.semibold),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: Image.asset(imageName, fit: BoxFit.fitHeight, height: 300),
              ),
              const SizedBox(
                height: 16,
              ),
              AssignDeviceCard(
                isForAssign: widget.isForAssign,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Notes : ",
                style: appTextStyle(textColor: Colors.black, fontSize: 18, style: FontStyle.medium),
              ),
              const SizedBox(
                height: 10,
              ),
              AddAssignNotesCard(isForAssign: widget.isForAssign),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class AddAssignNotesCard extends StatelessWidget {
  final bool isForAssign;

  final TextEditingController _controller = TextEditingController();

  AddAssignNotesCard({
    super.key,
    required this.isForAssign,
  });

  @override
  Widget build(BuildContext context) {
    if (isForAssign) {
      return Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.lightBackground, width: 3, style: BorderStyle.solid)),
            child: CustomTextField(controller: _controller, placeholder: "Add Notes"),
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), backgroundColor: AppColors.btnGreen),
              child: SizedBox(
                  height: 50,
                  child: Center(
                      child: Text(
                    "Assign",
                    style: appTextStyle(fontSize: 18, style: FontStyle.semibold, textColor: Colors.white),
                  )))),
        ],
      );
    } else {
      return Text(
          "this is my notes to add here in this format that all the text goes to more than one line or many line, i hope this content is full-fill my required text line",
          style: appTextStyle(fontSize: 18, style: FontStyle.semibold));
    }
  }
}

class AssignDeviceCard extends StatefulWidget {
  final bool isForAssign;
  final DeviceAssignFor assignFor;

  const AssignDeviceCard({super.key, required this.isForAssign, this.assignFor = DeviceAssignFor.unAssigned});

  @override
  State<AssignDeviceCard> createState() => _AssignDeviceCardState();
}

class _AssignDeviceCardState extends State<AssignDeviceCard> {
  List<String> employeeNames = ["Prathvik", "Mihir", "Amin", "Kamyab", "Raj", "Jay"];

  DeviceAssignFor assignFor = DeviceAssignFor.development;

  @override
  Widget build(BuildContext context) {
    if (widget.isForAssign) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Assign For : ",
            style: appTextStyle(textColor: Colors.black, fontSize: 18, style: FontStyle.medium),
          ),
          const SizedBox(
            height: 10,
          ),
          // BaseDropdown<EmployeeModel>(
          //   valueAsString: (value) => "${value?.firstname} ${value?.lastname}",
          //   items: state.employeeList,
          //   selectedValue: state.selectedEmployeeModel,
          //   onChanged: (value) {
          //     context.read<AssignDetailsBloc>().add(SelectedEmployeeEvent(selectedEmployeeModel: value));
          //   },
          // ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Assign For : ",
            style: appTextStyle(textColor: Colors.black, fontSize: 18, style: FontStyle.medium),
          ),
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading: Radio<DeviceAssignFor>(
              activeColor: AppColors.btnGreen,
              value: DeviceAssignFor.development,
              groupValue: assignFor,
              onChanged: (value) {
                setState(() {
                  assignFor = value ?? DeviceAssignFor.development;
                });
              },
            ),
            title: Text(
              "Development",
              style: appTextStyle(textColor: Colors.black, fontSize: 18, style: FontStyle.semibold),
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading: Radio<DeviceAssignFor>(
              activeColor: AppColors.btnGreen,
              value: DeviceAssignFor.testing,
              groupValue: assignFor,
              focusColor: AppColors.btnGreen,
              onChanged: (value) {
                setState(() {
                  assignFor = value ?? DeviceAssignFor.testing;
                });
              },
            ),
            title: Text(
              "Testing",
              style: appTextStyle(textColor: Colors.black, fontSize: 18, style: FontStyle.semibold),
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading: Radio<DeviceAssignFor>(
              activeColor: AppColors.btnGreen,
              value: DeviceAssignFor.unAssigned,
              groupValue: assignFor,
              focusColor: AppColors.btnGreen,
              onChanged: (value) {
                setState(() {
                  assignFor = value ?? DeviceAssignFor.unAssigned;
                });
              },
            ),
            title: Text(
              "Unassign",
              style: appTextStyle(textColor: Colors.black, fontSize: 18, style: FontStyle.semibold),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Assign For : ",
            style: appTextStyle(textColor: Colors.black, fontSize: 18, style: FontStyle.medium),
          ),
          const SizedBox(
            height: 10,
          ),
          // SingleDeviceTemplate(imageName: Assets.images.user.path, deviceName: "Yug Bhavsar"),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Assign For : ",
            style: appTextStyle(textColor: Colors.black, fontSize: 18, style: FontStyle.medium),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Image.asset(
              widget.assignFor == DeviceAssignFor.unAssigned ? Assets.images.free.path : Assets.images.occupied.path,
              fit: BoxFit.fill,
              height: 50,
              width: 50,
            ),
            title: Text(
              widget.assignFor.value,
              style: appTextStyle(textColor: Colors.black, fontSize: 18, style: FontStyle.semibold),
            ),
          )
        ],
      );
    }
  }
}

enum DeviceAssignFor { development, testing, unAssigned }

extension AssignForExtension on DeviceAssignFor {
  String get value {
    switch (this) {
      case DeviceAssignFor.development:
        return "Development";
      case DeviceAssignFor.testing:
        return "Testing";
      case DeviceAssignFor.unAssigned:
        return "Unassign";
    }
  }
}
