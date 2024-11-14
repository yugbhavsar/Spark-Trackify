import 'package:flutter/material.dart';

import '../../Utilities/CommanWidgets.dart';
import '../../Utilities/Constants.dart';
import '../../Utilities/ThemeColors.dart';


class SearchEmployeeScreen extends StatelessWidget {

  final TextEditingController _controller =  TextEditingController();
  final FocusNode _node = FocusNode();

  SearchEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(AppImages.backArrow , fit: BoxFit.fill, height: 30, width: 30,),
                  ),

                  const SizedBox(width: 20,),

                  Text("Search Employee" ,
                    style: appTextStyle(textColor: AppColors.darkColor , fontSize:  22 , style: FontStyle.semibold),
                  ),
                ],
              ),

              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: AppColors.lightBackground,
                        width: 3,
                        style: BorderStyle.solid
                    )
                ),
                child: CustomTextField(controller: _controller, focusNode: _node, placeholder: "Search Employee To Assign"),
              ),

            ],
          )
      ),
    );
  }
}
