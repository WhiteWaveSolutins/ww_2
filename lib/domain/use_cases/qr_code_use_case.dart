import 'package:redux/redux.dart';
import 'package:ww_2/data/models/qr_code/qr_code.dart';
import 'package:ww_2/domain/repositories/qr_code_repository.dart';
import 'package:ww_2/ui/state_manager/qr_code/action.dart';
import 'package:ww_2/ui/state_manager/store.dart';

class QrCodeUseCase {
  final QrCodeRepository qrCodeRepository;
  final Store<AppState> store;

  QrCodeUseCase({
    required this.qrCodeRepository,
    required this.store,
  });

  void addSave(QrCodeGenerate barcode) {
    qrCodeRepository.save(code: barcode);
    store.dispatch(AddCreatedQrCodeListAction(code: barcode));
  }

  void deleteSave(QrCodeGenerate barcode) {
    qrCodeRepository.delete(code: barcode);
    store.dispatch(DeleteCreatedQrCodeListAction(code: barcode));
  }

  void updateSave(QrCodeGenerate barcode) {
    qrCodeRepository.update(code: barcode);
    store.dispatch(UpdateCreatedQrCodeListAction(code: barcode));
  }
}
