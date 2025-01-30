import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LegalRightsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Legal Rights & Support")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSection(
              context,
              'Understanding Your Legal Rights',
              'A guide to workplace rights, domestic rights, and protections against harassment.',
              {
                'Workplace Rights & Protections (U.S. Department of Labor)':
                'https://www.dol.gov/general/topic/discrimination',
                'Protections against harassment (EEOC)':
                'https://www.eeoc.gov/harassment',
                'Tenant Rights and Protections':
                'https://www.hud.gov/topics/rental_assistance/tenantrights',
                'Know Your Rights for Immigrants (ACLU)':
                'https://www.aclu.org/know-your-rights/immigrants-rights',
              },
            ),
            _buildSection(
              context,
              'Divorce & Custody Laws',
              'Information on navigating separation, alimony, child custody, and legal aid services.',
              {
                'Divorce and Separation Guide (Legal Aid Society)':
                'https://www.lsc.gov/legal-aid-divorce-and-separation',
                'Child Custody Resources (WomensLaw.org)':
                'https://www.womenslaw.org/laws/state/child-custody',
                'Finding Legal Aid (American Bar Association)':
                'https://www.americanbar.org/groups/legal_services/flh-home/',
              },
            ),
            _buildSection(
              context,
              'Domestic Violence Support',
              'How to recognize abuse, seek legal protection, and find shelters or crisis centers.',
              {
                'National Domestic Violence Hotline':
                'https://www.thehotline.org/',
                'Signs of Abuse (National Domestic Violence Hotline)':
                'https://www.thehotline.org/identify-abuse/',
                'Finding a Domestic Violence Shelter':
                'https://www.domesticshelters.org/',
                'Protective Orders & Legal Help':
                'https://www.womenslaw.org/laws/state-restraining-orders',
              },
            ),
            _buildSection(
              context,
              'Workplace Harassment & Discrimination',
              'Steps to report misconduct and advocate for yourself legally.',
              {
                'Filing a Workplace Harassment Claim (EEOC)':
                'https://www.eeoc.gov/how-file-charge-employment-discrimination',
                'Know Your Rights: Harassment and Discrimination':
                'https://www.eeoc.gov/employees-job-applicants',
                'Guide to Reporting Sexual Harassment':
                'https://www.nsvrc.org/reporting-sexual-harassment',
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
