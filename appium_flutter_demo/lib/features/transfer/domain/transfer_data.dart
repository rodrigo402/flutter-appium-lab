class TransferData {
  const TransferData({
    required this.recipientName,
    required this.amount,
    this.description,
  });

  final String recipientName;
  final double amount;
  final String? description;

  String get summary =>
      'Destinatario: $recipientName\nMonto: \$${amount.toStringAsFixed(2)}';
}
