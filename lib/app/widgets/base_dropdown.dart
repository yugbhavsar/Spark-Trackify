import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:spark_trackify/app/core/common/ThemeColors.dart';

import '../../gen/assets.gen.dart';
import 'base_svg.dart';

class BaseDropdown<T> extends StatelessWidget {
  final List<T?> items;
  final void Function(T?)? onChanged;
  final String Function(T?) valueAsString;
  final T? selectedValue;
  final String? textLabel;
  final bool isRequired;

  const BaseDropdown(
      {super.key,
      this.onChanged,
      required this.valueAsString,
      this.selectedValue,
      this.textLabel,
      this.isRequired = false,
      required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        if (textLabel != null) ...[
          (isRequired)
              ? Row(
                  children: [
                    Text(textLabel ?? "", style: appTextStyle(textColor: Colors.black, fontSize: 14, style: FontStyle.medium)),
                    SizedBox(width: 3),
                    Text("*", style: appTextStyle(textColor: Colors.red, fontSize: 14, style: FontStyle.medium))
                  ],
                )
              : Text(textLabel!, style: appTextStyle(textColor: Colors.black54, fontSize: 14, style: FontStyle.medium)),
          SizedBox(height: 8),
        ],
        DropdownButtonHideUnderline(
          child: DropdownButton2<T>(
            isExpanded: true,
            selectedItemBuilder: (context) {
              return items
                  .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        valueAsString(item),
                        style: appTextStyle(textColor: Theme.of(context).hintColor, fontSize: 16, style: FontStyle.medium),
                      )))
                  .toList();
            },
            hint: Text(
              'Select...',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: items
                .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      valueAsString(item),
                      style: appTextStyle(
                          textColor: selectedValue == item ? Colors.white : Colors.black54, fontSize: 16, style: FontStyle.medium),
                    )))
                .toList(),
            value: selectedValue,
            style: appTextStyle(textColor: Colors.black54, fontSize: 16, style: FontStyle.medium),
            onChanged: onChanged,
            buttonStyleData: ButtonStyleData(
              // height: 40,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.lightBackground, width: 3, style: BorderStyle.solid),
                // borderRadius: BorderRadius.circular(12),
                // border: Border(
                //     bottom: BorderSide(color: Colors.black12.withOpacity(0.03)),
                //     right: BorderSide(
                //       color: Colors.black12.withOpacity(0.03),
                //     )),
                // boxShadow: [
                //   BoxShadow(color: Colors.black12.withOpacity(0.09)),
                //   const BoxShadow(
                //     color: Colors.white,
                //     spreadRadius: -1,
                //     blurRadius: 3,
                //     offset: Offset(2, 2),
                //   ),
              ),
            ),
            iconStyleData: IconStyleData(
                icon: BaseSvg(
              iconName: Assets.images.caretDownBold.path,
              iconColor: Colors.black54,
            )),
            dropdownStyleData: DropdownStyleData(
                maxHeight: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                )),
            menuItemStyleData: MenuItemStyleData(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              selectedMenuItemBuilder: (context, child) {
                return Container(
                  color: AppColors.primaryGreen,
                  child: child,
                );
              },
            ),
          ),
        ),
        SizedBox(height: 10)
      ],
    );
  }
}
