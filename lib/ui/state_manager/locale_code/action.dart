import 'package:ww_2/data/models/local_barcode/local_barcode.dart';

//Save codes

abstract class SaveLocalCodeListAction {}

class LoadSaveLocalCodeListAction extends SaveLocalCodeListAction {}

class ShowSaveLocalCodeListAction extends SaveLocalCodeListAction {
  final List<LocalBarcode> codes;

  ShowSaveLocalCodeListAction({required this.codes});
}

class AddSaveLocalCodeListAction extends SaveLocalCodeListAction {
  final LocalBarcode code;

  AddSaveLocalCodeListAction({required this.code});
}

class DeleteSaveLocalCodeListAction extends SaveLocalCodeListAction {
  final LocalBarcode code;

  DeleteSaveLocalCodeListAction({required this.code});
}

class UpdateSaveLocalCodeListAction extends SaveLocalCodeListAction {
  final LocalBarcode code;

  UpdateSaveLocalCodeListAction({required this.code});
}

class ErrorSaveLocalCodeListAction extends SaveLocalCodeListAction {
  final String message;

  ErrorSaveLocalCodeListAction({required this.message});
}

//History codes

abstract class HistoryLocalCodeListAction {}

class LoadHistoryLocalCodeListAction extends HistoryLocalCodeListAction {}

class ShowHistoryLocalCodeListAction extends HistoryLocalCodeListAction {
  final List<LocalBarcode> codes;

  ShowHistoryLocalCodeListAction({required this.codes});
}

class AddHistoryLocalCodeListAction extends HistoryLocalCodeListAction {
  final LocalBarcode code;

  AddHistoryLocalCodeListAction({required this.code});
}

class DeleteHistoryLocalCodeListAction extends HistoryLocalCodeListAction {
  final LocalBarcode code;

  DeleteHistoryLocalCodeListAction({required this.code});
}

class ErrorHistoryLocalCodeListAction extends HistoryLocalCodeListAction {
  final String message;

  ErrorHistoryLocalCodeListAction({required this.message});
}
