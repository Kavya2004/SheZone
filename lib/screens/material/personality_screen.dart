import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PersonalityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Personal Growth & Confidence")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSection(
              context,
              'Building Self-Confidence',
              'Practical ways to boost self-esteem, overcome self-doubt, and embrace your strengths.',
              {
                '10 Tips to Boost Confidence (Psychology Today)':
                'https://www.psychologytoday.com/us/blog/finding-the-next-level/202007/10-simple-strategies-boost-confidence',
                'Overcoming Self-Doubt (Verywell Mind)':
                'https://www.verywellmind.com/how-to-overcome-self-doubt-5075360',
                'Embracing Your Strengths (MindTools)':
                'https://www.mindtools.com/pages/article/personal-strengths.htm',
              },
            ),
            _buildSection(
              context,
              'Setting & Achieving Goals',
              'How to set realistic goals, stay motivated, and track progress.',
              {
                'SMART Goal Setting (MindTools)':
                'https://www.mindtools.com/pages/article/smart-goals.htm',
                'Staying Motivated (Forbes)':
                'https://www.forbes.com/sites/julesschroeder/2017/05/11/5-tips-to-stay-motivated/',
                'Goal Tracking Tools (Lifehack)':
                'https://www.lifehack.org/articles/productivity/10-best-goal-tracking-apps.html',
              },
            ),
            _buildSection(
              context,
              'Time Management & Productivity',
              'Effective strategies to maximize your time and balance priorities.',
              {
                'Time Blocking Techniques (Forbes)':
                'https://www.forbes.com/sites/forbescoachescouncil/2020/09/29/how-to-use-time-blocking/',
                'Pomodoro Method (Todoist)':
                'https://todoist.com/productivity-methods/pomodoro-technique',
                'Balancing Priorities (Harvard Business Review)':
                'https://hbr.org/2018/12/how-to-prioritize-your-work-when-everything-seems-important',
              },
            ),
            _buildSection(
              context,
              'Public Speaking & Communication',
              'Tips for speaking with confidence, whether in meetings, interviews, or social settings.',
              {
                'Public Speaking Tips (Toastmasters)':
                'https://www.toastmasters.org/resources/public-speaking-tips',
                'Interview Confidence (Indeed)':
                'https://www.indeed.com/career-advice/interviewing/how-to-gain-confidence-for-interview',
                'Effective Communication Skills (MindTools)':
                'https://www.mindtools.com/pages/article/newCS_99.htm',
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
