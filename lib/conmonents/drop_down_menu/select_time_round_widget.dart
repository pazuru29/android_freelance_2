import 'package:android_freelance_2/conmonents/app_text.dart';
import 'package:android_freelance_2/conmonents/drop_down_menu/models/app_drop_down_button_model.dart';
import 'package:android_freelance_2/conmonents/drop_down_menu/widgets/drop_down_menu_button.dart';
import 'package:android_freelance_2/utils/app_colors.dart';
import 'package:android_freelance_2/utils/app_icons.dart';
import 'package:android_freelance_2/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class SelectTimeRoundWidget extends StatefulWidget {
  final String title;
  final AppDropDownButtonModel currentValue;
  final List<AppDropDownButtonModel> listOfValues;
  final double height;
  final Function(AppDropDownButtonModel?) onChangeValue;

  const SelectTimeRoundWidget({
    required this.title,
    required this.currentValue,
    required this.listOfValues,
    this.height = 115,
    required this.onChangeValue,
    super.key,
  });

  @override
  State<SelectTimeRoundWidget> createState() => _SelectTimeRoundWidgetState();
}

class _SelectTimeRoundWidgetState extends State<SelectTimeRoundWidget> {
  bool _isActive = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_isActive)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 28),
                padding: const EdgeInsets.only(top: 24, bottom: 8),
                height: widget.height,
                width: 166,
                decoration: const BoxDecoration(
                  color: AppColors.purple,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: widget.listOfValues.length,
                  itemBuilder: (context, index) {
                    if (widget.listOfValues[index].title !=
                        widget.currentValue.title) {
                      return Column(
                        children: [
                          DropDownMenuButton(
                            title: widget.listOfValues[index].title,
                            assetName: widget.listOfValues[index].assetName,
                            isSelectedItem: widget.listOfValues[index].title ==
                                widget.currentValue.title,
                            height: 44,
                            onPressed: widget.listOfValues[index].title ==
                                    widget.currentValue.title
                                ? () => setState(() {
                                      _isActive = false;
                                    })
                                : () {
                                    setState(() {
                                      widget.onChangeValue(
                                          widget.listOfValues[index]);
                                      _isActive = false;
                                    });
                                  },
                          ),
                          if (!(index == widget.listOfValues.length - 1 ||
                              (widget.currentValue.title ==
                                      widget.listOfValues.last.title &&
                                  (index == widget.listOfValues.length - 2))))
                            Container(
                              height: 2,
                              color: AppColors.linePurple,
                            ),
                        ],
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
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
            padding: const EdgeInsets.only(left: 25),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: AppColors.linePurple,
                width: 2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(text: widget.title, style: AppTextStyles.bold17),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  width: 164,
                  decoration: BoxDecoration(
                    color: AppColors.purple,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Gap(20),
                        Flexible(
                          child: FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppText(
                                  text: widget.currentValue.title,
                                  style: AppTextStyles.bold17,
                                ),
                              ],
                            ),
                          ),
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
            ),
          ),
        ),
      ],
    );
  }
}
