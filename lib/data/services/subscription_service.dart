import 'package:apphud/apphud.dart';
import 'package:apphud/models/apphud_models/apphud_composite_model.dart';
import 'package:apphud/models/apphud_models/composite/apphud_purchase_result.dart';
import 'package:talker/talker.dart';
import 'package:ww_2/data/models/answer/answer.dart';
import 'package:ww_2/data/models/paywalls/paywall.dart';
import 'package:ww_2/data/services/remote_config_service.dart';
class SubscriptionService {
  final ConfigService remoteConfigService;

  //late ApphudUser _user;
  SubscriptionService({required this.remoteConfigService}) {
    _init();
  }
  void _init() async {
    await Apphud.start(apiKey: remoteConfigService.apphudKey);
    //getMainPaywall();
  }
  Future<Answer<List<Paywall>>> getPaywalls() async {
    try {
      final paywalls = await Apphud.paywalls();
      final data = paywalls!.paywalls
          .map(
            (e) => Paywall.fromJson(
          data: e.json!,
          productId: e.products!.first.productId,
        ),
      )
          .toList();
      return Answer(data: data);
    } catch (e) {
      _log(message: 'Подписки $e');
      return Answer(error: e.toString());
    }
  }
  Future<Answer<Paywall>> getOnboardingPaywall() async {
    try {
      final paywalls = await Apphud.paywalls();
      final data = paywalls!.paywalls.first.json!;
      final paywall = Paywall.fromJson(
        data: data,
        productId: paywalls.paywalls.first.products!.first.productId,
      );
      return Answer(data: paywall);
    } catch (e) {
      _log(message: e.toString());
      return Answer(error: e.toString());
    }
  }
  Future<Answer<Paywall>> getMainPaywall() async {
    try {
      final paywalls = await Apphud.paywalls();
      final data = paywalls!.paywalls.last.json!;
      final paywall = Paywall.fromJson(
        data: data,
        productId: paywalls.paywalls.last.products!.first.productId,
      );
      return Answer(data: paywall);
    } catch (e) {
      _log(message: e.toString());
      return Answer(error: e.toString());
    }
  }
  Future<ApphudComposite> restore() async {
    try {
      final res = await Apphud.restorePurchases();
      return res;
    } catch (e) {
      _log(message: e.toString());
      rethrow;
    }
  }
  Future<Answer<ApphudPurchaseResult>> purchase(String productId) async {
    try {
      final res = await Apphud.purchase(productId: productId);
      return Answer(data: res);
    } catch (e) {
      _log(message: e.toString());
      return Answer(error: e.toString());
    }
  }
  Future<bool> hasPremiumAccess() async => await Apphud.hasPremiumAccess();
}
void _log({required String message}) {
  Talker().logTyped(
    TalkerLog(
      message,
      title: 'Subscription Error',
      logLevel: LogLevel.critical,
    ),
  );
}