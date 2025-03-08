import 'dart:convert';
import 'dart:io';

import 'package:cv/position.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Position can be deserialized from JSON', () {
    Position position = Position.fromJson({
      'title': 'Software Developer',
      'company': 'Company',
      'start': '2021-01-01',
      'end': '2021-12-31',
      'description': 'Description'
    });

    expect(position.title, 'Software Developer');
    expect(position.company, 'Company');
    expect(position.start, DateTime.parse('2021-01-01'));
    expect(position.end, DateTime.parse('2021-12-31'));
    expect(position.description, 'Description');
  });

  test("Position can be deserialized from JSON file", () {
    File file = File('test/resource/test-position.json');
    String json = file.readAsStringSync();
    Position position = Position.fromJson(jsonDecode(json));

    expect(position.title, 'Software Developer');
    expect(position.company, 'Company');
    expect(position.start, DateTime.parse('2021-01-01'));
    expect(position.end, DateTime.parse('2021-12-31'));
    expect(position.description, 'Description');
  });
}
