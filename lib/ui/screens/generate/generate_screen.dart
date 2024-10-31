import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ww_2/data/services/shared_preferences_service.dart';
import 'package:ww_2/domain/di/get_it_services.dart';
import 'package:ww_2/domain/enums/type_generate.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:ww_2/ui/state_manager/store.dart';
import 'package:ww_2/ui/widgets/buttons/left_button.dart';
import 'package:ww_2/ui/widgets/gradient_widget.dart';
import 'package:ww_2/ui/widgets/svg_icon.dart';

class GenerateScreen extends StatefulWidget {
  const GenerateScreen({super.key});

  @override
  State<GenerateScreen> createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> {
  @override
  void initState() {
    super.initState();
    showDialogCount();
  }

  void showDialogCount() async {
    final status = await SharedPreferencesService.getStatusShowCount();
    final store = StoreProvider.of<AppState>(context, listen: false);
    if (!status && !store.state.subscriptionState.hasPremium) {
      SharedPreferencesService.switchStatusShowCount();
      showDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: const Text('Attention!'),
          content: const Text('You only have 3 generations for each day'),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GENERATE'),
        centerTitle: true,
        leading: const LeftButton(),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                Expanded(child: _Block(type: TypeGenerate.text)),
                SizedBox(width: 8),
                Expanded(child: _Block(type: TypeGenerate.sms)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _Block(type: TypeGenerate.email)),
                SizedBox(width: 8),
                Expanded(child: _Block(type: TypeGenerate.website)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _Block(type: TypeGenerate.wifi)),
                SizedBox(width: 8),
                Expanded(child: _Block(type: TypeGenerate.phone)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _Block(type: TypeGenerate.payment)),
                SizedBox(width: 8),
                Expanded(child: _Block(type: TypeGenerate.event)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Block extends StatelessWidget {
  final TypeGenerate type;

  const _Block({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 1,
      onPressed: () {
        if (type == TypeGenerate.event) {
          getItService.navigatorService.onGenerateDescriptionEvent();
          return;
        }
        if (type == TypeGenerate.payment) {
          getItService.navigatorService.onGenerateDescriptionPayment();
          return;
        }
        getItService.navigatorService.onGenerateDescription(type: type);
      },
      child: Container(
        height: 137,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(.2),
          borderRadius: BorderRadius.circular(20),
          border: const Border(
            bottom: BorderSide(
              color: AppColors.primary,
              width: 2,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GradientWidget.primary(
              type != TypeGenerate.phone
                  ? SvgIcon(
                      icon: typeGenerateToIcon(type),
                      size: [TypeGenerate.text, TypeGenerate.sms].contains(type) ? 60 : 70,
                    )
                  : Image.asset(
                      typeGenerateToIcon(type),
                      width: 70,
                      height: 70,
                    ),
            ),
            const SizedBox(height: 24),
            Text(
              typeGenerateToString(type),
              style: AppText.text3,
            ),
          ],
        ),
      ),
    );
  }
}
