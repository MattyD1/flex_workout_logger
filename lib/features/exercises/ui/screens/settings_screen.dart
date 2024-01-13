import 'package:flex_workout_logger/config/theme/app_layout.dart';
import 'package:flex_workout_logger/features/exercises/ui/screens/movement_pattern_list_screen.dart';
import 'package:flex_workout_logger/utils/ui_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Settings screen
class SettingsScreen extends StatelessWidget {
  /// Constructor
  const SettingsScreen({super.key});

  /// Route name
  static const routeName = 'library';

  /// Path name
  static const routePath = 'library';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.background,
      body: CustomScrollView(
        scrollBehavior: const CupertinoScrollBehavior(),
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text(
              'More',
              style: TextStyle(color: context.colorScheme.foreground),
            ),
            backgroundColor: context.colorScheme.offBackground,
            border: null,
          ),
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              await Future<void>.delayed(const Duration(seconds: 1));
            },
          ),
          SliverToBoxAdapter(
            child: ColoredBox(
              color: context.colorScheme.offBackground,
              child: Padding(
                padding: const EdgeInsets.all(AppLayout.defaultPadding),
                child: Row(
                  children: <Widget>[
                    const Icon(
                      CupertinoIcons.person_circle_fill,
                      size: 48,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'John Doe',
                          style: TextStyle(
                            fontSize: 16,
                            color: context.colorScheme.foreground,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(
                          'Member since December 27, 2023',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: CupertinoListSection.insetGrouped(
              backgroundColor: context.colorScheme.background,
              separatorColor: context.colorScheme.divider,
              header: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'General',
                  style: TextStyle(
                    color: context.colorScheme.foreground,
                  ),
                ),
              ),
              children: <CupertinoListTile>[
                CupertinoListTile.notched(
                  backgroundColor: context.colorScheme.offBackground,
                  title: Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 16,
                      color: context.colorScheme.foreground,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  leading: const Icon(CupertinoIcons.person_fill),
                  trailing: const CupertinoListTileChevron(),
                ),
                CupertinoListTile.notched(
                  backgroundColor: context.colorScheme.offBackground,
                  title: Text(
                    'Data & Privacy',
                    style: TextStyle(
                      fontSize: 16,
                      color: context.colorScheme.foreground,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  leading: const Icon(Icons.security),
                  trailing: const CupertinoListTileChevron(),
                ),
                CupertinoListTile.notched(
                  backgroundColor: context.colorScheme.offBackground,
                  title: Text(
                    'Subscription',
                    style: TextStyle(
                      fontSize: 16,
                      color: context.colorScheme.foreground,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  leading: const Icon(Icons.credit_card),
                  trailing: const CupertinoListTileChevron(),
                ),
                CupertinoListTile.notched(
                  backgroundColor: context.colorScheme.offBackground,
                  title: Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 16,
                      color: context.colorScheme.foreground,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  leading: const Icon(Icons.lock),
                  trailing: const CupertinoListTileChevron(),
                ),
                CupertinoListTile.notched(
                  backgroundColor: context.colorScheme.offBackground,
                  title: Text(
                    'Sign Out',
                    style: TextStyle(
                      fontSize: 16,
                      color: context.colorScheme.foreground,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  leading: const Icon(Icons.logout),
                  trailing: const CupertinoListTileChevron(),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: CupertinoListSection.insetGrouped(
              backgroundColor: context.colorScheme.background,
              separatorColor: context.colorScheme.divider,
              header: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Feature Settings',
                  style: TextStyle(
                    color: context.colorScheme.foreground,
                  ),
                ),
              ),
              children: <CupertinoListTile>[
                CupertinoListTile.notched(
                  backgroundColor: context.colorScheme.offBackground,
                  title: Text(
                    'Movement Patterns',
                    style: TextStyle(
                      fontSize: 16,
                      color: context.colorScheme.foreground,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  leading: const Icon(CupertinoIcons.arrow_2_circlepath),
                  trailing: const CupertinoListTileChevron(),
                  onTap: () => context.goNamed(
                    MovementPatternListScreen.routeName,
                  ),
                ),
                CupertinoListTile.notched(
                  backgroundColor: context.colorScheme.offBackground,
                  title: Text(
                    'Muscle Groups',
                    style: TextStyle(
                      fontSize: 16,
                      color: context.colorScheme.foreground,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  leading: const Icon(CupertinoIcons.group),
                  trailing: const CupertinoListTileChevron(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
