import 'package:android_freelance_2/conmonents/app_text.dart';
import 'package:android_freelance_2/conmonents/drop_down_menu/models/app_drop_down_button_model.dart';
import 'package:android_freelance_2/conmonents/drop_down_menu/widgets/drop_down_menu_button.dart';
import 'package:android_freelance_2/utils/app_colors.dart';
import 'package:android_freelance_2/utils/app_icons.dart';
import 'package:android_freelance_2/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class SelectedTypeGameWidget extends StatefulWidget {
  final AppDropDownButtonModel? currentValue;
  final List<AppDropDownButtonModel> listOfValues;
  final Function(AppDropDownButtonModel?) onChangeValue;

  const SelectedTypeGameWidget({
    required this.currentValue,
    required this.listOfValues,
    required this.onChangeValue,
    super.key,
  });

  @override
  State<SelectedTypeGameWidget> createState() => _SelectedTypeGameWidgetState();
}

class _SelectedTypeGameWidgetState extends State<SelectedTypeGameWidget> {
  bool _isActive = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_isActive)
          Container(
            margin: const EdgeInsets.only(top: 28),
            padding: const EdgeInsets.only(top: 28),
            height: 222,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: AppColors.backgroundActivity,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(26),
                bottomRight: Radius.circular(26),
              ),
            ),
            child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: widget.listOfValues.length,
              itemBuilder: (context, index) => Column(
                children: [
                  DropDownMenuButton(
                    title: widget.listOfValues[index].title,
                    assetName: widget.listOfValues[index].assetName,
                    isSelectedItem: widget.listOfValues[index].title ==
                        widget.currentValue?.title,
                    onPressed: widget.listOfValues[index].title ==
                            widget.currentValue?.title
                        ? () => setState(() {
                              _isActive = false;
                            })
                        : () {
                            setState(() {
                              widget.onChangeValue(widget.listOfValues[index]);
                              _isActive = false;
                            });
                          },
                  ),
                  if (index != widget.listOfValues.length - 1)
                    Container(
                      height: 1,
                      color: AppColors.purple,
                    ),
                ],
              ),
            ),
          ),
        GestureDetector(
          onTap: () {
            setState(() {
              _isActive = !_isActive;
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 55,
            padding: const EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
              color: AppColors.backgroundActivity,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: AppColors.purple,
                width: 2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.currentValue != null)
                  Row(
                    children: [
                      SvgPicture.asset(widget.currentValue!.assetName!),
                      const Gap(8),
                      AppText(
                        text: widget.currentValue!.title,
                        style: AppTextStyles.bold17,
                      ),
                    ],
                  ),
                if (widget.currentValue == null)
                  const AppText(
                    text: 'Game type',
                    style: AppTextStyles.bold17,
                  ),
                RotatedBox(
                  quarterTurns: _isActive ? 45 : 135,
                  child: SvgPicture.asset(
                    AppIcons.icBack,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
