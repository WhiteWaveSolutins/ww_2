import 'package:ww_2/domain/enums/safety_type.dart';
import 'package:ww_2/domain/enums/type_generate.dart';

class DataQrCode {
  final TypeGenerate type;
  final String? phone;
  final String? name;
  final String? text;
  final String? price;
  final String? card;
  final String? password;
  final String? date;
  final String? event;
  final int? safety;

  DataQrCode({
    required this.type,
    this.phone,
    this.name,
    this.password,
    this.price,
    this.card,
    this.event,
    this.safety,
    this.text,
    this.date,
  });

  String get data {
    if (type == TypeGenerate.event) {
      String formattedDateTime = '${date!.split('/').last.toString().padLeft(4, '0')}'
          '${date!.split('/')[1].toString().padLeft(2, '0')}'
          '${date!.split('/').first.toString().padLeft(2, '0')}T'
          '${'0'.padLeft(2, '0')}'
          '${'0'.padLeft(2, '0')}'
          '${'0'.padLeft(2, '0')}Z';

      return '''
      BEGIN:VEVENT
      SUMMARY:$name
      DTSTART:$formattedDateTime
      DTEND:$formattedDateTime
      LOCATION:$event
      DESCRIPTION:$text
      END:VEVENT
      ''';
    }
    if (type == TypeGenerate.payment) {
      return '''
      Full name': $name
        Price': '\$$price'
        Card number': $card
        ''';
    }
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
    if (type == TypeGenerate.event) return [name!, date!, event!, text!];
    if (type == TypeGenerate.payment) return [name!, '\$$price', card!];
    return [text!];
  }

  String toDataForDataBase() {
    if (type == TypeGenerate.sms || type == TypeGenerate.email) return '${type.name}/$name/$text';
    if (type == TypeGenerate.wifi) return '${type.name}/$name/$safety/$password';
    if (type == TypeGenerate.phone) return '${type.name}/$phone';
    if (type == TypeGenerate.event) return '${type.name}/$name/$date/$event/$text';
    if (type == TypeGenerate.payment) return '${type.name}/$name/$price/$card';
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
      date: type == TypeGenerate.event ? data[2] : null,
      event: type == TypeGenerate.event ? data[3] : null,
      price: type == TypeGenerate.payment ? data[2] : null,
      card: type == TypeGenerate.payment ? data[3] : null,
      name: [
        TypeGenerate.email,
        TypeGenerate.sms,
        TypeGenerate.wifi,
        TypeGenerate.event,
        TypeGenerate.payment,
      ].contains(type)
          ? data[1]
          : null,
      text: ![
        TypeGenerate.phone,
        TypeGenerate.wifi,
        TypeGenerate.event,
      ].contains(type)
          ? data.last
          : null,
    );
  }
}
