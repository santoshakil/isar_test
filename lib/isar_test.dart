import 'package:isar/isar.dart';

import 'model.dart';

late final Isar isar;

void watchIsar() => isar.testDatas.watchLazy().listen(
    (_) async => print('Iserted ${await isar.testDatas.count()} testDatas'));

Future<void> readTest() async {
  print('Total testDatas: ${await isar.testDatas.count()}');
  //get all data which is active
  final testDatas =
      await isar.testDatas.filter().isActiveEqualTo(true).findAll();
  print('Active testDatas: ${testDatas.length}');
}

Future<void> writeTest() async {
  isar.writeTxn((isr) async {
    isr.testDatas.putAll(
      List.generate(
        10000000,
        (i) => TestData(
          id: i,
          name: 'name $i',
          age: i,
          birthday: DateTime.now(),
          isActive: i % 2 == 0,
        ),
      ),
      replaceOnConflict: true,
      saveLinks: true,
    );
  });
}
