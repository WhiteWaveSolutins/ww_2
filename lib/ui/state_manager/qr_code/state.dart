import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ww_2/data/models/qr_code/qr_code.dart';

part 'state.freezed.dart';

@freezed
class QrCodeListState with _$QrCodeListState {
  factory QrCodeListState([
    @Default(false) bool isLoading,
    @Default(false) bool isError,
    @Default('') String errorMessage,
    @Default([]) List<QrCodeGenerate> codes,
  ]) = _QrCodeListState;
}

@freezed
class QrCodeState with _$QrCodeState {
  factory QrCodeState([
    @Default(false) bool isLoading,
    @Default(false) bool isError,
    @Default('') String errorMessage,
    QrCodeGenerate? code,
  ]) = _QrCodeState;
}
