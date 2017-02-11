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
    router
      ..basePath = "/api"
      // routes for AUTHENTICATION
      ..route("/auth/login")
          .pipe(new aque.Authorizer(authenticationServer, strategy: aque.AuthStrategy.client))
          .generate(() => new aque.AuthController(authenticationServer))
      ..route("/auth/logout").pipe(new aque.Authorizer(authenticationServer)).generate(() => new LogoutController())
      ..route("/auth/register").pipe(new aque.Authorizer(authenticationServer)).generate(() => new RegisterController())
      ..route("/identity").pipe(new aque.Authorizer(authenticationServer)).generate(() => new IdentityController())
      // routes for ACCOUNT MANAGER

      // routes for TAG MASTER 2
      ..route("/repo/[:branch]").pipe(new aque.Authorizer(authenticationServer)).generate(() => new RepoController())
      ..route("/tags/[:id]").pipe(new aque.Authorizer(authenticationServer)).generate(() => new TagsController())

      // routes for TAGGER
      ..route("/tagged_events/[:id]")
          .pipe(new aque.Authorizer(authenticationServer))
          .generate(() => new TaggedEventController());
  }

  aque.ManagedContext contextWithConnectionInfo(aque.DatabaseConnectionConfiguration database) {
    var connectionInfo = configuration.database;
    var dataModel = new aque.ManagedDataModel.fromPackageContainingType(User);
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
