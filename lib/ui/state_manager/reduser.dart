import 'package:ww_2/ui/state_manager/locale_code/action.dart';
import 'package:ww_2/ui/state_manager/locale_code/reducer.dart';
import 'package:ww_2/ui/state_manager/paywall/action.dart';
import 'package:ww_2/ui/state_manager/paywall/reducer.dart';
import 'package:ww_2/ui/state_manager/qr_code/action.dart';
import 'package:ww_2/ui/state_manager/qr_code/reducer.dart';
import 'package:ww_2/ui/state_manager/store.dart';
import 'package:ww_2/ui/state_manager/subscription/action.dart';
import 'package:ww_2/ui/state_manager/subscription/reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is SaveLocalCodeListAction) {
    final nextState = saveLocalCodeListReducer(state.savedCodeListState, action);
    return state.copyWith(savedCodeListState: nextState);
  } else if (action is HistoryLocalCodeListAction) {
    final nextState = historyLocalCodeListReducer(state.historyCodeListState, action);
    return state.copyWith(historyCodeListState: nextState);
  } else if (action is QrCodeGenerateAction) {
    final nextState = qrCodeGenerateReducer(state.qrCodeGeneratedState, action);
    return state.copyWith(qrCodeGeneratedState: nextState);
  } else if (action is CreatedQrCodeListAction) {
    final nextState = createdQrCodeListReducer(state.createdQrCodeListState, action);
    return state.copyWith(createdQrCodeListState: nextState);
  } else if (action is SubscriptionAction) {
    final nextState = subscriptionReducer(state.subscriptionState, action);
    return state.copyWith(subscriptionState: nextState);
  } else if (action is PaywallListAction) {
    final nextState = paywallListReducer(state.paywallListState, action);
    return state.copyWith(paywallListState: nextState);
  }
  return state;
}
