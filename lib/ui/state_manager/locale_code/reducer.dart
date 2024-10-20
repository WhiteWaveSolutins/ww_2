import 'package:redux/redux.dart';
import 'package:ww_2/ui/state_manager/locale_code/action.dart';
import 'package:ww_2/ui/state_manager/locale_code/state.dart';

final saveLocalCodeListReducer = combineReducers<LocalCodeListState>([
  TypedReducer<LocalCodeListState, LoadSaveLocalCodeListAction>(_loadSaveLocalCodeList).call,
  TypedReducer<LocalCodeListState, ShowSaveLocalCodeListAction>(_showSaveLocalCodeList).call,
  TypedReducer<LocalCodeListState, ErrorSaveLocalCodeListAction>(_errorSaveLocalCodeList).call,
  TypedReducer<LocalCodeListState, AddSaveLocalCodeListAction>(_addSaveLocalCodeList).call,
  TypedReducer<LocalCodeListState, UpdateSaveLocalCodeListAction>(_updateSaveLocalCodeList).call,
  TypedReducer<LocalCodeListState, DeleteSaveLocalCodeListAction>(_deleteSaveLocalCodeList).call,
]);

final historyLocalCodeListReducer = combineReducers<LocalCodeListState>([
  TypedReducer<LocalCodeListState, LoadHistoryLocalCodeListAction>(_loadHistoryLocalCodeList).call,
  TypedReducer<LocalCodeListState, ShowHistoryLocalCodeListAction>(_showHistoryLocalCodeList).call,
  TypedReducer<LocalCodeListState, ErrorHistoryLocalCodeListAction>(_errorHistoryLocalCodeList)
      .call,
  TypedReducer<LocalCodeListState, AddHistoryLocalCodeListAction>(_addHistoryLocalCodeList).call,
  TypedReducer<LocalCodeListState, DeleteHistoryLocalCodeListAction>(_deleteHistoryLocalCodeList)
      .call,
]);

// History code

LocalCodeListState _loadHistoryLocalCodeList(
  LocalCodeListState state,
  LoadHistoryLocalCodeListAction action,
) =>
    state.copyWith(
      isLoading: true,
      isError: false,
    );

LocalCodeListState _deleteHistoryLocalCodeList(
  LocalCodeListState state,
  DeleteHistoryLocalCodeListAction action,
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

LocalCodeListState _addHistoryLocalCodeList(
  LocalCodeListState state,
  AddHistoryLocalCodeListAction action,
) {
  final codes = state.codes.toList();
  codes.add(action.code);
  return state.copyWith(
    isLoading: false,
    isError: false,
    codes: codes,
  );
}

LocalCodeListState _showHistoryLocalCodeList(
  LocalCodeListState state,
  ShowHistoryLocalCodeListAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: false,
      codes: action.codes,
    );

LocalCodeListState _errorHistoryLocalCodeList(
  LocalCodeListState state,
  ErrorHistoryLocalCodeListAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: true,
      errorMessage: action.message,
    );

// Save code

LocalCodeListState _loadSaveLocalCodeList(
  LocalCodeListState state,
  LoadSaveLocalCodeListAction action,
) =>
    state.copyWith(
      isLoading: true,
      isError: false,
    );

LocalCodeListState _deleteSaveLocalCodeList(
  LocalCodeListState state,
  DeleteSaveLocalCodeListAction action,
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

LocalCodeListState _updateSaveLocalCodeList(
  LocalCodeListState state,
  UpdateSaveLocalCodeListAction action,
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

LocalCodeListState _addSaveLocalCodeList(
  LocalCodeListState state,
  AddSaveLocalCodeListAction action,
) {
  final codes = state.codes.toList();
  codes.add(action.code);
  return state.copyWith(
    isLoading: false,
    isError: false,
    codes: codes,
  );
}

LocalCodeListState _showSaveLocalCodeList(
  LocalCodeListState state,
  ShowSaveLocalCodeListAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: false,
      codes: action.codes,
    );

LocalCodeListState _errorSaveLocalCodeList(
  LocalCodeListState state,
  ErrorSaveLocalCodeListAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: true,
      errorMessage: action.message,
    );
