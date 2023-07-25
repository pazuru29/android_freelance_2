import 'package:android_freelance_2/conmonents/app_button.dart';
import 'package:android_freelance_2/conmonents/app_radio_button.dart';
import 'package:android_freelance_2/conmonents/app_text.dart';
import 'package:android_freelance_2/conmonents/app_text_field.dart';
import 'package:android_freelance_2/conmonents/base_screen.dart';
import 'package:android_freelance_2/conmonents/drop_down_menu/models/app_drop_down_button_model.dart';
import 'package:android_freelance_2/conmonents/drop_down_menu/select_time_round_widget.dart';
import 'package:android_freelance_2/conmonents/secondary_app_bar.dart';
import 'package:android_freelance_2/conmonents/drop_down_menu/selected_type_game_widget.dart';
import 'package:android_freelance_2/controllers/create_new_game_controller/create_new_game_controller.dart';
import 'package:android_freelance_2/data/database/models/match_model.dart';
import 'package:android_freelance_2/utils/app_colors.dart';
import 'package:android_freelance_2/utils/app_strings.dart';
import 'package:android_freelance_2/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:measure_size/measure_size.dart';

class EditScreen extends BaseScreen {
  final MatchModel matchModel;
  final List<int> roundTime;

  const EditScreen({
    required this.matchModel,
    required this.roundTime,
    super.key,
  });

  @override
  State<EditScreen> createState() => _CreateNewGameScreenState();
}

class _CreateNewGameScreenState extends BaseScreenState<EditScreen> {
  late final CreateNewGameController _createNewGameController;

  final ScrollController _controller = ScrollController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nameTeam1Controller = TextEditingController();
  final TextEditingController _nameTeam2Controller = TextEditingController();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _nameTeam1FocusNode = FocusNode();
  final FocusNode _nameTeam2FocusNode = FocusNode();

  double _heightBody = 0;

  bool isButtonActive = false;

  int _selectedTime = 0;

  @override
  void initState() {
    _createNewGameController = Get.put(CreateNewGameController());
    _createNewGameController.setInitEditData(
        widget.matchModel, widget.roundTime);
    _nameController.text = widget.matchModel.name ?? '';
    _nameTeam1Controller.text = widget.matchModel.nameTeam1;
    _nameTeam2Controller.text = widget.matchModel.nameTeam2;
    isButtonActive = true;
    super.initState();
  }

