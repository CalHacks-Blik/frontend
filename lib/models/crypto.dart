class CryptoData {
  final String cryptoCode;
  final String iconUrl;
  final String cryptoName;
  final List<CryptoValueData> values;

  CryptoData(
      {required this.cryptoName,
      required this.values,
      required this.iconUrl,
      this.cryptoCode = "BTC"});

  factory CryptoData.fromJson(Map<String, dynamic> json) {
    return CryptoData(
      iconUrl: json["img_url"],
      cryptoName: json["crypto_name"],
      cryptoCode: json["crypto_code"] ?? "",
      values: List<CryptoValueData>.from(
          json['values'].map((value) => CryptoValueData.fromJson(value))),
    );
  }
}

class CryptoValueData {
  String date;
  final double close;

  CryptoValueData({
    required this.date,
    required this.close,
  });

  factory CryptoValueData.fromJson(Map<String, dynamic> json) {
    return CryptoValueData(
      date: json['date'],
      close: json['close'].toDouble() * 100,
    );
  }
}
