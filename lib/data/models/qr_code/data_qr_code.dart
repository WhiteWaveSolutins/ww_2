import 'package:ww_2/domain/enums/safety_type.dart';
import 'package:ww_2/domain/enums/type_generate.dart';

class DataQrCode {
  final TypeGenerate type;
  final String? phone;
  final String? name;
  final String? text;
  final String? password;
  final int? safety;

  DataQrCode({
    required this.type,
    this.phone,
    this.name,
    this.password,
    this.safety,
    this.text,
  });

  String get data {
    if (type == TypeGenerate.sms) return 'smsto:$name:$text';
    if (type == TypeGenerate.wifi) {
      return 'WIFI:T:${safetyTypeFromIndex(safety!)};S:$name;P:$password;';
    }
    if (type == TypeGenerate.phone) return phone!;
    if (type == TypeGenerate.email) {
      return 'mailto:$name?body=${Uri.encodeComponent(text!)}';
    }
    return text ?? '';
  }

  List<String> get custom {
    if (type == TypeGenerate.sms || type == TypeGenerate.email) return [name!, text!];
    if (type == TypeGenerate.wifi) return [name!, safetyTypeFromIndex(safety!), password!];
    if (type == TypeGenerate.phone) return [phone!];
    return [text!];
  }

  String toDataForDataBase() {
    if (type == TypeGenerate.sms || type == TypeGenerate.email) return '${type.name}/$name/$text';
    if (type == TypeGenerate.wifi) return '${type.name}/$name/$safety/$password';
    if (type == TypeGenerate.phone) return '${type.name}/$phone';
    return '${type.name}/$text';
  }

  factory DataQrCode.fromTableData(String tableData) {
    final data = tableData.split('/').toList();
    final type = typeGenerateToData(data.first);
    return DataQrCode(
      type: typeGenerateToData(data.first),
      phone: type == TypeGenerate.phone ? data.last : null,
      password: type == TypeGenerate.wifi ? data.last : null,
      safety: type == TypeGenerate.wifi ? int.parse(data[2]) : null,
      name:
          [TypeGenerate.email, TypeGenerate.sms, TypeGenerate.wifi].contains(type) ? data[1] : null,
      text: ![TypeGenerate.phone, TypeGenerate.wifi].contains(type) ? data.last : null,
    );
  }
}
