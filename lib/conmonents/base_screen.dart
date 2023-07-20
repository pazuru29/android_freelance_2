import 'package:android_freelance_2/utils/app_colors.dart';
import 'package:android_freelance_2/utils/app_gradients.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => BaseScreenState();
}

class BaseScreenState<T extends BaseScreen> extends State<T> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: AppGradients.backgroundGradient,
        ),
        child: needScroll()
            ? CustomScrollView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: buildMain(context),
                  ),
                ],
              )
            : buildMain(context),
      ),
    );
  }

  Widget buildMain(BuildContext context) {
    return const Placeholder();
  }

  bool needScroll() {
    return true;
  }
}
