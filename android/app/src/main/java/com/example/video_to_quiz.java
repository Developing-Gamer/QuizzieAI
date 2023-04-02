List<String> questions_list = [];
List<String> optionA_list = [];
List<String> optionB_list = [];
List<String> optionC_list = [];
List<String> answers_list = [];

String result = "Question 1\rOption A 1\rOption B 1\rOption C 1\rAnswer 1\rQuestion 2\rOption A 2\rOption B 2\rOption C 2\rAnswer 2";

List<String> splitString = result.split("\r");

int n = 0;

for (String substring in splitString) {
    if (n == 0) {
        questions_list.add(substring);
        n++;
    } else if (n == 1) {
        optionA_list.add(substring);
        n++;
    } else if (n == 2) {
        optionB_list.add(substring);
        n++;
    } else if (n == 3) {
        optionC_list.add(substring);
        n++;
    } else if (n == 4) {
        answers_list.add(substring);
        n = 0;
    }
}

print(questions_list);
print(optionA_list);
print(optionB_list);
print(optionC_list);
print(answers_list);