import 'package:get_it/get_it.dart';
import 'package:ww_2/domain/services/navigator_service.dart';
import 'package:ww_2/domain/use_cases/local_code_use_case.dart';
import 'package:ww_2/domain/use_cases/qr_code_use_case.dart';

class GetItServices {
  NavigatorService get navigatorService => GetIt.I.get<NavigatorService>();

  LocalCodeUseCase get localCodeUseCase => GetIt.I.get<LocalCodeUseCase>();

  QrCodeUseCase get qrCodeUseCase => GetIt.I.get<QrCodeUseCase>();
}

final getItService = GetItServices();
