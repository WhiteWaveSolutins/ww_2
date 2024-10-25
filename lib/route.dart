import 'package:flutter/material.dart';
import 'package:ww_2/data/models/local_barcode/local_barcode.dart';
import 'package:ww_2/data/models/qr_code/data_qr_code.dart';
import 'package:ww_2/data/models/qr_code/qr_code.dart';
import 'package:ww_2/domain/enums/type_generate.dart';
import 'package:ww_2/ui/screens/code/local_code_screen.dart';
import 'package:ww_2/ui/screens/code/qr_code_screen.dart';
import 'package:ww_2/ui/screens/created_codes/created_screen.dart';
import 'package:ww_2/ui/screens/generate/generate_customize_screen.dart';
import 'package:ww_2/ui/screens/generate/generate_description_event_screen.dart';
import 'package:ww_2/ui/screens/generate/generate_description_payment_screen.dart';
import 'package:ww_2/ui/screens/generate/generate_description_screen.dart';
import 'package:ww_2/ui/screens/generate/generate_result_screen.dart';
import 'package:ww_2/ui/screens/generate/generate_screen.dart';
import 'package:ww_2/ui/screens/get_premium/get_premium_screen.dart';
import 'package:ww_2/ui/screens/history_codes/history_codes_screen.dart';
import 'package:ww_2/ui/screens/main/main_screen.dart';
import 'package:ww_2/ui/screens/save_code/save_code_screen.dart';
import 'package:ww_2/ui/screens/saved_codes/saved_codes_screen.dart';
import 'package:ww_2/ui/screens/scan/scan_screen.dart';
import 'package:ww_2/ui/screens/settings/settings_screen.dart';

class AppRoutes {
  static const main = '/main';
  static const savedCodes = '/saved-codes';
  static const historyCodes = '/history-codes';
  static const localCode = '/local-code';
  static const qrCode = '/qr-code';
  static const saveCode = '/save-code';
  static const scan = '/scan';
  static const settings = '/settings';
  static const generate = '/generate';
  static const createdCodes = '/created-codes';
  static const getPremium = '/get-premium';
  static const generateCustomize = '/generate-customize';
  static const generateResult = '/generate-result';
  static const generateDescription = '/generate-description';
  static const generateDescriptionPayment = '/generate-description-payment';
  static const generateDescriptionEvent = '/generate-description-event';

  static MaterialPageRoute onGenerateRoute(RouteSettings settings) {
    final arg = settings.arguments as AppRouterArguments?;

    final routes = <String, WidgetBuilder>{
      AppRoutes.main: (BuildContext context) => const MainScreen(),
      AppRoutes.localCode: (BuildContext context) => LocalCodeScreen(localBarcode: arg!.barcode!),
      AppRoutes.scan: (BuildContext context) => const ScanScreen(),
      AppRoutes.settings: (BuildContext context) => const SettingsScreen(),
      AppRoutes.historyCodes: (BuildContext context) => const HistoryCodesScreen(),
      AppRoutes.savedCodes: (BuildContext context) => const SavedCodesScreen(),
      AppRoutes.getPremium: (BuildContext context) => const GetPremiumScreen(),
      AppRoutes.generate: (BuildContext context) => const GenerateScreen(),
      AppRoutes.createdCodes: (BuildContext context) => const CreatedScreen(),
      AppRoutes.generateCustomize: (BuildContext context) => GenerateCustomizeScreen(qr: arg!.qr!),
      AppRoutes.qrCode: (BuildContext context) => QrCodeScreen(qr: arg!.qr!),
      AppRoutes.generateResult: (BuildContext context) => GenerateResultScreen(data: arg!.dataQr!),
      AppRoutes.generateDescription: (BuildContext context) => GenerateDescriptionScreen(
            type: arg!.typeGenerate!,
          ),
      AppRoutes.generateDescriptionPayment: (BuildContext context) =>
          const GenerateDescriptionPaymentScreen(),
      AppRoutes.generateDescriptionEvent: (BuildContext context) =>
          const GenerateDescriptionEventScreen(),
      AppRoutes.saveCode: (BuildContext context) => SaveCodeScreen(
            localBarcode: arg!.barcode!,
          ),
    };

    WidgetBuilder? builder = routes[settings.name];
    return MaterialPageRoute(builder: (ctx) => builder!(ctx));
  }
}

class AppRouterArguments {
  final LocalBarcode? barcode;
  final TypeGenerate? typeGenerate;
  final String? data;
  final QrCodeGenerate? qr;
  final DataQrCode? dataQr;

  AppRouterArguments({
    this.barcode,
    this.typeGenerate,
    this.data,
    this.qr,
    this.dataQr,
  });
}
