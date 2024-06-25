abstract class IClient {
  
  Future<String> fetch(String directory, [bool asBytes = false]);
}