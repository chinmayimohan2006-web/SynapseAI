import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

void main() {
  runApp(const FairGuardApp());
}

class FairGuardApp extends StatelessWidget {
  const FairGuardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FairGuard AI',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _report = "Click the button to generate a sample bias report using Gemini.";
  bool _isLoading = false;

  // Put your Gemini API key here (get it from https://aistudio.google.com/app/apikey)
  final String apiKey = "AIzaSyAtlOq21p-4o0bTl4sxX2vvaYm4eYZ9nJs ";   // ←←← CHANGE THIS

  Future<void> _generateBiasReport() async {
    setState(() => _isLoading = true);

    try {
      final model = GenerativeModel(
        model: 'gemini-2.5-flash',
        apiKey: apiKey,
      );

      const prompt = '''
You are an expert Responsible AI auditor for FairGuard AI.

Analyze this mock loan approval dataset for bias:

Dataset: 5000 records
Target: Loan Approved (Yes/No)
Sensitive attributes: Gender (Male/Female), Region (Urban/Rural)

Fairness Metrics:
- Demographic Parity Difference: 0.28
- Disparate Impact: 0.61
- Equalized Odds Difference: 0.19

Write a clean, professional, easy-to-understand bias audit report in plain English.
Structure:
1. Executive Summary (Fairness Score /10)
2. Key Findings
3. Real-world Impact (with Indian context - hiring or loan bias)
4. 3 Recommended Actions

Keep under 350 words.
''';

      final response = await model.generateContent([Content.text(prompt)]);

      setState(() {
        _report = response.text ?? "No response from Gemini.";
      });
    } catch (e) {
      setState(() {
        _report = "Error: $e\n\nMake sure you have added a valid Gemini API key.";
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FairGuard AI - Bias Auditor')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Detecting Bias in Automated Decisions', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),

            Center(
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _generateBiasReport,
                icon: const Icon(Icons.analytics),
                label: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Generate Bias Report with Gemini'),
              ),
            ),

            const SizedBox(height: 40),
            const Text('Gemini AI Report:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_report, style: const TextStyle(fontSize: 16, height: 1.6)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}