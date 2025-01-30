import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _sortBy = 'upvotes';
  Set<String> _selectedCategories = {};
  final List<String> _allCategories = ['Work', 'Education', 'Health', 'Finance', 'Personal', 'Love', 'Relation', 'Politics'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Explore Stories',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.brown[100],
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(
              _sortBy == 'upvotes'
                  ? Icons.trending_up
                  : Icons.access_time,
            ),
            onPressed: () {
              setState(() {
                if (_sortBy == 'upvotes') {
                  _sortBy = 'timestamp';
                } else {
                  _sortBy = 'upvotes';
                }
              });
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FilterChip(
                  label: Text('All'),
                  selected: _selectedCategories.isEmpty,
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedCategories.clear();
                    });
                  },
                ),
                ..._allCategories.map((category) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: FilterChip(
                    label: Text(category),
                    selected: _selectedCategories.contains(category),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          _selectedCategories.add(category);
                        } else {
                          _selectedCategories.remove(category);
                        }
                      });
                    },
                  ),
                )).toList(),
              ],
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('stories')
            .orderBy(_sortBy == 'category' ? 'timestamp' : _sortBy, descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
          if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) return Center(child: Text('No stories available'));

          List<DocumentSnapshot> stories = snapshot.data!.docs;

          // Filter stories based on selected categories
          if (_selectedCategories.isNotEmpty) {
            stories = stories.where((story) {
              String? category = (story.data() as Map<String, dynamic>?)?['category'];
              return category != null && _selectedCategories.contains(category);
            }).toList();
          }

          if (_sortBy == 'category') {
            stories.sort((a, b) {
              String categoryA = (a.data() as Map<String, dynamic>?)?['category'] ?? 'Uncategorized';
              String categoryB = (b.data() as Map<String, dynamic>?)?['category'] ?? 'Uncategorized';
              return categoryA.compareTo(categoryB);
            });
          }

          return ListView.builder(
            itemCount: stories.length,
            padding: EdgeInsets.symmetric(vertical: 20),
            itemBuilder: (context, index) {
              final story = stories[index];
              return ExpandableStoryCard(
                id: story.id,
                content: story['content'],
                initialUpvotes: story['upvotes'],
                category: (story.data() as Map<String, dynamic>?)?.containsKey('category') == true ? story['category'] : null,
              );
            },
          );
        },
      ),
    );
  }
}

class ExpandableStoryCard extends StatefulWidget {
  final String id;
  final String content;
  final int initialUpvotes;
  final String? category;

  const ExpandableStoryCard({
    Key? key,
    required this.id,
    required this.content,
    required this.initialUpvotes,
    this.category,
  }) : super(key: key);

  @override
  _ExpandableStoryCardState createState() => _ExpandableStoryCardState();
}

class _ExpandableStoryCardState extends State<ExpandableStoryCard> {
  bool _expanded = false;
  late int upvotes;
  bool isUpvoted = false;

  @override
  void initState() {
    super.initState();
    upvotes = widget.initialUpvotes;
  }

  void toggleUpvote() {
    setState(() {
      if (isUpvoted) {
        upvotes--;
        isUpvoted = false;
      } else {
        upvotes++;
        isUpvoted = true;
      }
    });

    FirebaseFirestore.instance.collection('stories').doc(widget.id).update({
      'upvotes': FieldValue.increment(isUpvoted ? 1 : -1),
    }).catchError((error) {
      print('Error updating upvotes: $error');
      setState(() {
        upvotes = isUpvoted ? upvotes - 1 : upvotes + 1;
        isUpvoted = !isUpvoted;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          setState(() {
            _expanded = !_expanded;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.brown[400],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.content,
                  maxLines: _expanded ? null : 2,
                  overflow: _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                if (widget.category != null)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      widget.category!,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$upvotes Upvotes',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    GestureDetector(
                      onTap: toggleUpvote,
                      child: Icon(
                        Icons.favorite_rounded,
                        color: isUpvoted ? Colors.red[900] : Colors.white,
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
  }
}
