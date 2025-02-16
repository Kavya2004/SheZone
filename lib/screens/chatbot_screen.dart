import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({Key? key}) : super(key: key);

  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  String _currentMood = '';
  String _selectedCategory = '';
  bool? _wantQuote;
  String _quote = '';
  final TextEditingController _questionController = TextEditingController();
  final GenerativeModel _model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: 'API',
  );

  final List<String> _moods = ['😊 Happy', '🤗 Warm', '😴 Tired', '😠 Angry', '😎 Cool', '😟 Worried', '😰 Anxious', '😢 Sad'];
  final List<String> _categories = ['💼 Work', '🎓 Education', '🏥 Health', '💰Finance', '🌱 Personal', '❤️Love', '👥 Relation', '🌍 Politics'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SHE Bot', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.brown[100],
        foregroundColor: Colors.black,
        leading: _currentMood.isNotEmpty ? IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.brown[800]),
          onPressed: () => setState(() {
            if (_quote.isNotEmpty) {
              _quote = '';
              _wantQuote = null;
            }
            else if (_wantQuote != null) _wantQuote = null;
            else if (_selectedCategory.isNotEmpty) _selectedCategory = '';
            else _currentMood = '';
          }),
        ) : null,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - AppBar().preferredSize.height,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _currentMood.isEmpty
                      ? _buildMoodSelector()
                      : _selectedCategory.isEmpty
                      ? _buildCategorySelector()
                      : _wantQuote == null
                      ? _buildQuoteOrQuestionSelector()
                      : _wantQuote!
                      ? _buildSuccessQuote()
                      : _buildCustomQuestion(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMoodSelector() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('How are you feeling today?',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.brown[700]),
        ),
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        Wrap(
          spacing: 30,
          runSpacing: 30,
          children: _moods.map((mood) => ElevatedButton(
            child: Text(mood, style: TextStyle(fontSize: 24)),
            onPressed: () => setState(() => _currentMood = mood),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown[100],
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildCategorySelector() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Choose a category:',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.brown[700]),
        ),
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        Wrap(
          spacing: 30,
          runSpacing: 30,
          children: _categories.map((category) => ElevatedButton(
            child: Text(category, style: TextStyle(fontSize: 22)),
            onPressed: () => setState(() => _selectedCategory = category),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown[100],
              padding: EdgeInsets.symmetric(horizontal: 26, vertical: 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildQuoteOrQuestionSelector() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('What would you like?',
          style : TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.brown[700]),
        ),
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        ElevatedButton.icon(
          icon: Icon(Icons.format_quote, size: 30),
          label: Text('Success Quote', style: TextStyle(fontSize: 22)),
          onPressed: () => setState(() => _wantQuote = true),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown[50],
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        ElevatedButton.icon(
          icon: Icon(Icons.question_answer, size: 30),
          label: Text('Ask a Question', style: TextStyle(fontSize: 22),),
          onPressed: () => setState(() => _wantQuote = false),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown[50],
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessQuote() {
    if (_quote.isEmpty) {
      _getSuccessQuote();
      return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.brown)));
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.lightbulb, size: 60, color: Colors.yellow[600]),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        Text(
          'Your Success Quote:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.purple.withOpacity(0.2), blurRadius: 10, offset: Offset(0, 5))],
          ),
          child: Text(
            _quote,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0, color: Colors.brown[600]),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }
  Widget _buildCustomQuestion() {
    return Column(
      children: [
        TextField(
          controller: _questionController,
          decoration: InputDecoration(
            hintText: 'Type your question here...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            filled: true,
            fillColor: Colors.white.withOpacity(0.8),
          ),
          maxLines: 3,
        ),
        SizedBox(height: 20),
        ElevatedButton.icon(
          icon: Icon(Icons.send, size: 24),
          label: Text('Ask', style: TextStyle(fontSize: 20)),
          onPressed: _askQuestion,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown[200],
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
        if (_quote.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.purple.withOpacity(0.2), blurRadius: 10, offset: Offset(0, 5))],
              ),
              child: Text(
                _quote,
                style: TextStyle(fontSize: 18, color: Colors.brown[800]),
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _getSuccessQuote() async {
    final prompt = "Give me a short, inspiring success quote related to $_selectedCategory to lift someone's $_currentMood mood. Only provide the quote, no additional text.";
    final content = [Content.text(prompt)];
    final response = await _model.generateContent(content);
    setState(() {
      _quote = response.text ?? "Unable to generate a quote at this time.";
    });
  }

  Future<void> _askQuestion() async {
    final prompt = _questionController.text;
    final content = [Content.text(prompt)];
    final response = await _model.generateContent(content);
    setState(() {
      _quote = response.text ?? "Unable to generate a response at this time.";
    });
  }

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }
}
