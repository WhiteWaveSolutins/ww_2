import 'package:ww_2/ui/state_manager/locale_code/action.dart';
import 'package:ww_2/ui/state_manager/locale_code/reducer.dart';
import 'package:ww_2/ui/state_manager/qr_code/action.dart';
import 'package:ww_2/ui/state_manager/qr_code/reducer.dart';
import 'package:ww_2/ui/state_manager/store.dart';

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
  }
  return state;
}
