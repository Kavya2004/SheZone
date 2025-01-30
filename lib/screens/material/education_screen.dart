import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EducationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Education & Skill Development")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSection(
              context,
              'How Do I Code?',
              'Beginner-friendly coding resources and free platforms to get started.',
              {
                'FreeCodeCamp: Learn to code interactively':
                'https://www.freecodecamp.org/',
                'Codecademy: Interactive coding courses':
                'https://www.codecademy.com/',
                'W3Schools: Web development tutorials':
                'https://www.w3schools.com/',
              },
            ),
            _buildSection(
              context,
              'Online Learning Platforms',
              'The best websites for free and paid courses in various fields.',
              {
                'Coursera: Courses from top universities':
                'https://www.coursera.org/',
                'edX: Free courses from leading institutions':
                'https://www.edx.org/',
                'Udemy: Affordable courses in various fields':
                'https://www.udemy.com/',
                'Khan Academy: Free education for all':
                'https://www.khanacademy.org/',
              },
            ),
            _buildSection(
              context,
              'Resume Building & Job Readiness',
              'Crafting a strong resume, preparing for interviews, and enhancing employability skills.',
              {
                'Resume building tips from Indeed':
                'https://www.indeed.com/career-advice/resumes-cover-letters',
                'LinkedIn Learning: Job readiness courses':
                'https://www.linkedin.com/learning/',
                'Glassdoor: Interview preparation resources':
                'https://www.glassdoor.com/',
              },
            ),
            _buildSection(
              context,
              'Career Change & Upskilling',
              'How to pivot careers and gain new qualifications for better job opportunities.',
              {
                'Career change advice from The Muse':
                'https://www.themuse.com/advice/career-change',
                'Google Career Certificates':
                'https://grow.google/certificates/',
                'Skillshare: Learn creative and business skills':
                'https://www.skillshare.com/',
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String description, Map<String, String> resources) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: resources.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        Icon(Icons.circle, size: 6, color: Colors.blue),
                        SizedBox(width: 8),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              final url = Uri.parse(entry.value);
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Unable to open link")),
                                );
                              }
                            },
                            child: Text(
                              entry.key,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
