import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_page_controller.dart';
import '../models/quiz_model.dart';
import 'home_screen.dart';

class QuizResult extends StatefulWidget {
  final Quiz quiz;
  final List<int> userAnswers;
  const QuizResult({super.key, required this.quiz, required this.userAnswers});


  @override
  State<QuizResult> createState() => _QuizResultState();
}

class _QuizResultState extends State<QuizResult> {
  int score = 0;
  late int numOfQuestions;

  @override
  void initState() {
    super.initState();
    numOfQuestions = widget.quiz.questions.length;
  }

  @override
  Widget build(BuildContext context) {
    final homeController=Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quiz Results',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[400],
        elevation: 2
        ,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.quiz.questions.length,
                itemBuilder: (context, index) {
                  final question = widget.quiz.questions[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Q${index + 1}: ${question.text}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Column(
                            children: question.options.asMap().entries.map((entry) {
                              final isSelected = widget.userAnswers[index] == entry.key;
                              final isCorrect = entry.key == question.correctOptionIndex;
                              return Container(
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? (isCorrect ? Colors.green[300] : Colors.red[300])
                                      : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                child: Row(
                                  children: [
                                    Icon(
                                      isCorrect
                                          ? Icons.check_circle
                                          : isSelected
                                          ? Icons.cancel
                                          : Icons.radio_button_unchecked,
                                      color: isCorrect ? Colors.green : (isSelected ? Colors.red : Colors.grey),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        entry.value,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) =>  HomePage()),
                        (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.green[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Return to Main Menu',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



