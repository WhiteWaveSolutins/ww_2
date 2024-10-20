import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ww_2/data/models/local_barcode/local_barcode.dart';

part 'state.freezed.dart';

@freezed
class LocalCodeListState with _$LocalCodeListState {
  factory LocalCodeListState([
    @Default(false) bool isLoading,
    @Default(false) bool isError,
    @Default('') String errorMessage,
    @Default([]) List<LocalBarcode> codes,
  ]) = _LocalCodeListState;
}
