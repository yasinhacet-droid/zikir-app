import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zikir_app/data/zikir_data.dart';
import 'package:zikir_app/services/storage_service.dart';
import 'package:zikir_app/state/zikir_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<ZikirController> createController() async {
    final storage = await StorageService.create();
    final controller = ZikirController(storage: storage, items: kZikirList);
    controller.setVibration(false);
    return controller;
  }

  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('Tippen erhöht, Minus verringert', () async {
    final c = await createController();
    final z = kZikirList.first;
    c.increment(z);
    c.increment(z);
    c.decrement(z);
    expect(c.countOf(z), 1);
  });

  test('Fortschritt bleibt bei 100 % gedeckelt', () async {
    final c = await createController();
    final z = kZikirList.first;
    for (var i = 0; i < z.target + 5; i++) {
      c.increment(z);
    }
    expect(c.progressOf(z), 1.0);
    expect(c.isComplete(z), isTrue);
  });

  test('Zählerstand bleibt nach Neustart erhalten', () async {
    final z = kZikirList.first;
    final first = await createController();
    first.increment(z);
    first.increment(z);

    final second = await createController();
    expect(second.countOf(z), 2);
  });

  test('Alle zurücksetzen', () async {
    final c = await createController();
    for (final z in kZikirList) {
      c.increment(z);
    }
    c.resetAll();
    expect(c.totalCount, 0);
  });
}
