import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'; // Add this line
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:limosquizpart2/models/restaurant.dart';
import 'package:limosquizpart2/models/reviewer.dart';
import 'package:limosquizpart2/screens/home_screen.dart';
import 'package:limosquizpart2/screens/restaurant_entry_screen.dart';
import 'package:limosquizpart2/screens/review_entry_screen.dart';
import 'package:limosquizpart2/screens/reviewer_entry_screen.dart';
import 'package:limosquizpart2/services/database_service.dart';
import 'firebase_options.dart'; // Import your Firebase options file

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await initializeFirebase();

  runApp(
    MultiProvider(
      providers: [
        StreamProvider<List<Reviewer>>(
          create: (_) => DatabaseService().getReviewers(),
          initialData: const [],
        ),
        StreamProvider<List<Restaurant>>(
          create: (_) => DatabaseService().getRestaurants(),
          initialData: const [],
        ),
      ],
      child: const MyApp(),
    ),
  );
}

Future<void> initializeFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    // Initialize Firebase for other platforms
    await Firebase.initializeApp();
  }
}
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screens = [
    const HomeScreen(),
    const ReviewEntryScreen(),
    const ReviewerEntryScreen(),
    const RestaurantEntryScreen(),
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          SalomonBottomBarItem(
            icon: Icon(Icons.home_outlined),
            title: Text('Home'),
            selectedColor: Colors.green,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.edit_outlined),
            title: Text('Add Review'),
            selectedColor: Colors.green,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.person_outline),
            title: Text('Add Reviewer'),
            selectedColor: Colors.green,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.restaurant_outlined),
            title: Text('Add Restaurant'),
            selectedColor: Colors.green,
          ),
        ],
      ),
    );
  }
}
