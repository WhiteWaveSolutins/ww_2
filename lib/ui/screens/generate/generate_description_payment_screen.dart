import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ww_2/data/models/qr_code/data_qr_code.dart';
import 'package:ww_2/data/services/shared_preferences_service.dart';
import 'package:ww_2/domain/di/get_it_services.dart';
import 'package:ww_2/domain/enums/type_generate.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:ww_2/ui/state_manager/store.dart';
import 'package:ww_2/ui/widgets/buttons/left_button.dart';
import 'package:ww_2/ui/widgets/buttons/main_button.dart';

class GenerateDescriptionPaymentScreen extends StatefulWidget {
  const GenerateDescriptionPaymentScreen({super.key});

  @override
  State<GenerateDescriptionPaymentScreen> createState() => _GenerateDescriptionPaymentScreenState();
}

class _GenerateDescriptionPaymentScreenState extends State<GenerateDescriptionPaymentScreen> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final cardController = TextEditingController();
  bool checkName = false;
  bool checkPrice = false;
  bool checkCard = false;

  @override
  void initState() {
    super.initState();
    nameController.addListener(() {
      if (checkName && nameController.text.isEmpty) {
        checkName = false;
        setState(() {});
      } else if (!checkName && nameController.text.isNotEmpty) {
        checkName = true;
        setState(() {});
      }
    });

    priceController.addListener(() {
      if (checkPrice && priceController.text.isEmpty) {
        checkPrice = false;
        setState(() {});
      } else if (!checkPrice && priceController.text.isNotEmpty) {
        checkPrice = true;
        setState(() {});
      }
    });

    cardController.addListener(() {
      if (checkCard && cardController.text.length < 16) {
        checkCard = false;
        setState(() {});
      } else if (!checkCard && cardController.text.length == 16) {
        checkCard = true;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    cardController.dispose();
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
        type: TypeGenerate.payment,
        name: nameController.text,
        price: priceController.text,
        card: cardController.text,
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
      bottomSheet: Container(
        color: AppColors.black,
        padding: const EdgeInsets.only(
          bottom: 20,
          right: 16,
          left: 16,
        ),
        child: MainButton(
          title: 'Create',
          onPressed: (checkName && checkCard && checkPrice) ? generate : null,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Full Name',
            style: AppText.text3,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: nameController,
            style: AppText.text2.copyWith(
              color: AppColors.white,
            ),
            decoration: const InputDecoration(
              hintText: 'Enter name',
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Price',
            style: AppText.text3,
          ),
          const SizedBox(height: 8),
          TextField(
            keyboardType: TextInputType.number,
            controller: priceController,
            style: AppText.text2.copyWith(
              color: AppColors.white,
            ),
            decoration: InputDecoration(
              hintText: '000',
              prefix: Text(
                '\$ ',
                style: AppText.text2.copyWith(
                  color: AppColors.white.withOpacity(.5),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Card Number',
            style: AppText.text3,
          ),
          const SizedBox(height: 8),
          TextField(
            keyboardType: TextInputType.number,
            controller: cardController,
            style: AppText.text2.copyWith(
              color: AppColors.white,
            ),
            maxLength: 16,
            decoration: const InputDecoration(hintText: '0000000000000000'),
          ),
        ],
      ),
    );
  }
}
