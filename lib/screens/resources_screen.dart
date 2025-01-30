import 'package:flutter/material.dart';

class ResourcesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> resources = [
    {'title': 'Mental Health & Well-Being', 'icon': Icons.favorite, 'route': '/mental_health'},
    {'title': 'Legal Rights & Support', 'icon': Icons.gavel, 'route': '/legal_rights'},
    {'title': 'Financial Independence', 'icon': Icons.attach_money, 'route': '/financial'},
    {'title': 'Education & Skill Development', 'icon': Icons.school, 'route': '/education'},
    {'title': 'Community & Networking', 'icon': Icons.people, 'route': '/community'},
    {'title': 'Health & Wellness', 'icon': Icons.local_hospital, 'route': '/health'},
    {'title': 'Safety & Self-Defense', 'icon': Icons.security, 'route': '/safety'},
    {'title': 'Personal Growth & Confidence', 'icon': Icons.self_improvement, 'route': '/personality'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resources', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),),
        backgroundColor: Colors.brown[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.5,
          ),
          itemCount: resources.length,
          itemBuilder: (context, index) {
            final resource = resources[index];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, resource['route']);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        resource['title'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Icon(
                        resource['icon'],
                        size: 30,
                        color: Colors.brown[700],
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Icon(
                        Icons.arrow_forward,
                        size: 30,
                        color: Colors.brown[700],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ResourceDetailScreen extends StatelessWidget {
  final String title;
  final String imageUrl;
  final List<Map<String, String>> sections;

  ResourceDetailScreen({required this.title, required this.imageUrl, required this.sections});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.brown[100],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imageUrl, width: double.infinity, height: 200, fit: BoxFit.cover),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: sections.map((section) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(section['title']!,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text(section['description']!, style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
