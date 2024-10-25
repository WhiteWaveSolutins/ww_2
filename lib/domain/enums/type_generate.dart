enum TypeGenerate {
  text,
  sms,
  email,
  website,
  wifi,
  phone,
  payment,
  event
}

TypeGenerate typeGenerateToData(String type) {
  final map = {
    'text': TypeGenerate.text,
    'sms': TypeGenerate.sms,
    'email': TypeGenerate.email,
    'website': TypeGenerate.website,
    'wifi': TypeGenerate.wifi,
    'phone': TypeGenerate.phone,
    'payment': TypeGenerate.payment,
    'event': TypeGenerate.event,
  };
  return map[type]!;
}

String typeGenerateToString(TypeGenerate type) {
  final map = {
    TypeGenerate.text: 'Text',
    TypeGenerate.sms: 'SMS',
    TypeGenerate.email: 'Email',
    TypeGenerate.website: 'Website',
    TypeGenerate.wifi: 'WiFi',
    TypeGenerate.phone: 'Phone',
    TypeGenerate.event: 'Event',
    TypeGenerate.payment: 'Payment',
  };
  return map[type]!;
}

String typeGenerateToIcon(TypeGenerate type) {
  final map = {
    TypeGenerate.text: 'assets/icons/text.svg',
    TypeGenerate.sms: 'assets/icons/sms.svg',
    TypeGenerate.email: 'assets/icons/email.svg',
    TypeGenerate.website: 'assets/icons/browser.svg',
    TypeGenerate.wifi: 'assets/icons/wi_fi.svg',
    TypeGenerate.phone: 'assets/images/phone.png',
    TypeGenerate.event: 'assets/icons/calendar.svg',
    TypeGenerate.payment: 'assets/icons/credit_card.svg',
  };
  return map[type]!;
}