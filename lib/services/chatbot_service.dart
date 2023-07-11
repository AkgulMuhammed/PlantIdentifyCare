import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants/constants.dart';


class ChatbotService {

Future<String> getReply(String message) async {
    try {
      final headers = {
        'Content-Type': Constants.contentType,
        'Authorization': 'Bearer ${dotenv.env['GPT_API_KEY']}',
      };

      final String prefixedMessage = Constants.promptMessage + message;

      final requestBody = json.encode({
        "model": Constants.model,
        'prompt': prefixedMessage,
        'max_tokens': Constants.maxTokens,
        'temperature': Constants.temperature,
      });

      final response = await http.post(
        Uri.parse(dotenv.env['OPEN_AI_URL']!),
        headers: headers,
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final output = utf8.decode(response.bodyBytes); 
        final responseData = json.decode(output);
        final botReply = responseData['choices'][0]['text'].trim().toString();
        return botReply;
      } else {
        print('API response status code: ${response.statusCode}');
        print('API response body: ${response.body}');
        throw Exception(Constants.apiFail);
      }
    } catch (e) {
      print(e);
      throw Exception(Constants.loadReplyFail);
    }
  }
}
