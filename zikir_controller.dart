import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../models/zikir.dart';
import '../services/storage_service.dart';

/// Zentrale App-Logik: Zählerstände, Vibration, Reset.
///
/// Die Oberfläche hört über [ListenableBuilder] auf Änderungen.
class ZikirController extends ChangeNotifier {
  ZikirController({required this.storage, required this.items}) {
    for (final zikir in items) {
      _counts[zikir.id] = storage.loadCount(zikir.id);
    }
    _vibrationEnabled = storage.loadVibration();
  }

  final StorageService storage;
  final List<Zikir> items;

  final Map<String, int> _counts = {};
  bool _vibrationEnabled = true;

  bool get vibrationEnabled => _vibrationEnabled;

  int countOf(Zikir zikir) => _counts[zikir.id] ?? 0;

  /// Fortschritt 0.0 – 1.0 (über dem Ziel bleibt er bei 1.0).
  double progressOf(Zikir zikir) {
    if (zikir.target <= 0) return 0;
    final progress = countOf(zikir) / zikir.target;
    return progress > 1 ? 1.0 : progress;
  }

  bool isComplete(Zikir zikir) => countOf(zikir) >= zikir.target;

  int get totalCount => _counts.values.fold(0, (sum, value) => sum + value);

  int get completedCount => items.where(isComplete).length;

  void increment(Zikir zikir) {
    final newValue = countOf(zikir) + 1;
    _setCount(zikir, newValue);

    if (_vibrationEnabled) {
      if (newValue == zikir.target) {
        // Ziel erreicht: deutlich spürbares Feedback
        HapticFeedback.heavyImpact();
      } else {
        HapticFeedback.lightImpact();
      }
    }
  }

  void decrement(Zikir zikir) {
    final current = countOf(zikir);
    if (current > 0) _setCount(zikir, current - 1);
  }

  void reset(Zikir zikir) => _setCount(zikir, 0);

  void resetAll() {
    for (final zikir in items) {
      _counts[zikir.id] = 0;
      storage.saveCount(zikir.id, 0);
    }
    notifyListeners();
  }

  void setVibration(bool enabled) {
    _vibrationEnabled = enabled;
    storage.saveVibration(enabled);
    notifyListeners();
  }

  void _setCount(Zikir zikir, int value) {
    _counts[zikir.id] = value;
    storage.saveCount(zikir.id, value);
    notifyListeners();
  }
}
