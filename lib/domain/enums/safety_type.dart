enum SafetyType {
  wpa,
  wep,
  none,
}

String safetyTypeToString(SafetyType type) {
  final map = {
    SafetyType.wpa: 'WPA/WPA2',
    SafetyType.wep: 'WEP',
    SafetyType.none: 'None',
  };
  return map[type]!;
}

String safetyTypeFromIndex(int index) {
  if (index == 0) return 'WPA/WPA2'.toLowerCase();
  if (index == 1) return 'WEP'.toLowerCase();
  return 'None'.toLowerCase();
}
