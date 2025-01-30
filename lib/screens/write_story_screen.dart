import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WriteStoryScreen extends StatefulWidget {
  @override
  _WriteStoryScreenState createState() => _WriteStoryScreenState();
}

class _WriteStoryScreenState extends State<WriteStoryScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isSubmitting = false;
  String _message = '';
  String _selectedCategory = '';
  bool _showErrors = false;

  final List<String> _categories = [
    '',
    'Work',
    'Education',
    'Health',
    'Finance',
    'Personal',
    'Love',
    'Relation',
    'Politics'
  ];

  bool get _isValid =>
      _controller.text.trim().isNotEmpty &&
          _selectedCategory.isNotEmpty;

  String? get _categoryError =>
      _showErrors && _selectedCategory.isEmpty
          ? 'Please select a category'
          : null;

  String? get _storyError =>
      _showErrors && _controller.text.trim().isEmpty
          ? 'Please write your story'
          : null;

  Future<void> submitStory() async {
    setState(() {
      _showErrors = true;
    });

    if (_isValid) {
      setState(() {
        _isSubmitting = true;
      });

      try {
        await FirebaseFirestore.instance.collection('stories').add({
          'content': _controller.text.trim(),
          'upvotes': 0,
          'timestamp': Timestamp.now(),
          'category': _selectedCategory,
        });

        setState(() {
          _message = 'Thank you for sharing!';
          _controller.clear();
          _isSubmitting = false;
          _selectedCategory = '';
          _showErrors = false;
        });
      } catch (e) {
        print('Error submitting story: $e');
        setState(() {
          _message = 'Failed to submit story. Please try again.';
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Write your Success Story!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22.0,
            color: Colors.brown[900],
          ),
        ),
        backgroundColor: Colors.brown[50],
        elevation: 0,
      ),
      backgroundColor: Colors.brown[50],
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 4, bottom: 8),
                  child: Text(
                    'Category',
                    style: TextStyle(
                      color: _categoryError != null ? Colors.red[700] : Colors.brown[700],
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: _categoryError != null ? 4.0 : 24.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                        color: _categoryError != null ? Colors.red[200]! : Colors.brown[200]!
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.brown.withOpacity(0.1),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      isDense: true,
                    ),
                    hint: Text(
                      'Select a category',
                      style: TextStyle(
                        color: Colors.brown[400],
                        fontSize: 16,
                      ),
                    ),
                    value: _selectedCategory.isEmpty ? null : _selectedCategory,
                    items: _categories.where((category) => category.isNotEmpty).map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(
                          category,
                          style: TextStyle(
                            color: Colors.brown[800],
                            fontSize: 16,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value!;
                      });
                    },
                    icon: Icon(Icons.arrow_drop_down,
                        color: _categoryError != null ? Colors.red : Colors.brown
                    ),
                    dropdownColor: Colors.white,
                  ),
                ),
              ],
            ),
            if (_categoryError != null)
              Padding(
                padding: EdgeInsets.only(left: 16, bottom: 24),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _categoryError!,
                    style: TextStyle(
                      color: Colors.red[700],
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                    color: _storyError != null ? Colors.red[200]! : Colors.brown[200]!
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _controller,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Write your story...',
                  hintStyle: TextStyle(
                      color: _storyError != null ? Colors.red[300] : Colors.brown[300]
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(20),
                ),
                onChanged: (value) {
                  if (_showErrors) {
                    setState(() {});
                  }
                },
              ),
            ),
            if (_storyError != null)
              Padding(
                padding: EdgeInsets.only(left: 16, top: 4),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _storyError!,
                    style: TextStyle(
                      color: Colors.red[700],
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isSubmitting ? null : submitStory,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[600],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Text(
                    _isSubmitting ? "Submitted" : 'Submit Story',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            if (_message.isNotEmpty)
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green[100]!),
                ),
                child: Text(
                  _message,
                  style: TextStyle(
                    color: Colors.green[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}