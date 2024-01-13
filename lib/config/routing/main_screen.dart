import 'package:flex_workout_logger/features/exercises/ui/screens/library_screen.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flex_workout_logger/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';

/// Main Navigation Screen
class MainNavigation extends StatefulWidget {
  /// Constructor
  const MainNavigation({super.key});

  @override
  MainNavigationState createState() => MainNavigationState();
}

/// State of the MainNavigation widget
class MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showToolbarModalBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return const Scaffold(); // Replace with your toolbar widget
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          Scaffold(
            backgroundColor: context.colorScheme.background,
          ),
          Scaffold(
            backgroundColor: context.colorScheme.background,
          ),
          const LibraryScreen(),
          Scaffold(
            backgroundColor: context.colorScheme.background,
          ),
        ],
      ),
      bottomNavigationBar: MainNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        showToolbarModalBottomSheet: () =>
            _showToolbarModalBottomSheet(context),
      ),
    );
  }
}
