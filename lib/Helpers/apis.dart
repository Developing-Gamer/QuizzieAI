import 'dart:convert';

import 'package:http/http.dart' as http;

import 'separateData.dart';

String contentAsString = "";

Future<String> readTextFileFromUrl(String url) async {
  try {
    final content = await downloadTextFile(url);
    contentAsString = content.toString();
    return contentAsString;
  } catch (e) {
    throw Exception('Failed to read text file');
  }
}

Future<String> downloadTextFile(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to download text file');
  }
}

Future<void> mediumApi(String value) async {
  final Uri uri =
      Uri.parse('https://medium2.p.rapidapi.com/article/$value/content');
  String body = "";

  Map<String, String> headers = {
    'X-RapidAPI-Key': '2668f1e955msh710f346c66b6737p1b655bjsn65aa3a6f2527',
    'X-RapidAPI-Host': 'medium2.p.rapidapi.com'
  };

  await http.get(uri, headers: headers).then((response) {
    body = response.body
        .toString()
        .substring(12, response.body.toString().length - 2);
  }).catchError((error) {
    print(error);
  });

  String quiz = await chatGptInteractionAPI(body);
  separateContent(quiz);
}

Future<void> articleApi(String value) async {
  final Uri uri = Uri.parse('https://text-extract7.p.rapidapi.com/?url=$value');
  String rawText = "";

  final Map<String, String> headers = {
    'X-RapidAPI-Key': '2668f1e955msh710f346c66b6737p1b655bjsn65aa3a6f2527',
    'X-RapidAPI-Host': 'text-extract7.p.rapidapi.com',
  };

  final response = await http.get(uri, headers: headers);

  if (response.statusCode == 200) {
    final decodedBody = json.decode(response.body);
    rawText = decodedBody['raw-text'];
    print(rawText);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }

  String quiz = await chatGptInteractionAPI(rawText);
  separateContent(quiz);
}

Future<String?> youtubeApi(String userUrl) async {
  String url = "https://youtubetranscriptdownloader.p.rapidapi.com/dev";
  var response;
  Map<String, String> headers = {
    'content-type': 'application/json',
    'X-RapidAPI-Key': '8f0d0f5e59msh1674774079d6373p1ab191jsnfa32a133ebf1',
    'X-RapidAPI-Host': 'youtubetranscriptdownloader.p.rapidapi.com'
  };
  Map<String, String> data = {
    'url': userUrl,
  };

  try {
    response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(data));
  } catch (error) {
    throw Exception('Failed to download text file');
  }

  String body = bodyResponse(response.body);
  String content = await readTextFileFromUrl(body);

  return content;
}

String bodyResponse(String content) {
  String url = "";
  for (int i = 0; i < content.length - 4; i++) {
    if (content.substring(i, i + 4) == "http") {
      url = content.substring(i, content.indexOf('"', i));
      url = url.substring(0, url.length - 1);
      break;
    }
  }
  return url;
}

final List<Map<String, String>> messages = [];

Future<String> chatGptInteractionAPI(String prompt) async {
  const String apiKey = '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';

  messages.add({
    'role': 'user',
    'content':
        "Make a multiple choice quiz of 10 questions with three options and with answer key from the given content: $prompt",
  });
  try {
    final res = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": messages,
      }),
    );

    if (res.statusCode == 200) {
      String content = jsonDecode(res.body)['choices'][0]['message']['content'];
      content = content.trim();

      messages.add({
        'role': 'professor',
        'content': content,
      });
      //print(content);
      return content;
    }
    return 'An internal error occurred';
  } catch (e) {
    return e.toString();
  }
}
