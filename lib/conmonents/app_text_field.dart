import 'package:android_freelance_2/utils/app_colors.dart';
import 'package:android_freelance_2/utils/app_icons.dart';
import 'package:android_freelance_2/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final double? width;
  final double? height;
  final AppStyle style;
  final TextInputType textInputType;
  final int? maxLines;
  final TextAlign textAlign;
  final Function(String) onChanged;
  final int? lengthLimiting;
  final TextInputAction textInputAction;
  final Color textColor;
  final bool autoFocus;
  final String? hintText;
  final List<TextInputFormatter>? filteringTextInputFormatter;
  final bool needIcon;
  final VoidCallback? onTapOutside;

  const AppTextField({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    this.width,
    this.height,
    this.style = AppTextStyles.medium16,
    this.textInputType = TextInputType.text,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.lengthLimiting,
    this.textInputAction = TextInputAction.done,
    this.textColor = AppColors.white,
    this.autoFocus = false,
    this.hintText,
    this.filteringTextInputFormatter,
    this.needIcon = false,
    this.onTapOutside,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: AppColors.purple,
            width: 2,
          )),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              cursorColor: AppColors.white,
              cursorWidth: 2,
              cursorHeight: style.fontSize,
              textInputAction: textInputAction,
              autofocus: autoFocus,
              style: TextStyle(
                height: 1,
                fontSize: style.fontSize,
                fontWeight: style.fontWeight,
                color: AppColors.white,
              ),
              keyboardType: textInputType,
              maxLines: maxLines,
              textAlign: textAlign,
              onChanged: (text) {
                onChanged(text);
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(lengthLimiting),
                if (filteringTextInputFormatter != null)
                  ...filteringTextInputFormatter!,
              ],
              decoration: InputDecoration(
                hintText: hintText,
                hintMaxLines: 1,
                hintStyle: TextStyle(
                  fontSize: style.fontSize,
                  fontWeight: style.fontWeight,
                  color: AppColors.purple,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              ),
              onTapOutside: (_) {
                focusNode.unfocus();
                if (onTapOutside != null) {
                  onTapOutside!();
                }
              },
            ),
          ),
          if (controller.text.isNotEmpty && needIcon)
            SvgPicture.asset(AppIcons.icApprove),
          if (controller.text.isNotEmpty && needIcon) const Gap(15),
        ],
      ),
    );
  }
}
