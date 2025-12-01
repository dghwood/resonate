abstract class AbstractFile {
  AbstractFile(this.path);
  final String path;
  Future<void> openWrite();
  void write(List<int> bytes);
  Future<void> cancelWrite();
  Future<void> closeWrite();
  Future<void> delete();
}
