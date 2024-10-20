import 'package:redux/redux.dart';
import 'package:ww_2/data/models/answer/answer.dart';
import 'package:ww_2/data/models/qr_code/qr_code.dart';
import 'package:ww_2/domain/repositories/qr_code_repository.dart';
import 'package:ww_2/ui/state_manager/qr_code/action.dart';
import 'package:ww_2/ui/state_manager/store.dart';

class QrCodeMiddleware implements MiddlewareClass<AppState> {
  final QrCodeRepository qrCodeRepository;

  QrCodeMiddleware({required this.qrCodeRepository});

  @override
  call(store, action, next) {
    // Saved
    if (action is LoadCreatedQrCodeListAction) {
      Future(() async {
        final codes = await qrCodeRepository.getCrated();
        store.dispatch(ShowCreatedQrCodeListAction(codes: codes));
      });
    }

    // Qr
    if (action is LoadQrCodeGenerateAction) {
      Future(() async {
        late Answer<QrCodeGenerate> answer;
        if (action.config == null) {
          answer = await qrCodeRepository.create(data: action.data);
        } else {
          answer = await qrCodeRepository.customize(
            data: action.data,
            config: action.config!,
          );
        }
        if (answer.data == null) {
          store.dispatch(ErrorQrCodeGenerateAction(message: answer.error ?? 'Some error'));
        } else {
          store.dispatch(
            ShowQrCodeGenerateAction(qrCode: answer.data!),
          );
        }
      });
    }

    next(action);
  }
}
