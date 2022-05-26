import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'isar_test.dart';
import 'model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  isar = await Isar.open(
    schemas: [TestDataSchema],
    directory: join(dir.path, 'isar_test'),
  );
  watchIsar();
  runApp(MaterialApp(
    darkTheme: ThemeData.dark(),
    home: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Read'),
              onPressed: () async => await readTest(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Write'),
              onPressed: () async => await writeTest(),
            ),
          ],
        ),
      ),
    );
  }
}
