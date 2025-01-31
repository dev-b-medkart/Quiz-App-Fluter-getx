import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app_getx/models/quiz_model.dart';
import 'package:quiz_app_getx/views/question_form_screen.dart';

class CreateQuizController extends GetxController {
  var isAutoValidActive = AutovalidateMode.disabled.obs;

  final TextEditingController numQuestionsController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    numQuestionsController.dispose();
    timeController.dispose();
    titleController.dispose();
    super.onClose();
  }

  Future<void> submitFun() async {
    if (!formKey.currentState!.validate()) {
      isAutoValidActive.value = AutovalidateMode.always;
      return;
    }
    final numQuestions = int.tryParse(numQuestionsController.text)!;
    final quizTime = int.tryParse(timeController.text)!;
    final quizTitle = titleController.text;
    final quiz = Quiz(title: quizTitle, questions: []);

    final updatedQuiz =
        Get.to(() => QuestionFormPage(quiz: quiz, numQuestions: numQuestions));

    if(updatedQuiz!=null){
      Get.back(result: updatedQuiz);
    }

  }

  void setIsAutoValidActive(var value) {
    isAutoValidActive = value;
  }
}
