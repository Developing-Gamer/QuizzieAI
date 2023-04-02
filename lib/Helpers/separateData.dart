import 'constants.dart';

void separateContent(String result) {
  List<String> sections = result.split("\n");

  String answer = "";
  for (int i = 0; i < sections.length; i++) {
    answer += sections[i].trim() + ";";
  }

  List<String> lines = answer.split(";");

  int n = 0;

  for (int i = 0; i < lines.length; i++) {
    if (lines[i].isNotEmpty) {
      if (n == 0) {
        just_list.add(lines[i].trim());
      } else if (n == 1) {
        optionA_list.add(lines[i].trim());
      } else if (n == 2) {
        optionB_list.add(lines[i].trim());
      } else if (n == 3) {
        optionC_list.add(lines[i].trim());
      } else if (n == 4) {
        answers_list.add(lines[i].trim());
        n = 0;
      }
    }
  }

  for (int i = 0; i < just_list.length; i++) {
    if (i % 5 == 0) {
      questions_list.add(just_list[i]);
    } else if (i % 5 == 1) {
      optionA_list.add(just_list[i]);
    } else if (i % 5 == 2) {
      optionB_list.add(just_list[i]);
    } else if (i % 5 == 3) {
      optionC_list.add(just_list[i]);
    } else if (i % 5 == 4) {
      answers_list.add(just_list[i]);
    }
  }
}