  @override
  Widget buildMain(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Column(
          children: [
            SecondaryAppBar(
              title: AppStrings.editMatch,
              titleBack: AppStrings.btnBack,
              child: AppButton(
                title: AppStrings.btnDone,
                height: 31,
                borderRadius: BorderRadius.circular(10),
                onPressed: !isButtonActive
                    ? null
                    : () {
                        _createNewGameController.editMatch(
                          context,
                          widget.matchModel,
                          _nameController.text.isEmpty
                              ? null
                              : _nameController.text,
                          _nameTeam1Controller.text,
                          _nameTeam2Controller.text,
                        );
                      },
              ),
            ),
            Flexible(
              child: CustomScrollView(
                controller: _controller,
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Stack(
                        children: [
                          MeasureSize(
                            onChange: (size) {
                              setState(() {
                                _heightBody = size.height;
                              });
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Gap(80),
                                const Gap(15),
                                AppTextField(
                                  controller: _nameController,
                                  focusNode: _nameFocusNode,
                                  height: 55,
                                  hintText: AppStrings.hintName,
                                  onChanged: (text) {},
                                ),
                                const Gap(25),
                                _teamName(),
                                const Gap(20),
                                _rules(),
                                const Gap(20),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: SelectedTypeGameWidget(
                              currentValue:
                                  _createNewGameController.currentGameType,
                              listOfValues:
                                  _createNewGameController.listOfTypeGame,
                              onChangeValue: (value) {
                                _createNewGameController
                                    .changeCurrentGameType(value);
                                checkOnButtonActive();
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: _heightBody),
                            child: const AppText(
                              text: AppStrings.timeRound,
                              style: AppTextStyles.bold21,
                            ),
                          ),
                          if (_createNewGameController.rulesType == 0 &&
                              _createNewGameController.countOfRounds < 4)
                            Padding(
                              padding: EdgeInsets.only(
                                  top: _heightBody +
                                      48 +
                                      (_createNewGameController.countOfRounds *
                                          65)),
                              child: AppButton.outlined(
                                title: AppStrings.addRound,
                                onPressed: () {
                                  setState(() {
                                    _createNewGameController
                                        .changeCountOfRounds();
                                  });
                                },
                              ),
                            ),
                          if (_createNewGameController.rulesType == 0 &&
                              _createNewGameController.countOfRounds > 3)
                            Padding(
                              padding: EdgeInsets.only(top: _heightBody + 243),
                              child: _timeWidget(
                                AppStrings.round4,
                                _createNewGameController.currentForthRoundType,
                                (value) => _createNewGameController
                                    .changeCurrentForthRoundType(value),
                                4,
                              ),
                            ),
                          if (_createNewGameController.rulesType == 0 &&
                              _createNewGameController.countOfRounds > 2)
                            Padding(
                              padding: EdgeInsets.only(top: _heightBody + 178),
                              child: _timeWidget(
                                AppStrings.round3,
                                _createNewGameController.currentThirdRoundType,
                                (value) => _createNewGameController
                                    .changeCurrentThirdRoundType(value),
                                3,
                              ),
                            ),
                          if (_createNewGameController.rulesType == 0 &&
                              _createNewGameController.countOfRounds > 1)
                            Padding(
                              padding: EdgeInsets.only(top: _heightBody + 113),
                              child: _timeWidget(
                                AppStrings.round2,
                                _createNewGameController.currentSecondRoundType,
                                (value) => _createNewGameController
                                    .changeCurrentSecondRoundType(value),
                                2,
                              ),
                            ),
                          if (_createNewGameController.rulesType == 0)
                            Padding(
                              padding: EdgeInsets.only(top: _heightBody + 48),
                              child: _timeWidget(
                                AppStrings.round1,
                                _createNewGameController.currentFirstRoundType,
                                (value) => _createNewGameController
                                    .changeCurrentFirstRoundType(value),
                                1,
                              ),
                            ),
                          if (_createNewGameController.rulesType == 1)
                            Padding(
                              padding: EdgeInsets.only(top: _heightBody + 48),
                              child: _roundWidget(),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _teamName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          text: AppStrings.whoPlays,
          style: AppTextStyles.bold21,
        ),
        const Gap(15),
        _teamNameTextField(_nameTeam1Controller, _nameTeam1FocusNode, 1),
        const Gap(10),
        _teamNameTextField(_nameTeam2Controller, _nameTeam2FocusNode, 2),
      ],
    );
  }

  Widget _teamNameTextField(
    TextEditingController controller,
    FocusNode focusNode,
    int teamNumber,
  ) {
    return Row(
      children: [
        Container(
          height: 55,
          width: 38,
          decoration: BoxDecoration(
            color: AppColors.purple,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: AppText(
              text: '$teamNumber',
              style: AppTextStyles.regular30,
            ),
          ),
        ),
        const Gap(12),
        Flexible(
          child: AppTextField(
            controller: controller,
            focusNode: focusNode,
            height: 55,
            hintText: AppStrings.teamNamePlayer,
            needIcon: true,
            onChanged: (text) {
              checkOnButtonActive();
            },
          ),
        ),
      ],
    );
  }

  Widget _rules() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          text: AppStrings.rules,
          style: AppTextStyles.bold21,
        ),
        const Gap(18),
        AppRadioButton(
          title: AppStrings.maxScorePerTime,
          value: 0,
          groupValue: _createNewGameController.rulesType,
          onPressed: (value) {
            _createNewGameController.changeRulesType(value);
          },
        ),
        const Gap(15),
        AppRadioButton(
          title: AppStrings.maxScore,
          value: 1,
          groupValue: _createNewGameController.rulesType,
          onPressed: (value) {
            _createNewGameController.changeRulesType(value);
          },
        ),
      ],
    );
  }

  Widget _timeWidget(String title, AppDropDownButtonModel currentValue,
      Function(AppDropDownButtonModel) onChangeValue, int numberOfTime) {
    return SelectTimeRoundWidget(
      title: title,
      currentValue: currentValue,
      isActive: _selectedTime == numberOfTime,
      onPressed: () {
        setState(() {
          if (_selectedTime == numberOfTime) {
            _selectedTime = 0;
          } else {
            _selectedTime = numberOfTime;
            _scrollDown();
          }
        });
      },
      listOfValues: _createNewGameController.listOfTime,
      onChangeValue: (value) {
        if (value != null) {
          onChangeValue(value);
        }
        setState(() {
          _selectedTime = 0;
        });
      },
    );
  }

  Widget _roundWidget() {
    return SelectTimeRoundWidget(
      title: AppStrings.maxScore,
      height: 150,
      isActive: _selectedTime == 5,
      currentValue: _createNewGameController.currentScoreType,
      listOfValues: _createNewGameController.listOfScore,
      onChangeValue: (value) {
        if (value != null) {
          _createNewGameController.changeCurrentScoreType(value);
        }
        setState(() {
          _selectedTime = 0;
        });
      },
      onPressed: () {
        setState(() {
          if (_selectedTime == 5) {
            _selectedTime = 0;
          } else {
            _selectedTime = 5;
            _scrollDown();
          }
        });
      },
    );
  }

  void checkOnButtonActive() {
    setState(() {
      isButtonActive = _nameTeam1Controller.text.isNotEmpty &&
          _nameTeam2Controller.text.isNotEmpty &&
          _createNewGameController.currentGameType != null;
    });
  }

  void _scrollDown() {
    Future.delayed(const Duration(milliseconds: 50), () {
      _controller.jumpTo(_controller.position.maxScrollExtent);
    });
  }

  @override
  bool needScroll() {
    return false;
  }
}
