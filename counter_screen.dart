import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/zikir.dart';
import '../state/zikir_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/confirm_dialog.dart';
import '../widgets/gradient_background.dart';
import '../widgets/progress_ring.dart';
import '../widgets/vibration_toggle.dart';

/// Zähl-Ansicht. Wischen nach links/rechts wechselt den Zikir.
class CounterScreen extends StatefulWidget {
  const CounterScreen({
    super.key,
    required this.controller,
    required this.initialIndex,
  });

  final ZikirController controller;
  final int initialIndex;

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  late final PageController _pageController =
      PageController(initialPage: widget.initialIndex);
  late int _index = widget.initialIndex;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goTo(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.controller.items;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(
        title: Text('${_index + 1} / ${items.length}'),
        actions: [VibrationToggle(controller: widget.controller)],
      ),
      body: GradientBackground(
        child: SafeArea(
          child: PageView.builder(
            controller: _pageController,
            itemCount: items.length,
            onPageChanged: (index) => setState(() => _index = index),
            itemBuilder: (context, index) => _CounterPage(
              zikir: items[index],
              controller: widget.controller,
              hasNext: index < items.length - 1,
              onNext: () => _goTo(index + 1),
            ),
          ),
        ),
      ),
    );
  }
}

class _CounterPage extends StatelessWidget {
  const _CounterPage({
    required this.zikir,
    required this.controller,
    required this.hasNext,
    required this.onNext,
  });

  final Zikir zikir;
  final ZikirController controller;
  final bool hasNext;
  final VoidCallback onNext;

  Future<void> _confirmReset(BuildContext context) async {
    final confirmed = await showConfirmDialog(
      context,
      title: '${zikir.transliteration} zurücksetzen?',
      message: 'Der Zähler wird auf 0 gesetzt.',
    );
    if (confirmed) controller.reset(zikir);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final count = controller.countOf(zikir);
        final complete = controller.isComplete(zikir);

        return Column(
          children: [
            // --- Text-Bereich ---
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
              child: Column(
                children: [
                  Text(
                    zikir.arabic,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.lightGold,
                      fontSize: 34,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    zikir.transliteration,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.cream,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    zikir.meaning,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.muted, fontSize: 15),
                  ),
                ],
              ),
            ),

            // --- Tipp-Fläche mit Ring ---
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final ringSize =
                      math.min(constraints.maxWidth, constraints.maxHeight) *
                          0.85;
                  return Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: () => controller.increment(zikir),
                      splashColor: AppColors.goldBorder,
                      highlightColor: Colors.transparent,
                      child: Center(
                        child: ProgressRing(
                          size: ringSize,
                          strokeWidth: math.max(8.0, ringSize * 0.05),
                          progress: controller.progressOf(zikir),
                          child: Padding(
                            padding: EdgeInsets.all(ringSize * 0.18),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: _RingLabel(
                                count: count,
                                target: zikir.target,
                                complete: complete,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // --- Bedien-Leiste ---
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (complete && hasNext)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: FilledButton.icon(
                        onPressed: onNext,
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text('Weiter zum nächsten'),
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton.icon(
                        onPressed:
                            count > 0 ? () => controller.decrement(zikir) : null,
                        icon: const Icon(Icons.remove),
                        label: const Text('1'),
                      ),
                      OutlinedButton.icon(
                        onPressed:
                            count > 0 ? () => _confirmReset(context) : null,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Zurücksetzen'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tippen zum Zählen · Wischen für nächsten Zikir',
                    style: TextStyle(color: AppColors.muted, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _RingLabel extends StatelessWidget {
  const _RingLabel({
    required this.count,
    required this.target,
    required this.complete,
  });

  final int count;
  final int target;
  final bool complete;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$count',
          style: const TextStyle(
            color: AppColors.cream,
            fontSize: 72,
            fontWeight: FontWeight.w700,
            height: 1.0,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'von $target',
          style: const TextStyle(color: AppColors.muted, fontSize: 18),
        ),
        if (complete) ...[
          const SizedBox(height: 8),
          const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: AppColors.gold, size: 20),
              SizedBox(width: 6),
              Text(
                'Ziel erreicht',
                style: TextStyle(
                  color: AppColors.gold,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
