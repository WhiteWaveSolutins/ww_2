import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ww_2/data/models/qr_code/data_qr_code.dart';
import 'package:ww_2/data/services/shared_preferences_service.dart';
import 'package:ww_2/domain/di/get_it_services.dart';
import 'package:ww_2/domain/enums/type_generate.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:ww_2/ui/screens/generate/widgets/phone_generate.dart';
import 'package:ww_2/ui/screens/generate/widgets/safaty_select.dart';
import 'package:ww_2/ui/screens/generate/widgets/test_description_generate.dart';
import 'package:ww_2/ui/state_manager/store.dart';
import 'package:ww_2/ui/widgets/buttons/left_button.dart';
import 'package:ww_2/ui/widgets/buttons/main_button.dart';

class GenerateDescriptionScreen extends StatefulWidget {
  final TypeGenerate type;

  const GenerateDescriptionScreen({
    super.key,
    required this.type,
  });

  @override
  State<GenerateDescriptionScreen> createState() => _GenerateDescriptionScreenState();
}

class _GenerateDescriptionScreenState extends State<GenerateDescriptionScreen>
    with SingleTickerProviderStateMixin {
  final textController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  bool checkText = false;
  bool checkName = false;
  late TabController controller;
  final phoneButtonController = StreamController();

  @override
  void initState() {
    super.initState();
    phoneButtonController.sink.add(false);

    controller = TabController(length: 3, vsync: this);

    if ([
      TypeGenerate.text,
      TypeGenerate.website,
      TypeGenerate.phone,
    ].contains(widget.type)) {
      checkName = true;
    }

    if ([
      TypeGenerate.wifi,
      TypeGenerate.phone,
    ].contains(widget.type)) {
      checkText = true;
    }

    textController.addListener(() {
      if (checkText && textController.text.isEmpty) {
        checkText = false;
        setState(() {});
      } else if (widget.type == TypeGenerate.website) {
        final status = Uri.tryParse(textController.text)?.hasAbsolutePath ?? false;
        if (status && !checkText) {
          checkText = true;
          setState(() {});
        } else if (!status && checkText) {
          checkText = false;
          setState(() {});
        }
      } else if (!checkText && textController.text.isNotEmpty) {
        checkText = true;
        setState(() {});
      }
    });

    nameController.addListener(() {
      if (checkName && nameController.text.isEmpty) {
        checkName = false;
        setState(() {});
      } else if (!checkName && nameController.text.isNotEmpty) {
        checkName = true;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    phoneButtonController.close();
    super.dispose();
  }

  void generate() async {
    final count = await SharedPreferencesService.getCountGeneration();
    final store = StoreProvider.of<AppState>(context, listen: false);
    if (count >= 3 && !store.state.subscriptionState.hasPremium) {
      showDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: const Text("Attention!"),
          content: const Text('You are out of generation'),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
                getItService.navigatorService.onGetPremium();
              },
              isDefaultAction: true,
              child: const Text(
                "Get Premium",
                style: TextStyle(color: Colors.black),
              ),
            ),
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
      final data = DataQrCode(
        type: widget.type,
        phone: phoneController.text,
        name: nameController.text,
        safety: controller.index,
        text: textController.text,
        password: passwordController.text,
      );
      getItService.navigatorService.onGenerateResult(data: data);
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
      bottomSheet: StreamBuilder(
        stream: phoneButtonController.stream,
        builder: (context, data) {
          return Container(
            color: AppColors.black,
            padding: const EdgeInsets.only(
              bottom: 20,
              right: 16,
              left: 16,
            ),
            child: MainButton(
              title: 'Create',
              onPressed:
                  (widget.type == TypeGenerate.phone ? data.data == true : (checkName && checkText))
                      ? generate
                      : null,
            ),
          );
        },
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (TypeGenerate.phone == widget.type) ...[
            PhoneGenerate(
              controller: phoneController,
              changeActive: (s) => phoneButtonController.sink.add(s),
            ),
          ],
          if ([TypeGenerate.sms, TypeGenerate.email, TypeGenerate.wifi].contains(widget.type)) ...[
            Text(
              TypeGenerate.wifi == widget.type
                  ? 'Network name (SSID)'
                  : TypeGenerate.sms == widget.type
                      ? 'Recipient'
                      : 'Email',
              style: AppText.text3,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: nameController,
              style: AppText.text2.copyWith(
                color: AppColors.white,
              ),
              decoration: InputDecoration(
                hintText: 'Enter ${TypeGenerate.email != widget.type ? 'name' : 'email'}',
              ),
            ),
            const SizedBox(height: 16),
          ],
          if (![TypeGenerate.wifi, TypeGenerate.phone].contains(widget.type)) ...[
            Text(
              widget.type == TypeGenerate.website
                  ? 'Website'
                  : widget.type == TypeGenerate.sms
                      ? 'SMS'
                      : 'Text',
              style: AppText.text3,
            ),
            const SizedBox(height: 8),
            TestDescriptionGenerate(
              type: widget.type,
              controller: textController,
            ),
            const SizedBox(height: 16),
            if (widget.type == TypeGenerate.text)
              Opacity(
                opacity: .5,
                child: Text(
                  'QR Code will be difficult to recognize if the content exceeds 150 characters',
                  style: AppText.text3,
                ),
              ),
          ],
          if (TypeGenerate.wifi == widget.type) ...[
            const SizedBox(height: 16),
            Text(
              'Safety',
              style: AppText.text3,
            ),
            const SizedBox(height: 8),
            SafetySelect(controller: controller),
            const SizedBox(height: 32),
            Text(
              'Password',
              style: AppText.text3,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: passwordController,
              style: AppText.text2.copyWith(
                color: AppColors.white,
              ),
              decoration: const InputDecoration(
                hintText: 'Enter password',
              ),
            ),
          ],
        ],
      ),
    );
  }
}
