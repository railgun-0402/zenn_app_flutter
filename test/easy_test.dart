import 'package:flutter_test/flutter_test.dart';

int add(int a, int b) {
  return a + b;
}

void main() {
  test('足し算が適切に行われること。', () async {
    expect(add(1, 2), 3);
    expect(add(10, -2), 6);
  });
}