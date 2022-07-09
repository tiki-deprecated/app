import 'dart:io';
import 'dart:typed_data';

import 'package:app/src/config/config_log.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider/path_provider.dart';

main(){
  test('test log rotation by date and size', ()  async {
    TestWidgetsFlutterBinding.ensureInitialized();
    String path = (await getApplicationDocumentsDirectory()).path;
    DateTime oldDate = DateTime.now().subtract(const Duration(days:16));
    String filenameOld = "${oldDate.year.toString()}${oldDate.month.toString().padLeft(2, '0')}${
    oldDate.day.toString().padLeft(2, '0')}.log";
    File file = File('$path/$filenameOld');
    file.writeAsStringSync("test log\n", mode: FileMode.append);
    String filename = "${DateTime.now().year.toString()}${DateTime.now().month.toString().padLeft(2, '0')}${
    DateTime.now().day.toString().padLeft(2, '0')}.log";
    File fileBig = File('$path/$filename');
    Uint8List bytes = Uint8List(2000000);
    fileBig.writeAsBytesSync(bytes);
    Directory dir = Directory(path);
    List<File> filesBefore = (await dir.list().toList()).whereType<File>().toList();
    expect(filesBefore.length,2);
    await ConfigLog().init();
    List<File> filesAfter = (await dir.list().toList()).whereType<File>().toList();
    expect(filesAfter.length,1);
    expect(filesAfter.first.path.endsWith(".1"),true);
  });
}