import 'package:redux/redux.dart';
import 'package:ww_2/ui/state_manager/qr_code/action.dart';
import 'package:ww_2/ui/state_manager/qr_code/state.dart';

final createdQrCodeListReducer = combineReducers<QrCodeListState>([
  TypedReducer<QrCodeListState, LoadCreatedQrCodeListAction>(_loadCreatedQrCodeList).call,
  TypedReducer<QrCodeListState, ShowCreatedQrCodeListAction>(_showCreatedQrCodeList).call,
  TypedReducer<QrCodeListState, ErrorCreatedQrCodeListAction>(_errorCreatedQrCodeList).call,
  TypedReducer<QrCodeListState, AddCreatedQrCodeListAction>(_addCreatedQrCodeList).call,
  TypedReducer<QrCodeListState, UpdateCreatedQrCodeListAction>(_updateCreatedLocalCodeList).call,
  TypedReducer<QrCodeListState, DeleteCreatedQrCodeListAction>(_deleteHistoryLocalCodeList).call,
]);

final qrCodeGenerateReducer = combineReducers<QrCodeState>([
  TypedReducer<QrCodeState, LoadQrCodeGenerateAction>(_loadQrCodeGenerate).call,
  TypedReducer<QrCodeState, ShowQrCodeGenerateAction>(_showQrCodeGenerate).call,
  TypedReducer<QrCodeState, ErrorQrCodeGenerateAction>(_errorQrCodeGenerate).call,
]);

// qr generated

QrCodeState _loadQrCodeGenerate(
  QrCodeState state,
  LoadQrCodeGenerateAction action,
) =>
    state.copyWith(
      isLoading: true,
      isError: false,
    );

QrCodeState _showQrCodeGenerate(
  QrCodeState state,
  ShowQrCodeGenerateAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: false,
      code: action.qrCode,
    );

QrCodeState _errorQrCodeGenerate(
  QrCodeState state,
  ErrorQrCodeGenerateAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: true,
      errorMessage: action.message,
    );

// Save code

QrCodeListState _loadCreatedQrCodeList(
  QrCodeListState state,
  LoadCreatedQrCodeListAction action,
) =>
    state.copyWith(
      isLoading: true,
      isError: false,
    );

QrCodeListState _deleteHistoryLocalCodeList(
  QrCodeListState state,
  DeleteCreatedQrCodeListAction action,
) {
  final codes = state.codes.toList();
  final index = codes.indexWhere((e) => e.data == action.code.data);
  codes.removeAt(index);
  return state.copyWith(
    isLoading: false,
    isError: false,
    codes: codes,
  );
}

QrCodeListState _updateCreatedLocalCodeList(
  QrCodeListState state,
  UpdateCreatedQrCodeListAction action,
) {
  final codes = state.codes.toList();
  final index = codes.indexWhere((e) => e.data == action.code.data);
  if (index >= 0) codes[index] = action.code;
  return state.copyWith(
    isLoading: false,
    isError: false,
    codes: codes,
  );
}

QrCodeListState _addCreatedQrCodeList(
  QrCodeListState state,
  AddCreatedQrCodeListAction action,
) {
  final codes = state.codes.toList();
  codes.add(action.code);
  return state.copyWith(
    isLoading: false,
    isError: false,
    codes: codes,
  );
}

QrCodeListState _showCreatedQrCodeList(
  QrCodeListState state,
  ShowCreatedQrCodeListAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: false,
      codes: action.codes,
    );

QrCodeListState _errorCreatedQrCodeList(
  QrCodeListState state,
  ErrorCreatedQrCodeListAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: true,
      errorMessage: action.message,
    );
