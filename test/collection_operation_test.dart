import 'package:flutter_test/flutter_test.dart';

// 指定した整数をリストに追加する
List<int> addElement(List<int> list, int element) {
  list.add(element);
  return list;
}

// 指定した整数をリストから削除する
List<int> removeElement(List<int> list, int element) {
  list.remove(element);
  return list;
}

// 指定した整数がリスト内に存在するか確認
bool containsElement(List<int> list, int element) {
  return list.contains(element);
}

void main() {
  group('整数コレクション操作テスト', () {
    List<int> testList = [];

    setUp(() {
      // 各テストケースの開始前に、testListを初期化
      testList = [1, 2, 3, 5, 7, 11, 13, 17, 19];
    });

    test('指定した整数がリストから削除されること', () async {
      List<int> result =  removeElement(testList, 2);
      expect(result.length, 8);
      expect(result.contains(2), isFalse);
    });

    test('指定した整数がリストに含まれること', () async {
      bool result = containsElement(testList, 2);
      expect(result, isTrue);
      result = containsElement(testList, 21);
      expect(result, isFalse);
    });

    test('指定した整数がリストに追加されること', () async {
      List<int> result = addElement(testList, 4);
      expect(result.length, 10);
      expect(result.contains(4), isTrue);
    });

  });
}