import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StoryCard extends StatefulWidget {
  final String id;
  final String content;
  final int initialUpvotes;

  const StoryCard({
    Key? key,
    required this.id,
    required this.content,
    required this.initialUpvotes,
  }) : super(key: key);

  @override
  _StoryCardState createState() => _StoryCardState();
}

class _StoryCardState extends State<StoryCard> {
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

    // Update the upvote count atomically in Firestore
    FirebaseFirestore.instance.collection('stories').doc(widget.id).update({
      'upvotes': FieldValue.increment(isUpvoted ? 1 : -1),
    }).catchError((error) {
      print('Error updating upvotes: $error');
      // Revert the state if the update fails
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
        onTap: toggleUpvote,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.brown, Colors.deepOrange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.content,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$upvotes Upvotes',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    Icon(
                      Icons.favorite_rounded,
                      color: isUpvoted ? Colors.red[400] : Colors.white,
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
