import 'package:flutter/material.dart';
import 'package:resizable_widget/resizable_widget.dart';

import '../settings/settings.dart';
import '../state/state.dart';
import 'base_layout.dart';

class DesktopLayout extends StatelessWidget implements BaseLayout {
  const DesktopLayout({
    super.key,
    required this.navigationBuilder,
    required this.addonsBuilder,
    required this.knobsBuilder,
    required this.argsBuilder,
    required this.workbench,
  });

  final Widget Function(BuildContext context) navigationBuilder;
  final List<Widget> Function(BuildContext context) addonsBuilder;
  final List<Widget> Function(BuildContext context) knobsBuilder;
  final List<Widget> Function(BuildContext context) argsBuilder;
  final Widget workbench;

  @override
  Widget build(BuildContext context) {
    final state = WidgetbookState.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          state.toggleFullLayoutVisibility();
        },
        tooltip: state.isFullLayoutVisible ? 'Hide Layout' : 'Show Layout',
        child: Icon(
          state.isFullLayoutVisible ? Icons.close_fullscreen : Icons.open_in_full,
        ),
      ),
      body: ColoredBox(
        key: ValueKey(state.isNext),
        color: Theme.of(context).colorScheme.surface,
        child: state.isFullLayoutVisible
            ? ResizableWidget(
          separatorSize: 2,
          percentages: [0.2, 0.6, 0.2],
          separatorColor: Colors.white24,
          children: [
            // Navigation Panel
            ExcludeSemantics(
              child: Card(
                child: navigationBuilder(context),
              ),
            ),
            // Workbench
            workbench,
            // Settings Panel
            ExcludeSemantics(
              child: Card(
                child: SettingsPanel(
                  settings: [
                    if (state.addons != null) ...{
                      SettingsPanelData(
                        name: 'Addons',
                        builder: addonsBuilder,
                      ),
                    },
                    if (state.isNext) ...{
                      SettingsPanelData(
                        name: 'Args',
                        builder: argsBuilder,
                      ),
                    } else ...{
                      SettingsPanelData(
                        name: 'Knobs',
                        builder: knobsBuilder,
                      ),
                    },
                  ],
                ),
              ),
            ),
          ],
        )
            : workbench, // Chỉ hiển thị workbench khi tắt full layout
      ),
    );
  }
}