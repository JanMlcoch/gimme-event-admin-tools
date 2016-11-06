part of admin_tools.server_lib;

class AdminSink extends aque.RequestSink {
  static const String ConfigurationKey = "ConfigurationKey";
  static const String LoggingTargetKey = "LoggingTargetKey";

  aque.ManagedContext context;
  aque.AuthServer<User, Token, AuthCode> authenticationServer;
  AdminConfiguration configuration;

  AdminSink(Map<String, dynamic> options) : super(options) {
    configuration = options[ConfigurationKey];
    aque.Logger.root.level = aque.Level.FINE;

    LoggingTarget target = options[LoggingTargetKey];
    target?.bind(logger);

    context = contextWithConnectionInfo(configuration.database);

    authenticationServer = new aque.AuthServer<User, Token, AuthCode>(new AdminAuthenticationDelegate());
  }

  @override
  void setupRouter(aque.Router router) {
    aque.Router authRouter = new aque.Router()
      ..route("/login")
          .pipe(new aque.Authorizer(authenticationServer, strategy: aque.AuthStrategy.client))
          .generate(() => new LoginController())
      ..route("/logout").pipe(new aque.Authorizer(authenticationServer)).generate(() => new LogoutController());
    aque.Router tagMasterRouter = new aque.Router();
    aque.Router accountManagerRouter = new aque.Router();

    router.route("/api").pipe(new aque.Router()
      ..route("/auth").pipe(authRouter)
      ..route("/tag_master").pipe(tagMasterRouter)
      ..route("/account").pipe(accountManagerRouter));
  }

  aque.ManagedContext contextWithConnectionInfo(aque.DatabaseConnectionConfiguration database) {
    var connectionInfo = configuration.database;
    var dataModel = new aque.ManagedDataModel.fromPackageContainingType(this.runtimeType);
    var psc = new aque.PostgreSQLPersistentStore.fromConnectionInfo(connectionInfo.username, connectionInfo.password,
        connectionInfo.host, connectionInfo.port, connectionInfo.databaseName);

    var ctx = new aque.ManagedContext(dataModel, psc);
    aque.ManagedContext.defaultContext = ctx;

    return ctx;
  }

  @override
  Map<String, aque.APISecurityScheme> documentSecuritySchemes(aque.PackagePathResolver resolver) {
    return authenticationServer.documentSecuritySchemes(resolver);
  }
}
