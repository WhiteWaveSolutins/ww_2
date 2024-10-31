class Paywall {
  final String productId;
  final String title;
  final String buttonLabel;
  final String subtitle;
  final List<String> benefits;

  Paywall({
    required this.productId,
    required this.title,
    required this.buttonLabel,
    required this.benefits,
    required this.subtitle,
  });

  factory Paywall.fromJson({
    required Map<String, dynamic> data,
    required String productId,
  }) =>
      Paywall(
        productId: productId,
        title: data['title'] ?? 'Unlock all functions',
        subtitle: data['subtitle'] ?? 'Get more features with Premium experience!',
        buttonLabel: data['buttonLabel'] ?? 'Try Free & Subscribe',
        benefits: data['benefits'] ?? [],
      );
}
