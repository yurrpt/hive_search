import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  setUp(
    () {
      Hive.init('database');
    },
  );
  test('Sample Test', () async {
    final box = await Hive.openBox<String>('arda');

    await box.add('inanc');

    expect(box.values.first, 'arda 0');
  });

  test('Theme box', () async {
    final themeBox = await Hive.openBox<bool>('theme');
    themeBox.put('dark', true);

    expect(themeBox.get('dark'), true);
  });

  test('List Demo', () async {
    final box = await Hive.openBox<String>('arda');
    await box.clear();
    List<String> list = List.generate(10, (index) => '$index');
    await box.addAll(list);
    expect(box.values.first, '0');
  });

  test('Name Box Put', () async {
    final box = await Hive.openBox<String>('demos');

    List<MapEntry<String, String>> list = List.generate(100, (index) => MapEntry('$index - $index', 'arda $index'));
    await box.putAll(Map.fromEntries(list));
    expect(box.get('99 - 99'), 'arda 99');
  });
}
