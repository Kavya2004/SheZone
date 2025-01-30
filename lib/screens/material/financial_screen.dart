import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FinancialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Financial Independence")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSection(
              context,
              'Start Your Own Home Business',
              'Business ideas, online platforms, and essential steps to start earning from home.',
              {
                'Etsy: Start selling handmade or digital products':
                'https://www.etsy.com/',
                'Fiverr: Freelance your skills':
                'https://www.fiverr.com/',
                'Shopify: Create your online store':
                'https://www.shopify.com/',
                'Step-by-step guide to starting a home business':
                'https://www.thebalancesmb.com/how-to-start-a-home-business-2948558',
              },
            ),
            _buildSection(
              context,
              'Budgeting & Saving',
              'Simple budgeting methods, emergency funds, and saving for future security.',
              {
                '50/30/20 Budgeting Rule Explained':
                'https://www.nerdwallet.com/article/finance/50-30-20-rule',
                'YNAB: You Need a Budget App':
                'https://www.youneedabudget.com/',
                'Tips for building an emergency fund':
                'https://www.bankrate.com/banking/savings/emergency-fund/',
                'Budget calculator from NerdWallet':
                'https://www.nerdwallet.com/budget-calculator',
              },
            ),
            _buildSection(
              context,
              'Investing & Wealth Building',
              'Basics of investing, understanding stocks, and building financial security over time.',
              {
                'Investing 101 from Investopedia':
                'https://www.investopedia.com/investing-4427685',
                'Robinhood: Easy stock investing':
                'https://robinhood.com/',
                'Wealth-building strategies from Dave Ramsey':
                'https://www.ramseysolutions.com/wealth-building',
                'Stock market basics explained':
                'https://www.merrilledge.com/market-basics',
              },
            ),
            _buildSection(
              context,
              'Negotiating Salary & Asking for a Raise',
              'Tips for getting paid what you\'re worth and advocating for better compensation.',
              {
                'How to negotiate salary with confidence':
                'https://www.glassdoor.com/blog/salary-negotiation-guide/',
                'LinkedIn Learning: Salary negotiation skills':
                'https://www.linkedin.com/learning/',
                'Career Contessa: How to ask for a raise':
                'https://www.careercontessa.com/advice/how-to-ask-for-a-raise/',
                'Common salary negotiation mistakes to avoid':
                'https://www.thebalancecareers.com/salary-negotiation-mistakes-2062978',
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
