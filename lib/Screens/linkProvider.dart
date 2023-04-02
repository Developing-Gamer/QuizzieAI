import 'package:flutter/material.dart';
import 'package:video_to_quiz/Helpers/apis.dart';
import 'package:video_to_quiz/Helpers/separateData.dart';
import 'quizScreen.dart';
import '../Helpers/constants.dart';

class LinkProviderScreen extends StatefulWidget {
  const LinkProviderScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LinkProviderScreenState createState() => _LinkProviderScreenState();
}

class _LinkProviderScreenState extends State<LinkProviderScreen> {
  String? _selectedType = 'article';
  bool foundMedium = false;
  TextEditingController _controller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  isMedium(String text) {
    for (int i = 0; i < text.length - "medium.com".length + 1; i++) {
      if (text.substring(i, i + "medium.com".length) == "medium.com") {
        foundMedium = true;
        break;
      }
    }
  }

  trimMedium(String text) {
    String mediumId = text.substring(text.length - 12, text.length);
    print(mediumId);
    return mediumId;
  }

  @override
  void initState() {
    just_list.clear();
    questions_list.clear();
    answers_list.clear();
    optionA_list.clear();
    optionB_list.clear();
    optionC_list.clear();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: formKey,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Insert Link to $_selectedType',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                DropdownButton<String>(
                  value: _selectedType,
                  items: <String>['article', 'video'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedType = newValue;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_selectedType == 'article') {
            isMedium(_controller.text);
            if (foundMedium) {
              print("Medium");
              await mediumApi(trimMedium(_controller.text));
            } else {
              print("Article");
              await articleApi(_controller.text);
            }
          } else {
            String? prompt = await youtubeApi(_controller.text);
            String? quiz = await chatGptInteractionAPI(prompt!);
            separateContent(quiz);
          }
          const CircularProgressIndicator();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const QuizScreen(),
            ),
          );
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
