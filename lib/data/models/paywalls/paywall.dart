class Paywall {
  final String productId;
  final String title;
  final String buttonLabel;

  Paywall({
    required this.productId,
    required this.title,
    required this.buttonLabel,
  });

  factory Paywall.fromJson({
    required Map<String, dynamic> data,
    required String productId,
  }) =>
      Paywall(
        productId: productId,
        title: data['title'],
        buttonLabel: data['buttonLabel'],
      );
}
