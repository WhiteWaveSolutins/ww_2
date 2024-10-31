import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ww_2/ui/state_manager/locale_code/state.dart';
import 'package:ww_2/ui/state_manager/paywall/state.dart';
import 'package:ww_2/ui/state_manager/qr_code/state.dart';
import 'package:ww_2/ui/state_manager/subscription/state.dart';

part 'store.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    //Local codes
    required LocalCodeListState savedCodeListState,
    required LocalCodeListState historyCodeListState,
    //Qr code
    required QrCodeState qrCodeGeneratedState,
    required QrCodeListState createdQrCodeListState,
    //Subscription
    required SubscriptionState subscriptionState,
    required PaywallListState paywallListState,
  }) = _AppState;
}
