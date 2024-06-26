abstract interface class ISettings {
  void open();

  void close();

  void clear();

  void put(String key, Object object);
}