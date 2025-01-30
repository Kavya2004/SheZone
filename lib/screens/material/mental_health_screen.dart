import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MentalHealthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mental Health & Well-Being")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSection(
              context,
              'Relaxation Techniques & Meditation',
              'Learn simple breathing exercises, mindfulness techniques, and guided meditations to reduce stress and improve focus.',
              {
                'Mindfulness Exercises (Mindful.org)':
                'https://www.mindful.org/mindfulness-how-to-do-it/',
                'Guided Meditation for Stress Relief (Headspace)':
                'https://www.headspace.com/meditation/stress',
                'Breathing Exercises for Anxiety (Verywell Mind)':
                'https://www.verywellmind.com/breathing-exercises-for-anxiety-2584091',
              },
            ),
            _buildSection(
              context,
              'Coping with Anxiety & Depression',
              'Strategies for managing mental health challenges, including journaling, therapy options, and self-care routines.',
              {
                'Managing Anxiety (Anxiety and Depression Association of America)':
                'https://adaa.org/tips',
                'Journaling for Mental Health (Healthline)':
                'https://www.healthline.com/health/benefits-of-journaling',
                'Therapy Options (BetterHelp)':
                'https://www.betterhelp.com/',
              },
            ),
            _buildSection(
              context,
              'Work-Life Balance',
              'Tips on managing time effectively, setting boundaries, and prioritizing self-care.',
              {
                'Time Management Tips (MindTools)':
                'https://www.mindtools.com/pages/article/newHTE_00.htm',
                'Setting Boundaries for Self-Care (Psychology Today)':
                'https://www.psychologytoday.com/us/blog/in-practice/201810/how-set-boundaries-and-why-you-need-them',
                'Work-Life Balance Guide (Mayo Clinic)':
                'https://www.mayoclinic.org/healthy-lifestyle/adult-health/in-depth/work-life-balance/art-20048134',
              },
            ),
            _buildSection(
              context,
              'Seeking Professional Help',
              'How to find a therapist, online counseling options, and mental health hotlines.',
              {
                'Find a Therapist (Psychology Today)':
                'https://www.psychologytoday.com/us/therapists',
                'Online Counseling (Talkspace)':
                'https://www.talkspace.com/',
                'Mental Health Hotline (SAMHSA)':
                'https://www.samhsa.gov/find-help/national-helpline',
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
