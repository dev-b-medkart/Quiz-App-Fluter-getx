import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quiz_app_getx/controllers/home_page_controller.dart';
import '../services/hive_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
final controller=Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Quizzes')),
        actions: [
          IconButton(
            onPressed:
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Quiz>('quizzes').listenable(),
        builder: (context, Box<Quiz> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text("No Quizzes Created"));
          }

          final quizzes = box.values.toList();

          return ListView.builder(
            itemCount: quizzes.length,
            itemBuilder: (context, index) {
              final quiz = quizzes[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PlayQuizPage(quiz: quiz)),
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    elevation: 4,
                    color: const Color(0xFFF3F4F6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                      child: Row(
                        children: [
                          // Quiz Icon
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: const Color(0xFF57955C).withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.quiz, color: Color(0xFF57955C), size: 36),
                          ),
                          const SizedBox(width: 16),

                          // Quiz Title
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  quiz.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF2C2C2C),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${quiz.questions.length} Questions',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF8E8E8E),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Action Buttons
                          Row(
                            children: [
                              Tooltip(
                                message: "Play Quiz",
                                child: InkWell(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => PlayQuizPage(quiz: quiz)),
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                  splashColor: Colors.greenAccent.withOpacity(0.2),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF57955C).withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.play_arrow, color: Color(0xFF57955C), size: 30),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Tooltip(
                                message: "Delete Quiz",
                                child: InkWell(
                                  onTap: () => deleteQuiz(quiz.title),
                                  borderRadius: BorderRadius.circular(50),
                                  splashColor: Colors.redAccent.withOpacity(0.2),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFC84F4F).withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.delete, color: Color(0xFFC84F4F), size: 28),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

}
