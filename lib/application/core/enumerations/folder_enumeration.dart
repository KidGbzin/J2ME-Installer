enum Folder {
  audios("Audios"),
  covers("Covers"),
  icons("Icons"),
  midlets("MIDlets");

  final String _root;

  const Folder(this._root);

  String file({
    required String file,
    String? subfolder,
  }) {
    final String directory;
    if (_root == Folder.midlets._root) {
      assert(subfolder != null, "MIDlets must have a subfolder declared!");
      subfolder = subfolder!.replaceAll(":", " -");
      directory = "$_root/$subfolder/$file";
    }
    else {
      file = file.replaceAll(":", " -");
      directory = "$_root/$file";
    }
    return directory;
  }

  String directory({
    String? subfolder,
  }) {
    final String directory;
    if (_root == Folder.midlets._root) {
      assert(subfolder != null, "MIDlets must have a subfolder declared!");
      subfolder = subfolder!.replaceAll(':', ' -');
      directory = "$_root/$subfolder";
    }
    else {
      directory = _root;
    }
    return directory;
  }
}