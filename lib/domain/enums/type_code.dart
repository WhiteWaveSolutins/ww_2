enum TypeCode {
  product,
  personalData,
  payment,
  webPages,
  tickets,
  geographicData,
  multimedia,
  other,
}

TypeCode typeCodeToData(String type) {
  final map = {
    'product': TypeCode.product,
    'personalData': TypeCode.personalData,
    'payment': TypeCode.payment,
    'webPages': TypeCode.webPages,
    'tickets': TypeCode.tickets,
    'geographicData': TypeCode.geographicData,
    'multimedia': TypeCode.multimedia,
    'other': TypeCode.other,
  };
  return map[type]!;
}

String typeCodeToString(TypeCode type) {
  final map = {
    TypeCode.product: 'Product',
    TypeCode.personalData: 'Personal data',
    TypeCode.payment: 'Payment',
    TypeCode.webPages: 'Web pages',
    TypeCode.tickets: 'Tickets',
    TypeCode.geographicData: 'Geographic data',
    TypeCode.multimedia: 'Multimedia',
    TypeCode.other: 'Other',
  };
  return map[type]!;
}

String typeCodeToIcon(TypeCode type) {
  final map = {
    TypeCode.product: '🍎',
    TypeCode.personalData: '💾',
    TypeCode.payment: '💵',
    TypeCode.webPages: '🖥️',
    TypeCode.tickets: '✈️',
    TypeCode.geographicData: '🌍',
    TypeCode.multimedia: '🎧',
    TypeCode.other: '👩‍💻',
  };
  return map[type]!;
}
