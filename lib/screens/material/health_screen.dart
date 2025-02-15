import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HealthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Safety & Self-Defense")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSection(
              context,
              'Basic Self-Defense Moves',
              'Simple techniques to protect yourself in dangerous situations.',
              {
                'Basic Self-Defense Moves (Women\'s Health)':
                'https://www.womenshealthmag.com/fitness/a19995744/basic-self-defense-moves/',
                'Self-Defense Tips (Verywell Fit)':
                'https://www.verywellfit.com/self-defense-basics-for-beginners-3498126',
              },
            ),
            _buildSection(
              context,
              'Online Safety & Digital Security',
              'Tips on protecting personal information, avoiding scams, and preventing cyberstalking.',
              {
                'Protecting Personal Info (Federal Trade Commission)':
                'https://www.consumer.ftc.gov/articles/0272-how-keep-your-personal-information-secure',
                'Avoiding Online Scams (FBI)':
                'https://www.fbi.gov/scams-and-safety/common-scams-and-crimes/internet-fraud',
                'Cyberstalking Awareness (Cyber Civil Rights Initiative)':
                'https://www.cybercivilrights.org/',
              },
            ),
            _buildSection(
              context,
              'Travel Safety Tips',
              'How to stay safe when traveling alone or in unfamiliar places.',
              {
                'Travel Safety Tips (Travel.State.Gov)':
                'https://travel.state.gov/content/travel/en/international-travel/before-you-go/travelers-checklist.html',
                'Staying Safe While Traveling (CDC)':
                'https://wwwnc.cdc.gov/travel/page/travelers-checklist',
              },
            ),
            _buildSection(
              context,
              'Emergency Contacts & Resources',
              'Important hotlines and organizations to turn to for help in crisis situations.',
              {
                'National Domestic Violence Hotline':
                'https://www.thehotline.org/',
                'RAINN (Rape, Abuse & Incest National Network)':
                'https://www.rainn.org/',
                'Crisis Text Line':
                'https://www.crisistextline.org/',
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
                              final url = Uri.parse(entry.value);  // Convert string to Uri
                              if (await canLaunchUrl(url)) {  // Use canLaunchUrl
                                await launchUrl(url);  // Use launchUrl
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
