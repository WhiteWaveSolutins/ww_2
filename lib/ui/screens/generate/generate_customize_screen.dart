import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ww_2/data/models/config_customize.dart';
import 'package:ww_2/data/models/qr_code/qr_code.dart';
import 'package:ww_2/data/services/shared_preferences_service.dart';
import 'package:ww_2/domain/di/get_it_services.dart';
import 'package:ww_2/domain/enums/customiza_frame.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/icons.dart';
import 'package:ww_2/ui/state_manager/qr_code/action.dart';
import 'package:ww_2/ui/state_manager/store.dart';
import 'package:ww_2/ui/widgets/buttons/left_button.dart';
import 'package:ww_2/ui/widgets/buttons/main_button.dart';
import 'package:ww_2/ui/widgets/buttons/simple_button.dart';
import 'package:ww_2/ui/widgets/modals/picker_body_modal.dart';
import 'package:ww_2/ui/widgets/modals/picker_colors_modal.dart';
import 'package:ww_2/ui/widgets/modals/picker_eyes_modal.dart';
import 'package:ww_2/ui/widgets/modals/picker_frame_modal.dart';
import 'package:ww_2/ui/widgets/svg_icon.dart';

class GenerateCustomizeScreen extends StatefulWidget {
  final QrCodeGenerate qr;

  const GenerateCustomizeScreen({
    super.key,
    required this.qr,
  });

  @override
  State<GenerateCustomizeScreen> createState() => _GenerateCustomizeScreenState();
}

class _GenerateCustomizeScreenState extends State<GenerateCustomizeScreen> {
  final config = ConfigCustomize();
  late CustomizeFrame? frame;
  late Store<AppState> _store;

  @override
  void initState() {
    super.initState();
    _store = StoreProvider.of<AppState>(context, listen: false);
    frame = null;
  }

  void save() async {
    final count = await SharedPreferencesService.getCountGeneration();
    if (count >= 3) {
      showDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: const Text("Attention!"),
          content: const Text('You are out of generation'),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: Navigator.of(context).pop,
              isDefaultAction: true,
              child: const Text(
                "Ok",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      );
    } else {
      final c = frameToConfig(frame) ?? config;
      _store.dispatch(LoadQrCodeGenerateAction(data: widget.qr.data, config: c));
      getItService.navigatorService.onPop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customize'),
        centerTitle: true,
        leading: const LeftButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SimpleButton(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  constraints: BoxConstraints(
                    minHeight: 100,
                    maxHeight: MediaQuery.of(context).size.height - 50,
                  ),
                  backgroundColor: Colors.transparent,
                  builder: (_) => PickerColorsModal(
                    selectedColor: config.color,
                    selectedBackColor: config.back,
                    pickColors: (c, b) {
                      setState(() {
                        config.color = c;
                        config.back = b;
                      });
                    },
                  ),
                );
              },
              title: 'Color',
              iconWidget: const _Icon(
                colors: [
                  AppColors.yellowGrad1,
                  AppColors.yellowGrad2,
                ],
                icon: AppIcons.colorSmall,
              ),
            ),
            const SizedBox(height: 16),
            SimpleButton(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  constraints: BoxConstraints(
                    minHeight: 100,
                    maxHeight: MediaQuery.of(context).size.height - 50,
                  ),
                  backgroundColor: Colors.transparent,
                  builder: (_) => PickerFrameModal(
                    selectedFrame: frame,
                    pickFrame: (f) => setState(() => frame = f),
                  ),
                );
              },
              title: 'Pattern',
              iconWidget: const _Icon(
                colors: [
                  Color(0xFFCE7EFF),
                  Color(0xFFA033FF),
                ],
                icon: AppIcons.frame,
              ),
            ),
            const SizedBox(height: 16),
            SimpleButton(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  constraints: BoxConstraints(
                    minHeight: 100,
                    maxHeight: MediaQuery.of(context).size.height - 50,
                  ),
                  backgroundColor: Colors.transparent,
                  builder: (_) => PickerEyeModal(
                    selectedEye: config.eye,
                    selectedEyeBall: config.eyeBall,
                    pickEye: (e, b) {
                      setState(() {
                        config.eye = e;
                        config.eyeBall = b;
                      });
                    },
                  ),
                );
              },
              title: 'Code eyes',
              iconWidget: const _Icon(
                colors: [
                  Color(0xFFFFB052),
                  Color(0xFFFF6F31),
                ],
                icon: AppIcons.eyes,
              ),
            ),
            const SizedBox(height: 16),
            SimpleButton(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  constraints: BoxConstraints(
                    minHeight: 100,
                    maxHeight: MediaQuery.of(context).size.height - 50,
                  ),
                  backgroundColor: Colors.transparent,
                  builder: (_) => PickerBodyModal(
                    selectedBody: config.body,
                    pickBody: (c) => setState(() => config.body = c),
                  ),
                );
              },
              title: 'Points',
              iconWidget: const _Icon(
                colors: [
                  Color(0xFFFF8097),
                  Color(0xFFFE022F),
                ],
                icon: AppIcons.stars,
              ),
            ),
            const Spacer(),
            MainButton(
              title: 'Save',
              onPressed: save,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _Icon extends StatelessWidget {
  final List<Color> colors;
  final String icon;

  const _Icon({
    super.key,
    required this.icon,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        gradient: LinearGradient(
          colors: colors,
        ),
      ),
      child: SvgIcon(
        icon: icon,
        size: 19,
      ),
    );
  }
}
