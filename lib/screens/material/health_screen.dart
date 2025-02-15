import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HealthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Health & Wellness")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSection(
              context,
              'Nutrition & Healthy Eating',
              'Meal planning tips, healthy recipes, and essential nutrients for women.',
              {
                'Healthy Eating Plate by Harvard T.H. Chan School of Public Health':
                'https://www.hsph.harvard.edu/nutritionsource/healthy-eating-plate/',
                'MyFitnessPal: Meal planning and tracking':
                'https://www.myfitnesspal.com/',
                'Simple healthy recipes from BBC Good Food':
                'https://www.bbcgoodfood.com/recipes/collection/healthy-recipes',
                'Essential nutrients every woman needs':
                'https://www.webmd.com/diet/features/essential-nutrients-women',
              },
            ),
            _buildSection(
              context,
              'Exercise & Fitness',
              'Simple home workouts, yoga, and strength training routines.',
              {
                'Nike Training Club: Free workouts for all fitness levels':
                'https://www.nike.com/ntc-app',
                'Yoga With Adriene (YouTube channel)':
                'https://www.youtube.com/user/yogawithadriene',
                'Strength training guide for women from SELF':
                'https://www.self.com/story/strength-training-guide',
                '7-Minute Workout by the American College of Sports Medicine':
                'https://well.blogs.nytimes.com/2013/05/09/the-scientific-7-minute-workout/',
              },
            ),
            _buildSection(
              context,
              'Reproductive Health & Family Planning',
              'Understanding menstrual health, contraception options, and fertility tips.',
              {
                'Menstrual health guide from Planned Parenthood':
                'https://www.plannedparenthood.org/learn/health-and-wellness/menstruation',
                'Birth control options explained':
                'https://www.plannedparenthood.org/learn/birth-control',
                'Understanding fertility and ovulation':
                'https://www.healthline.com/health/how-to-track-ovulation',
                'PCOS and reproductive health resources':
                'https://www.pcosaa.org/pcos-awareness/',
              },
            ),
            _buildSection(
              context,
              'Managing Chronic Conditions',
              'Coping strategies for conditions like PCOS, endometriosis, and autoimmune diseases.',
              {
                'Living with PCOS: Tips from the Mayo Clinic':
                'https://www.mayoclinic.org/diseases-conditions/pcos/symptoms-causes/syc-20353439',
                'Endometriosis: Support and treatment options':
                'https://www.endofound.org/',
                'Managing autoimmune diseases (Cleveland Clinic)':
                'https://my.clevelandclinic.org/health/diseases/22372-autoimmune-disease',
                'Chronic condition self-management tips':
                'https://www.cdc.gov/chronicdisease/resources/publications/factsheets/self-management.htm',
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
                              final url = entry.value;
                              if (await canLaunch(url)) {
                                await launch(url);
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
