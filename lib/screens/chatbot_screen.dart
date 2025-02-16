import 'package:flutter/material.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:google_generative_ai/google_generative_ai.dart'; // Ensure you have the correct import for Vertex AI and LLM Chat

class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({super.key});  // Fixed constructor name to match class name

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chatbot')),  // Changed to a static title or use App.title if defined
      body: LlmChatView(
        provider: GeminiProvider(
          model: GenerativeModel(
            model: 'gemini-1.5-flash',
            apiKey: 'your-api-key', // https://aistudio.google.com/app/apikey
          ),
        ),
      ),
    );
  }
}
