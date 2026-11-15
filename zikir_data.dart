import '../models/zikir.dart';

/// Vordefinierte Zikir.
///
/// Neuen Zikir hinzufügen: einfach einen weiteren Eintrag anhängen
/// und eine neue, eindeutige `id` vergeben.
const List<Zikir> kZikirList = [
  Zikir(
    id: 'subhanallah',
    arabic: 'سُبْحَانَ اللَّهِ',
    transliteration: 'Subhanallah',
    meaning: 'Gepriesen (erhaben) ist Allah',
    target: 33,
  ),
  Zikir(
    id: 'alhamdulillah',
    arabic: 'الْحَمْدُ لِلَّهِ',
    transliteration: 'Alhamdulillah',
    meaning: 'Alles Lob gebührt Allah',
    target: 33,
  ),
  Zikir(
    id: 'allahu_akbar',
    arabic: 'اللَّهُ أَكْبَرُ',
    transliteration: 'Allahu Akbar',
    meaning: 'Allah ist der Größte',
    target: 34,
  ),
  Zikir(
    id: 'la_ilaha_illallah',
    arabic: 'لَا إِلَهَ إِلَّا اللَّهُ',
    transliteration: 'La ilaha illallah',
    meaning: 'Es gibt keinen Gott außer Allah',
    target: 100,
  ),
  Zikir(
    id: 'astaghfirullah',
    arabic: 'أَسْتَغْفِرُ اللَّهَ',
    transliteration: 'Astaghfirullah',
    meaning: 'Ich bitte Allah um Vergebung',
    target: 100,
  ),
  Zikir(
    id: 'subhanallahi_wa_bihamdihi',
    arabic: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ',
    transliteration: 'Subhanallahi wa bihamdihi',
    meaning: 'Gepriesen ist Allah, und Ihm gebührt das Lob',
    target: 100,
  ),
  Zikir(
    id: 'la_hawla',
    arabic: 'لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ',
    transliteration: 'La hawla wa la quwwata illa billah',
    meaning: 'Es gibt keine Macht und keine Kraft außer bei Allah',
    target: 100,
  ),
  Zikir(
    id: 'salawat',
    arabic: 'اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ',
    transliteration: 'Allahumma salli ala Muhammad',
    meaning: 'O Allah, segne Muhammad',
    target: 100,
  ),
  Zikir(
    id: 'hasbunallah',
    arabic: 'حَسْبُنَا اللَّهُ وَنِعْمَ الْوَكِيلُ',
    transliteration: 'Hasbunallahu wa ni’mal wakil',
    meaning: 'Allah genügt uns, und welch vortrefflicher Beschützer ist Er',
    target: 100,
  ),
];
