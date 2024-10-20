import 'package:redux/redux.dart';
import 'package:ww_2/domain/repositories/local_code_repository.dart';
import 'package:ww_2/ui/state_manager/locale_code/action.dart';
import 'package:ww_2/ui/state_manager/store.dart';

class LocalCodeMiddleware implements MiddlewareClass<AppState> {
  final LocalCodeRepository localCodeRepository;

  LocalCodeMiddleware({required this.localCodeRepository});

  @override
  call(store, action, next) {
    // Saved
    if (action is LoadSaveLocalCodeListAction) {
      Future(() async {
        final codes = await localCodeRepository.getSavedCodes();
        store.dispatch(ShowSaveLocalCodeListAction(codes: codes));
      });
    }

    // History
    if (action is LoadHistoryLocalCodeListAction) {
      Future(() async {
        final codes = await localCodeRepository.getHistoryCodes();
        store.dispatch(ShowHistoryLocalCodeListAction(codes: codes));
      });
    }

    next(action);
  }
}
