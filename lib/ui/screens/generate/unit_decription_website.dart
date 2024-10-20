class UnitDescriptionWebsite {
  static String? www(String text) {
    if (text.isEmpty) return 'www.';
    final data = Uri.tryParse(text);
    if (data == null) return null;
    final sp = text.split(data.host).toList();
    final host = data.host.split('.');
    if (host.length > 1) host.removeAt(0);
    sp.insert(1, 'www.${host.join('.')}');
    return sp.join();
  }

  static String? com(String text) {
    if (text.isEmpty) return '.com';
    final data = Uri.tryParse(text);
    if (data == null) return null;
    final sp = text.split(data.host).toList();
    final host = data.host.split('.');
    if (host.length > 1) host.removeAt(host.length - 1);
    sp.insert(1, '${host.join('.')}.com');
    return sp.join();
  }

  static String http(String text) {
    final data = text.split('://').toList();
    if (data.length > 1) data.removeAt(0);
    return 'http://${data.join('://')}';
  }

  static String https(String text) {
    final data = text.split('://').toList();
    if (data.length > 1) data.removeAt(0);
    return 'https://${data.join('://')}';
  }
}
