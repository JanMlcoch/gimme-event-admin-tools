part of tag_master_repository_getter;

Future<TagMasterRepository> getRepo() async{
  return (await getTagMasterRepoFromRemote())["repo"];
}

Future<Map> getTagMasterRepoFromRemote() async {
  await login();
  String resp = await downloadRepo();
  Map repository = JSON.decode(resp);
  TagMasterRepository repo = new TagMasterRepository()
    ..fromMap(JSON.decode(repository["repo"]));
  int repoId = repository["id"];
  return {"repo": repo, "repoId": repoId};
}

Future<String> login() async {
  if (TagMasterGetterGateway.accessToken != null &&
      new DateTime.now().difference(TagMasterGetterGateway.lastLogin).inMilliseconds > const Duration(minutes: 20).inMilliseconds) {
    return TagMasterGetterGateway.dataFromResponse;
  }

  TagMasterGetterGateway.lastLogin = new DateTime.now();
  String password = "heslo Admin Tools pro Akcnik webovou aplikaci";
  String clientID = "Akcnik Admin tools";

  String pColonC = "$clientID:$password";
  String b64 = BASE64.encode(UTF8.encode(pColonC));

  Map<String, String> dataToSend = {"grant_type": "password", "username": "admin", "password": "velmi_slozite_heslo"};
  String dataFromResponse;

  http.Response response = await http.post("http://localhost:8000/api/auth/login",headers: {"Authorization": "Basic $b64"},body: dataToSend);

  Map tokens = JSON.decode(response.body);
  String token = tokens["access_token"];
  TagMasterGetterGateway.accessToken = token;
  TagMasterGetterGateway.dataFromResponse = dataFromResponse;
  return await dataFromResponse;
}

Future<String> downloadRepo() async {
  http.Response response = await http.get("http://localhost:8000/api/repo/",headers: {
    "Authorization": "Bearer ${TagMasterGetterGateway.accessToken}",
    "Content-Type": "application/json;charset=UTF-8"
  });
  return response.body;
}