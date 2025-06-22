import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizPage extends StatefulWidget {
  final String chapter;
  const QuizPage({super.key, required this.chapter});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // Soal quiz: khusus pengenalan UI/UX
  final List<Map<String, dynamic>> _questions = [
    {
      'q': 'Apa itu UI dalam UI/UX?',
      'options': ['User Interface', 'User Interaction', 'Unique Idea', 'Usability Index'],
      'answer': 0,
    },
    {
      'q': 'Apa tujuan utama dari UX Design?',
      'options': [
        'Mempercantik tampilan',
        'Meningkatkan pengalaman pengguna',
        'Menambah animasi',
        'Mempercepat loading website'
      ],
      'answer': 1,
    },
    {
      'q': 'Manakah tools populer untuk desain UI/UX?',
      'options': ['Microsoft Word', 'Figma', 'Excel', 'Notepad'],
      'answer': 1,
    },
  ];

  final List<int?> _selected = [null, null, null];
  bool _submitted = false;
  int _score = 0;

  void _submit() async {
    int score = 0;
    for (int i = 0; i < _questions.length; i++) {
      if (_selected[i] == _questions[i]['answer']) score++;
    }
    setState(() {
      _submitted = true;
      _score = score;
    });
    // Simpan hasil quiz ke SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final result = {
      'score': score,
      'total': _questions.length,
      'timestamp': now.toIso8601String(),
      'answers': _selected,
    };
    await prefs.setString('quiz_result_${widget.chapter}', result.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz: ${widget.chapter}'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                'Jawab pertanyaan berikut tentang pengenalan UI/UX:',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 18),
              ...List.generate(_questions.length, (idx) {
                final q = _questions[idx];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Soal ${idx + 1}: ${q['q']}', style: const TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    ...List.generate(q['options'].length, (optIdx) {
                      final isCorrect = _submitted && optIdx == q['answer'];
                      final isWrong = _submitted && _selected[idx] == optIdx && optIdx != q['answer'];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        decoration: BoxDecoration(
                          color: isCorrect
                              ? Colors.green[100]
                              : isWrong
                                  ? Colors.red[100]
                                  : null,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isCorrect
                                ? Colors.green
                                : isWrong
                                    ? Colors.red
                                    : Colors.grey[300]!,
                          ),
                        ),
                        child: RadioListTile<int>(
                          value: optIdx,
                          groupValue: _selected[idx],
                          onChanged: _submitted
                              ? null
                              : (val) {
                                  setState(() {
                                    _selected[idx] = val;
                                  });
                                },
                          title: Text(q['options'][optIdx]),
                        ),
                      );
                    }),
                    const SizedBox(height: 16),
                  ],
                );
              }),
              if (_submitted)
                Center(
                  child: Text(
                    'Skor Anda: $_score / ${_questions.length}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _score == _questions.length ? Colors.green : Colors.orange,
                    ),
                  ),
                ),
              const SizedBox(height: 18),
              Center(
                child: _submitted
                    ? ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Kembali'),
                      )
                    : ElevatedButton(
                        onPressed: _selected.every((e) => e != null) ? _submit : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[100],
                          foregroundColor: Colors.orange[900],
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text('Submit'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}