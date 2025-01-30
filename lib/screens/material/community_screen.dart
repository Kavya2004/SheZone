import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Required for launching URLs

class CommunityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Community & Networking")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSection(
              context,
              'Women’s Support Groups',
              'Finding and joining online and offline communities for emotional and career support.',
              {
                'Join local women’s support groups on Meetup':
                'https://www.meetup.com/topics/women-support/',
                'Explore Facebook groups for career and emotional support':
                'https://www.facebook.com/groups/',
                'Check out Lean In Circles': 'https://leanin.org/circles',
              },
            ),
            _buildSection(
              context,
              'Mentorship & Career Growth',
              'How to find a mentor and build valuable professional connections.',
              {
                'Women Who Code Mentorship Program':
                'https://www.womenwhocode.com/mentoring',
                'Search for mentors on LinkedIn': 'https://www.linkedin.com',
                'Attend local networking events and conferences':
                'https://www.eventbrite.com/',
              },
            ),
            _buildSection(
              context,
              'Social Media for Networking',
              'Using LinkedIn, Twitter, and other platforms to expand your professional reach.',
              {
                'Optimize your LinkedIn profile':
                'https://www.linkedin.com/help/linkedin',
                'Use Twitter for professional networking':
                'https://twitter.com/explore',
                'Join professional LinkedIn groups':
                'https://www.linkedin.com/groups/',
              },
            ),
            _buildSection(
              context,
              'Volunteering & Giving Back',
              'How community involvement can enhance your skills and make a difference.',
              {
                'Volunteer with local nonprofits':
                'https://www.volunteermatch.org/',
                'Mentor young women in your community':
                'https://www.girlup.org/take-action/become-a-mentor',
                'Participate in charitable events or initiatives':
                'https://www.charitynavigator.org/',
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
