import 'package:flutter/material.dart';

class ChatMassage extends StatelessWidget {
  const ChatMassage({
    Key? key,
    required this.text,
    required this.sender,
    required this.isResponse,
  }) : super(key: key);

  final String text;
  final String sender;
  final bool isResponse;

  @override
  Widget build(BuildContext context) {
    const sharpEdge = Radius.circular(0);
    const roundedEdge = Radius.circular(16);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: isResponse ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 15.0),
            decoration: BoxDecoration(
              color: isResponse ? Colors.grey.shade200 : Colors.green.shade200,
              borderRadius: BorderRadius.only(
                topLeft: roundedEdge,
                topRight: roundedEdge,
                bottomLeft: isResponse ? sharpEdge : roundedEdge,
                bottomRight: isResponse ? roundedEdge : sharpEdge,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sender,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold, 
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(
                    text,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
