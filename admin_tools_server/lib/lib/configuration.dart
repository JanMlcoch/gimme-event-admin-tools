part of admin_tools.server_lib;

class AdminConfiguration extends aque.ConfigurationItem {
  AdminConfiguration(String fileName) : super.fromFile(fileName);

  aque.DatabaseConnectionConfiguration database;
  int port;
}
