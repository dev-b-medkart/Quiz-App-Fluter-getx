import 'package:get/get.dart';
import 'package:quiz_app_getx/screens/play_quiz_screen.dart';
import 'package:quiz_app_getx/services/hive_service.dart';
import 'package:quiz_app_getx/views/create_quiz_screen.dart';

import '../models/quiz_model.dart';

class HomeController extends GetxController {
  var quizzes = <Quiz>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    HiveService.init();
    loadQuizzes();
  }

  void loadQuizzes(){
    quizzes.value=HiveService.getQuizzes();
  }
  void deleteQuiz(String quizTitle){
    HiveService.deleteQuiz(quizTitle);
    loadQuizzes();
  }

  Future<void> addQuiz() async{
    Quiz? newQuiz = await Get.to(()=>const CreateQuizPage());
    if(newQuiz!=null){
      await HiveService.addQuiz(newQuiz);
      loadQuizzes();
    }

  }
  void playQuiz(Quiz quiz){
    Get.to(()=>PlayQuizPage(quiz: quiz));
  }
}
