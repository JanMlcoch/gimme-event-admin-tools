library test_helper;

import 'dart:async';
import 'startup.dart';

Future logTestUser(TestApplication app)async {
  var response = await (app.client.clientAuthenticatedRequest("/auth/register")
    ..json = {"username":"","email": "bob@stablekernel.com", "password": "foobaraxegrind12%"}).post();
}