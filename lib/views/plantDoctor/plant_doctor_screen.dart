import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../../services/chatbot_service.dart';
import 'components/chat_massage.dart';

class PlantDoctor extends StatefulWidget {
  const PlantDoctor({Key? key}) : super(key: key);

  @override
  PlantDoctorState createState() => PlantDoctorState();
}

class PlantDoctorState extends State<PlantDoctor>
    with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMassage> _massages = [];
  final ChatbotService _chatbotService = ChatbotService();

  bool _isSendingMessage = false;
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _sendMassage() async {
    if (_controller.text.trim().isEmpty) {
      return;
    }

    final ChatMassage userMassage = ChatMassage(
        text: _controller.text,
        sender: Constants.userSender,
        isResponse: false);
    setState(() {
      _massages.insert(0, userMassage);
      _isSendingMessage = true;
    });

    _controller.clear();

    try {
      final String botReply = await _chatbotService.getReply(userMassage.text);

      final ChatMassage botMassage = ChatMassage(
          text: botReply, sender: Constants.botSender, isResponse: true);
      setState(() {
        _massages.insert(0, botMassage);
        _isSendingMessage = false;
      });
    } catch (e) {
      final ChatMassage errorMassage = ChatMassage(
          text: "${Constants.errorMessage}$e",
          sender: Constants.errorSender,
          isResponse: true);
      setState(() {
        _massages.insert(0, errorMassage);
        _isSendingMessage = false;
      });
    }
  }

  Widget _buildTextComposer() {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              onSubmitted: (value) => _sendMassage(),
              decoration: InputDecoration.collapsed(
                  hintText: _isSendingMessage ? "" : Constants.chatHint),
              enabled: !_isSendingMessage,
            ),
          ),
          IconButton(
            onPressed: _isSendingMessage ? null : _sendMassage,
            icon: _isSendingMessage
                ? AnimatedBuilder(
                    animation: _animationController,
                    builder: (_, __) {
                      final value = _animationController.value;
                      final full =
                          value <= 0.33 ? '.' : (value <= 0.66 ? '..' : '...');
                      return Text("${Constants.searchingMessage}$full");
                    },
                  )
                : const Icon(Icons.send),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      
        title: const Text(Constants.botSender),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                reverse: true,
                padding: const EdgeInsets.all(8.0),
                itemCount: _massages.length,
                itemBuilder: (context, index) {
                  return _massages[index];
                },
              ),
            ),
            Container(
              child: _buildTextComposer(),
            )
          ],
        ),
      ),
    );
  }
}
