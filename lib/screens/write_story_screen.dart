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
  bool _isDropdownOpen = false;

  final List<String> _categories = [
    'Work', 'Education', 'Health', 'Finance', 'Personal', 'Love', 'Relation', 'Politics'
  ];

  bool get _isValid =>
      _controller.text.trim().isNotEmpty && _selectedCategory.isNotEmpty;

  String? get _categoryError => _showErrors && _selectedCategory.isEmpty
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
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Category',
                  style: TextStyle(
                    color: _categoryError != null ? Colors.red[700] : Colors.brown[700],
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isDropdownOpen = !_isDropdownOpen;
                    });
                  },
                  child: Container(
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
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedCategory.isNotEmpty ? _selectedCategory : 'Select a category',
                          style: TextStyle(
                            color: _selectedCategory.isNotEmpty ? Colors.black : Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: _isDropdownOpen ? 200 : 24), // Space for dropdown
                if (_categoryError != null)
                  Padding(
                    padding: EdgeInsets.only(left: 16, top: 4),
                    child: Text(
                      _categoryError!,
                      style: TextStyle(
                        color: Colors.red[700],
                        fontSize: 12,
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
                    child: Text(
                      _storyError!,
                      style: TextStyle(
                        color: Colors.red[700],
                        fontSize: 12,
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
                        _isSubmitting ? "Submitting..." : 'Submit Story',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                if (_message.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Container(
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
                  ),
              ],
            ),
          ),
          if (_isDropdownOpen)
            Positioned(
              top: 100, // Adjust this value to position the dropdown correctly
              left: 16,
              right: 16,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: _categories.map((category) => ListTile(
                    title: Text(category),
                    onTap: () {
                      setState(() {
                        _selectedCategory = category;
                        _isDropdownOpen = false;
                      });
                    },
                  )).toList(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
