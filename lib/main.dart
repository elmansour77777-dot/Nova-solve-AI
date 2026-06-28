import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';
  bool _loading = false;
  final FlutterTts flutterTts = FlutterTts();
  final apiKey = 'YOUR_GEMINI_API_KEY'; 

  Future<void> _solve() async {
    if (_controller.text.isEmpty) return;
    setState(() { _loading = true; _result = ''; });
    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
    final response = await model.generateContent([Content.text('Solve step by step: ${_controller.text}')]);
    setState(() { _result = response.text ?? 'No result'; _loading = false; });
    await flutterTts.speak(_result);
  }

  Future<void> _scan() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final text = await TextRecognizer().processImage(InputImage.fromFilePath(image.path));
    _controller.text = text.text;
    _solve();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NovaSolve AI')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _controller, maxLines: 3, decoration: const InputDecoration(labelText: 'اكتب المسألة او صورها')),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(child: FilledButton(onPressed: _solve, child: const Text('حل بالذكاء الاصطناعي'))),
              const SizedBox(width: 8),
              FilledButton.icon(onPressed: _scan, icon: const Icon(Icons.camera_alt), label: const Text('تصوير')),
            ]),
            const SizedBox(height: 16),
            Expanded(child: _loading ? const Center(child: CircularProgressIndicator()) : SingleChildScrollView(child: Text(_result))),
          ],
        ),
      ),
    );
  }
}
