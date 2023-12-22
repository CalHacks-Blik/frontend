import 'package:crypto_app/models/crypto.dart';

class ChatModel {
  final String iconUrl;
  final String amount;
   final bool isAI;
  final String summary;
  final List<CryptoValueData> graphData;
  final String text;

  ChatModel({
      this.iconUrl="",
    this.amount='',
    required this.isAI,
     this.summary= "",
     this.graphData=const [],
    this.text = "",
  });
}
