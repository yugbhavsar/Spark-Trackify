import 'package:flutter/material.dart';
import 'package:spark_trackify/app/core/extensions/extensions.dart';
import 'package:spark_trackify/app/data/utils/app_utils.dart';
import 'package:spark_trackify/app/features/home_screen/models/deviceDataModel.dart';
import 'package:spark_trackify/app/widgets/base_imageview.dart';

import '../../../gen/assets.gen.dart';
import '../../core/common/ThemeColors.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<CurrentActiveUser>? historyData;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      Map? args = ModalRoute.settingsOf(context)?.arguments as Map?;
      if (args != null) {
        historyData = args["historyData"];
        historyData = historyData?.reversed.toList();
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Assets.images.backArrow.image(width: 32, height: 32),
              )),
          backgroundColor: Colors.white,
          title: Text("Device History", style: appTextStyle(textColor: AppColors.darkColor, fontSize: 24, style: FontStyle.semibold)),
        ),
        body: (historyData?.isEmpty ?? false)
            ? Center(
                child: Text(
                  "No device history found!",
                  style: appTextStyle(textColor: AppColors.darkColor, fontSize: 24, style: FontStyle.semibold),
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  return HistoryDeviceCard(currentActiveUser: historyData?[index]);
                },
                itemCount: historyData?.length ?? 0,
              ));
  }
}

class HistoryDeviceCard extends StatelessWidget {
  final CurrentActiveUser? currentActiveUser;

  const HistoryDeviceCard({
    super.key,
    required this.currentActiveUser,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.lightBackground,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: BaseImageView(
                  imageUrl: currentActiveUser?.empImage ?? "",
                  nameLetters: "${currentActiveUser?.firstName ?? ""} ${currentActiveUser?.lastName ?? ""}".getFirstTwoWordInitials()),
            ),
            SizedBox(width: 8),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${currentActiveUser?.firstName ?? ""} ${currentActiveUser?.lastName ?? ""}",
                  style: appTextStyle(textColor: AppColors.darkColor, fontSize: 20, style: FontStyle.semibold),
                ),
                SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Assign For",
                            style: appTextStyle(textColor: Colors.grey.withOpacity(.8), fontSize: 14, style: FontStyle.medium),
                          ),
                          Text(
                            currentActiveUser?.assignFor?.name ?? "-",
                            style: appTextStyle(textColor: AppColors.darkColor, fontSize: 14, style: FontStyle.medium),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Time",
                            style: appTextStyle(textColor: Colors.grey.withOpacity(.8), fontSize: 14, style: FontStyle.medium),
                          ),
                          Text(
                            "${getFormattedDateTime(currentActiveUser?.createdAt ?? "")} -\n${getFormattedDateTime(currentActiveUser?.deletedAt ?? "")}",
                            style: appTextStyle(textColor: AppColors.darkColor, fontSize: 12, style: FontStyle.medium),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
