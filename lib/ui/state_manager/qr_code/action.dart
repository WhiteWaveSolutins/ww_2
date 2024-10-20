import 'package:ww_2/data/models/config_customize.dart';
import 'package:ww_2/data/models/qr_code/data_qr_code.dart';
import 'package:ww_2/data/models/qr_code/qr_code.dart';

//Generated code

abstract class QrCodeGenerateAction {}

class LoadQrCodeGenerateAction extends QrCodeGenerateAction {
  final DataQrCode data;
  final ConfigCustomize? config;

  LoadQrCodeGenerateAction({
    required this.data,
    this.config,
  });
}

class ShowQrCodeGenerateAction extends QrCodeGenerateAction {
  final QrCodeGenerate qrCode;

  ShowQrCodeGenerateAction({required this.qrCode});
}

class ErrorQrCodeGenerateAction extends QrCodeGenerateAction {
  final String message;

  ErrorQrCodeGenerateAction({required this.message});
}

//Created codes

abstract class CreatedQrCodeListAction {}

class LoadCreatedQrCodeListAction extends CreatedQrCodeListAction {}

class ShowCreatedQrCodeListAction extends CreatedQrCodeListAction {
  final List<QrCodeGenerate> codes;

  ShowCreatedQrCodeListAction({required this.codes});
}

class AddCreatedQrCodeListAction extends CreatedQrCodeListAction {
  final QrCodeGenerate code;

  AddCreatedQrCodeListAction({required this.code});
}

class DeleteCreatedQrCodeListAction extends CreatedQrCodeListAction {
  final QrCodeGenerate code;

  DeleteCreatedQrCodeListAction({required this.code});
}

class UpdateCreatedQrCodeListAction extends CreatedQrCodeListAction {
  final QrCodeGenerate code;

  UpdateCreatedQrCodeListAction({required this.code});
}

class ErrorCreatedQrCodeListAction extends CreatedQrCodeListAction {
  final String message;

  ErrorCreatedQrCodeListAction({required this.message});
}
