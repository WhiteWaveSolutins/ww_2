import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:redux/redux.dart';
import 'package:ww_2/data/api/api.dart';
import 'package:ww_2/data/database/database.dart';
import 'package:ww_2/data/repositories/api_qr_code_repository.dart';
import 'package:ww_2/data/repositories/local_local_code_repository.dart';
import 'package:ww_2/domain/repositories/local_code_repository.dart';
import 'package:ww_2/domain/repositories/qr_code_repository.dart';
import 'package:ww_2/domain/services/navigator_service.dart';
import 'package:ww_2/domain/use_cases/local_code_use_case.dart';
import 'package:ww_2/domain/use_cases/qr_code_use_case.dart';
import 'package:ww_2/ui/state_manager/locale_code/middleware.dart';
import 'package:ww_2/ui/state_manager/locale_code/state.dart';
import 'package:ww_2/ui/state_manager/qr_code/middleware.dart';
import 'package:ww_2/ui/state_manager/qr_code/state.dart';
import 'package:ww_2/ui/state_manager/reduser.dart';
import 'package:ww_2/ui/state_manager/store.dart';

class LocatorService {
  final api = Api();
  final database = AppDataBase();
  final navigatorKey = GlobalKey<NavigatorState>();

  late LocalCodeRepository localCodeRepository;
  late QrCodeRepository qrCodeRepository;

  late NavigatorService navigatorService;

  late LocalCodeUseCase localCodeUseCase;
  late QrCodeUseCase qrCodeUseCase;

  late Store<AppState> store;

  LocatorService() {
    localCodeRepository = LocalLocalCodeRepository(database: database);
    qrCodeRepository = ApiQrCodeRepository(
      api: api,
      dataBase: database,
    );

    navigatorService = NavigatorService(navigatorKey: navigatorKey);

    store = Store(
      appReducer,
      initialState: AppState(
        savedCodeListState: LocalCodeListState(),
        historyCodeListState: LocalCodeListState(),
        qrCodeGeneratedState: QrCodeState(),
        createdQrCodeListState: QrCodeListState(),
      ),
      middleware: [
        LocalCodeMiddleware(localCodeRepository: localCodeRepository).call,
        QrCodeMiddleware(qrCodeRepository: qrCodeRepository).call,
      ],
    );

    localCodeUseCase = LocalCodeUseCase(
      localCodeRepository: localCodeRepository,
      store: store,
    );
    qrCodeUseCase = QrCodeUseCase(
      qrCodeRepository: qrCodeRepository,
      store: store,
    );

    _register();
  }

  void _register() {
    GetIt.I.registerSingleton<NavigatorService>(navigatorService);
    GetIt.I.registerSingleton<LocalCodeUseCase>(localCodeUseCase);
    GetIt.I.registerSingleton<QrCodeUseCase>(qrCodeUseCase);
  }
}
