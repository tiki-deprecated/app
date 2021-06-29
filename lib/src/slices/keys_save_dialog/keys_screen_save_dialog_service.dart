// saveImage(globalKey) async{
//   RenderRepaintBoundary renderRepaintBoundary =
//   globalKey.currentContext!.findRenderObject()
//   as RenderRepaintBoundary;
//   if (!renderRepaintBoundary.debugNeedsPaint) {
//     ui.Image image = await renderRepaintBoundary.toImage(pixelRatio: 4.0);
//     ByteData? byteData =
//     await image.toByteData(format: ui.ImageByteFormat.png);
//     Uint8List pngBytes = byteData!.buffer.asUint8List();
//     bool permission = await HelperPermission.request(Permission.storage);
//     if (permission) {
//       Directory documents;
//       if (Platform.isIOS)
//         documents = await getApplicationDocumentsDirectory();
//       else
//         documents = Directory("/storage/emulated/0/Download");
//
//       String path = documents.path + '/' + fileName;
//       File imgFile = new File(path);
//       imgFile.writeAsBytesSync(pngBytes, flush: true);
//
//     }
//   } else
//
//   }
