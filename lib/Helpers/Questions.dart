import 'package:video_to_quiz/Helpers/constants.dart';

class Question {
  final int id, answer;
  final String question;
  final List<String> options;

  Question(
      {required this.id,
      required this.question,
      required this.answer,
      required this.options});
}

List sample_data = [
  {
    "id": 1,
    "question": questions_list[0].toString(),
    "options": [
      optionA_list[0].toString(),
      optionB_list[0].toString(),
      optionC_list[0].toString()
    ],
    "answer_index": answers_list[0].trim().substring(8, 9).toUpperCase() == "A"
        ? 0
        : answers_list[0].trim().substring(8, 9).toUpperCase() == "B"
            ? 1
            : 2,
  },
  {
    "id": 2,
    "question": questions_list[1].toString(),
    "options": [
      optionA_list[1].toString(),
      optionB_list[1].toString(),
      optionC_list[1].toString()
    ],
    "answer_index": answers_list[1].trim().substring(8, 9).toUpperCase() == "A"
        ? 0
        : answers_list[1].trim().substring(8, 9).toUpperCase() == "B"
            ? 1
            : 2,
  },
  {
    "id": 3,
    "question": questions_list[2].toString(),
    "options": [
      optionA_list[2].toString(),
      optionB_list[2].toString(),
      optionC_list[2].toString()
    ],
    "answer_index": answers_list[2].trim().substring(8, 9).toUpperCase() == "A"
        ? 0
        : answers_list[2].trim().substring(8, 9).toUpperCase() == "B"
            ? 1
            : 2,
  },
  {
    "id": 4,
    "question": questions_list[3].toString(),
    "options": [
      optionA_list[3].toString(),
      optionB_list[3].toString(),
      optionC_list[3].toString()
    ],
    "answer_index": answers_list[3].trim().substring(8, 9).toUpperCase() == "A"
        ? 0
        : answers_list[3].trim().substring(8, 9).toUpperCase() == "B"
            ? 1
            : 2,
  },
  {
    "id": 5,
    "question": questions_list[4].toString(),
    "options": [
      optionA_list[4].toString(),
      optionB_list[4].toString(),
      optionC_list[4].toString()
    ],
    "answer_index": answers_list[4].trim().substring(8, 9).toUpperCase() == "A"
        ? 0
        : answers_list[4].trim().substring(8, 9).toUpperCase() == "B"
            ? 1
            : 2,
  },
  {
    "id": 6,
    "question": questions_list[5].toString(),
    "options": [
      optionA_list[5].toString(),
      optionB_list[5].toString(),
      optionC_list[5].toString()
    ],
    "answer_index": answers_list[5].trim().substring(8, 9).toUpperCase() == "A"
        ? 0
        : answers_list[5].trim().substring(8, 9).toUpperCase() == "B"
            ? 1
            : 2,
  },
  {
    "id": 7,
    "question": questions_list[6].toString(),
    "options": [
      optionA_list[6].toString(),
      optionB_list[6].toString(),
      optionC_list[6].toString()
    ],
    "answer_index": answers_list[6].trim().substring(8, 9).toUpperCase() == "A"
        ? 0
        : answers_list[6].trim().substring(8, 9).toUpperCase() == "B"
            ? 1
            : 2,
  },
  {
    "id": 8,
    "question": questions_list[7].toString(),
    "options": [
      optionA_list[7].toString(),
      optionB_list[7].toString(),
      optionC_list[7].toString()
    ],
    "answer_index": answers_list[7].trim().substring(8, 9).toUpperCase() == "A"
        ? 0
        : answers_list[7].trim().substring(8, 9).toUpperCase() == "B"
            ? 1
            : 2,
  },
  {
    "id": 9,
    "question": questions_list[8].toString(),
    "options": [
      optionA_list[8].toString(),
      optionB_list[8].toString(),
      optionC_list[8].toString()
    ],
    "answer_index": answers_list[8].trim().substring(8, 9).toUpperCase() == "A"
        ? 0
        : answers_list[8].trim().substring(8, 9).toUpperCase() == "B"
            ? 1
            : 2,
  },
  {
    "id": 10,
    "question": questions_list[9].toString(),
    "options": [
      optionA_list[9].toString(),
      optionB_list[9].toString(),
      optionC_list[9].toString()
    ],
    "answer_index": answers_list[9].trim().substring(8, 9).toUpperCase() == "A"
        ? 0
        : answers_list[9].trim().substring(8, 9).toUpperCase() == "B"
            ? 1
            : 2,
  },
];
