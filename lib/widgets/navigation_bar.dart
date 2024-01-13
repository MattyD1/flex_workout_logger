import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Main Bottom Navigation Bar
class MainNavigationBar extends StatelessWidget {
  /// Constructor
  const MainNavigationBar({
    required this.selectedIndex,
    required this.onItemTapped,
    required this.showToolbarModalBottomSheet,
    super.key,
  });

  /// Selected index of the navigation bar
  final int selectedIndex;

  /// Function to call when an item is tapped
  final void Function(int) onItemTapped;

  /// Function to call when the toolbar button is tapped
  final Function showToolbarModalBottomSheet;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 97,
      child: BottomAppBar(
        color: context.colorScheme.offBackground,
        padding: EdgeInsets.zero,
        elevation: 0,
        child: Container(
          height: 60,
          // width: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: context.colorScheme.divider), // Top border
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                navigationBarItems(
                  context,
                  0,
                  'Dashboard',
                  Icons.dashboard_outlined,
                  Icons.dashboard,
                ),
                navigationBarItems(
                  context,
                  1,
                  'History',
                  CupertinoIcons.clock,
                  CupertinoIcons.clock_fill,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: showToolbar(context),
                ),
                navigationBarItems(
                  context,
                  2,
                  'Library',
                  CupertinoIcons.book,
                  CupertinoIcons.book_fill,
                ), //TODO: Replace with better icon
                navigationBarItems(
                  context,
                  3,
                  'More',
                  CupertinoIcons.ellipsis_circle,
                  CupertinoIcons.ellipsis_circle_fill,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Show the toolbar modal bottom sheet
  Widget showToolbar(BuildContext context) {
    return IconButton.filled(
      icon: const Icon(CupertinoIcons.plus),
      iconSize: 24,
      // ignore: unnecessary_lambdas, avoid_dynamic_calls
      onPressed: () => showToolbarModalBottomSheet(),
      style: IconButton.styleFrom(
        padding: const EdgeInsets.all(12),
        backgroundColor: context.colorScheme.foreground,
        foregroundColor: context.colorScheme.background,
      ),
    );
  }

  /// Navigation bar items
  Widget navigationBarItems(
    BuildContext context,
    int index,
    String label,
    IconData icon,
    IconData selectedIcon,
  ) {
    /// Check if the item is selected
    bool isSelected(int index) {
      return selectedIndex == index;
    }

    return TextButton(
      onPressed: () => onItemTapped(index),
      style: TextButton.styleFrom(
        // minimumSize: const Size(48, 48), // Set a minimum size
        shape: const CircleBorder(),
        // splashFactory:
      ).copyWith(
        // Define the splash color
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return context.colorScheme.muted;
            }
            return null;
          },
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            size: 29,
            isSelected(index) ? selectedIcon : icon,
            color: isSelected(index)
                ? context.colorScheme.offForeground
                : context.colorScheme.mutedForeground,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected(index)
                  ? context.colorScheme.offForeground
                  : context.colorScheme.mutedForeground,
            ),
          ), // Reduced text size
        ],
      ),
    );
  }
}
