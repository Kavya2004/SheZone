import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/material/community_screen.dart';
import 'screens/home_screen.dart';
import 'screens/write_story_screen.dart';
import 'screens/chatbot_screen.dart';
import 'screens/resources_screen.dart';
import 'screens/material/mental_health_screen.dart';
import 'screens/material/legal_rights_screen.dart';
import 'screens/material/financial_screen.dart';
import 'screens/material/education_screen.dart';
import 'screens/material/personality_screen.dart';
import 'screens/material/health_screen.dart';
import 'screens/material/safety_screen.dart';

//import 'package:google_generative_ai/google_generative_ai.dart';
//import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const StoryApp());
}

class DefaultFirebaseOptions {
  static var currentPlatform;
}

class StoryApp extends StatelessWidget {
  const StoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'She Zone',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
      ),
      home: MainScreen(),
      routes: {
        '/writeStory': (context) => WriteStoryScreen(),
        '/mental_health': (context) => MentalHealthScreen(),
        '/legal_rights': (context) => LegalRightsScreen(),
        '/financial': (context) => FinancialScreen(),
        '/education': (context) => EducationScreen(),
        '/community': (context) => CommunityScreen(),
        '/health': (context) => HealthScreen(),
        '/safety': (context) => SafetyScreen(),
        '/personality': (context) => PersonalityScreen(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    ChatbotScreen(),
    ResourcesScreen(),
    WriteStoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('Images/she.jpeg'),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.2),
                BlendMode.srcOver,
              ),
            ),
          ),
        ),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        indicatorColor: Theme.of(context).colorScheme.secondaryContainer,
        selectedIndex: _currentIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_rounded),
            label: 'Chatbot',
          ),
          NavigationDestination(
            icon: Icon(Icons.book_rounded),
            label: 'Resources',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline_rounded),
            label: 'Add Story',
          ),
        ],
      ),
    );
  }
}