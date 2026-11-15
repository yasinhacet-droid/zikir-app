/// Ein einzelner Zikir (Dhikr) mit Text, Umschrift, Bedeutung und Zielanzahl.
class Zikir {
  const Zikir({
    required this.id,
    required this.arabic,
    required this.transliteration,
    required this.meaning,
    required this.target,
  });

  /// Eindeutige, stabile ID – wird als Speicher-Schlüssel benutzt.
  /// Nicht nachträglich ändern, sonst gehen gespeicherte Zählerstände verloren.
  final String id;

  /// Arabischer Originaltext.
  final String arabic;

  /// Lateinische Umschrift.
  final String transliteration;

  /// Deutsche Bedeutung.
  final String meaning;

  /// Zielanzahl, z. B. 33 oder 100.
  final int target;
}
