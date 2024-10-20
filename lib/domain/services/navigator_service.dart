import 'package:flutter/cupertino.dart';
import 'package:ww_2/data/models/local_barcode/local_barcode.dart';
import 'package:ww_2/data/models/qr_code/data_qr_code.dart';
import 'package:ww_2/data/models/qr_code/qr_code.dart';
import 'package:ww_2/domain/enums/type_generate.dart';
import 'package:ww_2/route.dart';

class NavigatorService {
  final GlobalKey<NavigatorState> navigatorKey;

  NavigatorService({required this.navigatorKey});

  void onPop() => navigatorKey.currentState!.pop();

  bool canPop() => navigatorKey.currentState!.canPop();

  void onFirst() => navigatorKey.currentState!.popUntil((route) => route.isFirst);

  void onMain() => navigatorKey.currentState!.pushNamedAndRemoveUntil(
        AppRoutes.main,
        (Route<dynamic> route) => false,
      );

  void onSavedCodes() => navigatorKey.currentState!.pushNamed(AppRoutes.savedCodes);

  void onHistoryCodes() => navigatorKey.currentState!.pushNamed(AppRoutes.historyCodes);

  void onLocalCode({required LocalBarcode barcode}) {
    navigatorKey.currentState!.pushNamed(
      AppRoutes.localCode,
      arguments: AppRouterArguments(barcode: barcode),
    );
  }

  void onScan() => navigatorKey.currentState!.pushNamed(AppRoutes.scan);

  void onGenerate() => navigatorKey.currentState!.pushNamed(AppRoutes.generate);

  void onCreated() => navigatorKey.currentState!.pushNamed(AppRoutes.createdCodes);

  void onGetPremium() => navigatorKey.currentState!.pushNamed(AppRoutes.getPremium);

  void onGenerateDescription({required TypeGenerate type}) {
    navigatorKey.currentState!.pushNamed(
      AppRoutes.generateDescription,
      arguments: AppRouterArguments(typeGenerate: type),
    );
  }

  void onGenerateResult({required DataQrCode data}) {
    onFirst();
    navigatorKey.currentState!.pushNamed(
      AppRoutes.generateResult,
      arguments: AppRouterArguments(dataQr: data),
    );
  }

  void onGenerateCustomize({required QrCodeGenerate qr}) {
    navigatorKey.currentState!.pushNamed(
      AppRoutes.generateCustomize,
      arguments: AppRouterArguments(qr: qr),
    );
  }

  void onQrCode({required QrCodeGenerate qr}) {
    navigatorKey.currentState!.pushNamed(
      AppRoutes.qrCode,
      arguments: AppRouterArguments(qr: qr),
    );
  }

  void onSaveCode({required LocalBarcode barcode}) {
    navigatorKey.currentState!.pushNamed(
      AppRoutes.saveCode,
      arguments: AppRouterArguments(barcode: barcode),
    );
  }
}
