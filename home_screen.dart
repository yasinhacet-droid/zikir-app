import 'package:flutter/material.dart';

import '../state/zikir_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/confirm_dialog.dart';
import '../widgets/gradient_background.dart';
import '../widgets/vibration_toggle.dart';
import '../widgets/zikir_card.dart';
import 'counter_screen.dart';

/// Übersicht aller Zikir.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.controller});

  final ZikirController controller;

  Future<void> _confirmResetAll(BuildContext context) async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Alle zurücksetzen?',
      message: 'Alle Zähler werden auf 0 gesetzt.',
      confirmLabel: 'Alle zurücksetzen',
    );
    if (confirmed) controller.resetAll();
  }

  void _openCounter(BuildContext context, int index) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => CounterScreen(
          controller: controller,
          initialIndex: index,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(
        title: const Text('Zikir'),
        actions: [
          VibrationToggle(controller: controller),
          IconButton(
            tooltip: 'Alle zurücksetzen',
            icon: const Icon(Icons.restart_alt),
            onPressed: () => _confirmResetAll(context),
          ),
        ],
      ),
      body: GradientBackground(
        child: SafeArea(
          child: ListenableBuilder(
            listenable: controller,
            builder: (context, _) {
              final items = controller.items;
              return ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                itemCount: items.length + 1,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _Header(
                      total: controller.totalCount,
                      completed: controller.completedCount,
                      itemCount: items.length,
                    );
                  }
                  final zikir = items[index - 1];
                  return ZikirCard(
                    zikir: zikir,
                    count: controller.countOf(zikir),
                    progress: controller.progressOf(zikir),
                    onTap: () => _openCounter(context, index - 1),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.total,
    required this.completed,
    required this.itemCount,
  });

  final int total;
  final int completed;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 8),
      child: Column(
        children: [
          const Text(
            'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ',
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.gold,
              fontSize: 22,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _StatTile(label: 'Gesamt gezählt', value: '$total')),
              const SizedBox(width: 12),
              Expanded(
                child: _StatTile(
                  label: 'Ziel erreicht',
                  value: '$completed / $itemCount',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.cardGreen,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.goldBorder),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: AppColors.gold,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(color: AppColors.muted, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
