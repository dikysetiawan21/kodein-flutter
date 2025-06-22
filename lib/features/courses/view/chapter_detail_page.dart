import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'quiz_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChapterDetailPage extends StatefulWidget {
  final String chapterTitle;
  final String videoUrl;
  final String description;
  const ChapterDetailPage({
    super.key,
    required this.chapterTitle,
    required this.videoUrl,
    required this.description,
  });

  @override
  State<ChapterDetailPage> createState() => _ChapterDetailPageState();
}

class _ChapterDetailPageState extends State<ChapterDetailPage> {
  String? videoId;
  YoutubePlayerController? _controller;

  Map<String, dynamic>? _quizResult;

  @override
  void initState() {
    super.initState();
    videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    debugPrint('YouTube videoId: ' + (videoId ?? 'NULL'));
    if (videoId != null && videoId!.isNotEmpty) {
      _controller = YoutubePlayerController(
        initialVideoId: videoId!,
        flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
      );
    }
    _loadQuizResult();
  }

  Future<void> _loadQuizResult() async {
    final prefs = await SharedPreferences.getInstance();
    final resultStr = prefs.getString('quiz_result_${widget.chapterTitle}');
    if (resultStr != null) {
      // Parsing sederhana, lebih baik pakai jsonEncode/jsonDecode jika ingin lebih robust
      final regScore = RegExp("score: (\\d+)");
      final regTotal = RegExp("total: (\\d+)");
      final regTime = RegExp("timestamp: ([^,}]+)");
      final score = int.tryParse(regScore.firstMatch(resultStr)?.group(1) ?? '0') ?? 0;
      final total = int.tryParse(regTotal.firstMatch(resultStr)?.group(1) ?? '0') ?? 0;
      final time = regTime.firstMatch(resultStr)?.group(1) ?? '';
      setState(() {
        _quizResult = {
          'score': score,
          'total': total,
          'timestamp': time,
        };
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: Text(widget.chapterTitle),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (videoId != null && videoId!.isNotEmpty && _controller != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: YoutubePlayer(
                    controller: _controller!,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.blue,
                    progressColors: const ProgressBarColors(
                      playedColor: Colors.blue,
                      handleColor: Colors.blueAccent,
                    ),
                  ),
                )
              else
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Text(
                      'Video tidak dapat diputar',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 24),
              Text(
                widget.chapterTitle,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  widget.description,
                  style: const TextStyle(fontSize: 15, color: Colors.black87),
                ),
              ),
              const SizedBox(height: 28),
              if (_quizResult != null)
                Card(
                  color: _quizResult!["score"] == _quizResult!["total"] ? Colors.green[50] : Colors.orange[50],
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  margin: const EdgeInsets.only(bottom: 18),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                          _quizResult!["score"] == _quizResult!["total"] ? Icons.emoji_events : Icons.quiz,
                          color: _quizResult!["score"] == _quizResult!["total"] ? Colors.green : Colors.orange,
                          size: 36,
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Quiz Terakhir',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                'Skor: ${_quizResult!["score"]} / ${_quizResult!["total"]}',
                                style: TextStyle(
                                  color: _quizResult!["score"] == _quizResult!["total"] ? Colors.green : Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                'Tanggal: ${_quizResult!["timestamp"]}',
                                style: const TextStyle(fontSize: 13, color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                        if (_quizResult!["score"] == _quizResult!["total"])
                          const Chip(label: Text('Excellent!', style: TextStyle(color: Colors.green)), backgroundColor: Colors.white)
                        else if (_quizResult!["score"] > 0)
                          const Chip(label: Text('Good!', style: TextStyle(color: Colors.orange)), backgroundColor: Colors.white)
                        else
                          const Chip(label: Text('Try Again!', style: TextStyle(color: Colors.red)), backgroundColor: Colors.white),
                      ],
                    ),
                  ),
                )
              else
                Container(
                  margin: const EdgeInsets.only(bottom: 18),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline, color: Colors.blue, size: 32),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          'Belum ada hasil quiz untuk chapter ini. Yuk kerjakan quiz untuk menguji pemahamanmu!',
                          style: const TextStyle(fontSize: 15, color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                ),
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.quiz),
                  label: const Text('Quiz'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[100],
                    foregroundColor: Colors.orange[900],
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => QuizPage(chapter: widget.chapterTitle)));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// Kode quiz sudah dipindahkan ke quiz_page.dart
