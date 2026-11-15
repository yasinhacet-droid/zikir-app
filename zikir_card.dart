import 'package:flutter/material.dart';

import '../models/zikir.dart';
import '../theme/app_theme.dart';

/// Karte in der Übersicht: Text, Umschrift, Bedeutung, Zähler, Fortschritt.
class ZikirCard extends StatelessWidget {
  const ZikirCard({
    super.key,
    required this.zikir,
    required this.count,
    required this.progress,
    required this.onTap,
  });

  final Zikir zikir;
  final int count;
  final double progress;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final complete = count >= zikir.target;
    final radius = BorderRadius.circular(20);

    return Material(
      color: AppColors.cardGreen,
      borderRadius: radius,
      child: InkWell(
        borderRadius: radius,
        onTap: onTap,
        splashColor: AppColors.goldBorder,
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(
              color: complete ? AppColors.gold : AppColors.goldBorder,
              width: complete ? 1.5 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          zikir.transliteration,
                          style: const TextStyle(
                            color: AppColors.cream,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          zikir.meaning,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.muted,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  _CountBadge(
                    count: count,
                    target: zikir.target,
                    complete: complete,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                zikir.arabic,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: AppColors.lightGold,
                  fontSize: 24,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 6,
                  backgroundColor: AppColors.track,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(AppColors.gold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CountBadge extends StatelessWidget {
  const _CountBadge({
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
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (complete)
              const Padding(
                padding: EdgeInsets.only(right: 4),
                child: Icon(Icons.check_circle, color: AppColors.gold, size: 18),
              ),
            Text(
              '$count',
              style: const TextStyle(
                color: AppColors.gold,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Text(
          '/ $target',
          style: const TextStyle(color: AppColors.muted, fontSize: 12),
        ),
      ],
    );
  }
}
