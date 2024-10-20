import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:redux/redux.dart';
import 'package:ww_2/data/models/local_barcode/local_barcode.dart';
import 'package:ww_2/domain/repositories/local_code_repository.dart';
import 'package:ww_2/ui/state_manager/locale_code/action.dart';
import 'package:ww_2/ui/state_manager/store.dart';

class LocalCodeUseCase {
  final LocalCodeRepository localCodeRepository;
  final Store<AppState> store;

  LocalCodeUseCase({
    required this.localCodeRepository,
    required this.store,
  });

  void addHistory(BarcodeCapture barcode) {
    if (barcode.barcodes.firstOrNull?.displayValue == null) return;
    final code = LocalBarcode(
      data: barcode.barcodes.firstOrNull!.displayValue!,
      created: DateTime.now(),
      format: barcode.barcodes.firstOrNull!.format,
    );
    localCodeRepository.addHistoryCodes(code: code);
    store.dispatch(AddHistoryLocalCodeListAction(code: code));
  }

  void deleteSave(LocalBarcode barcode) {
    localCodeRepository.deleteSavedCodes(code: barcode);
    store.dispatch(DeleteSaveLocalCodeListAction(code: barcode));
  }

  void deleteHistory(LocalBarcode barcode) {
    localCodeRepository.deleteHistoryCodes(code: barcode);
    store.dispatch(DeleteHistoryLocalCodeListAction(code: barcode));
  }

  void deleteHistoryAll() {
    localCodeRepository.deleteHistory();
    store.dispatch(ShowHistoryLocalCodeListAction(codes: []));
  }

  void addSave(LocalBarcode barcode) {
    localCodeRepository.addSavedCodes(code: barcode);
    store.dispatch(AddSaveLocalCodeListAction(code: barcode));
  }

  void updateSave(LocalBarcode barcode) {
    localCodeRepository.updateSavedCodes(code: barcode);
    store.dispatch(UpdateSaveLocalCodeListAction(code: barcode));
  }
}
