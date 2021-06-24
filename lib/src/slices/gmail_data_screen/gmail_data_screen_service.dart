_launchUrl(String url) async {
  await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}

_shareCard({required String message, required String image}) async {
  bool permission = await HelperPermission.request(Permission.storage);
  if (permission) {
    ByteData? bytes = await rootBundle.load("res/images/$image");
    var buffer = bytes.buffer;
    Uint8List pngBytes = buffer.asUint8List();
    Directory directory;
    if (Platform.isIOS)
      directory = await getApplicationDocumentsDirectory();
    else
      directory = (await getExternalStorageDirectory())!;
    String path = directory.path + '/tikishare.png';
    File imgFile = new File(path);

    imgFile.writeAsBytesSync(pngBytes, flush: true);
    Share.shareFiles(
      [path],
      text: message,
    );
  }
}
