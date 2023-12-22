import 'dart:convert';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:crypto_app/models/ai.dart';
import 'package:crypto_app/models/crypto.dart';
import 'package:crypto_app/widgets/balance_panel/balance_panel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textController = TextEditingController();

  bool isLoading = false;

  void _sendMessage(
    String message,
  ) async {
    // Create a new chat message instance
    final chatMessage = ChatModel(
      text: message,
      isAI: false,
    );

    setState(() {
      _messages.add(chatMessage);
      isLoading = true;
    });

    // If it's a text message, send it to the AI and handle the response.
    final response = await http.get(Uri.parse(
        'https://scintillating-discovery-production.up.railway.app/chat_completion?prompt=${message}'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print(jsonData);

      List<CryptoValueData> _graphData = [];
      for (var data in jsonData["response"]) {
        _graphData.add(CryptoValueData.fromJson(data));
      }

      setState(() {
        _messages.add(ChatModel(
          graphData:
              _graphData, // You can set this to an empty string for AI responses
          isAI: true,
          amount: jsonData["amount"],
          summary: jsonData["summary"],
          iconUrl: jsonData["img_url"],
        ));
        isLoading = false;
      });
      print(_messages);
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<ChatModel> _messages = [];

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Container(
      child: Column(
        children: [
          Expanded(
            child: Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: ListView.builder(
                  reverse: false,
                  itemCount: _messages.length + (isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < _messages.length) {
                      final chatMessage = _messages[index];
                      return Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            if (chatMessage.isAI)
                              aiReply(
                                chatMessage.graphData,
                                themeData,
                                chatMessage.iconUrl,
                                chatMessage.amount,
                                chatMessage.summary,
                                context,
                              )
                            else
                              BubbleSpecialOne(
                                text: chatMessage.text,
                                isSender: true,
                                color:
                                    themeData.backgroundColor.withOpacity(0.1),
                                textStyle: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                          ],
                        ),
                      );
                    } else if (isLoading) {
                      // Display the loading animation only if it's the last item
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Shimmer.fromColors(
                          child: Container(
                            width: MediaQuery.of(context).size.width - 100,
                            height: 100,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          baseColor: Colors.grey.withOpacity(0.5),
                          highlightColor: Colors.grey.withOpacity(0.2),
                        ),
                      );
                    }
                    return SizedBox();
                  },
                )),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: themeData.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Enter your text here',
                        hintStyle:
                            GoogleFonts.poppins(fontWeight: FontWeight.w500),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.black),
                  child: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () async {
                      final message = _textController.text;
                      _textController.clear();
                      _sendMessage(message);
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Widget buildShimmer() {
    return Shimmer.fromColors(
      child: Container(
        width: 90.w,
        height: 42.h,
      ),
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
    );
  }
}
