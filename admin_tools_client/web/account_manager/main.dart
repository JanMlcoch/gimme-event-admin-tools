// Copyright (c) 2016, Jan Mlcoch. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/platform/browser.dart';

import './angular_components/app_component.dart';

import'dart:async' as async;
void main() {
  new AppPokus();
  bootstrap(AppComponent);

}




class EventStream<T> {
  async.StreamController<T> _controller;
  async.Stream<T> _stream;

  async.Stream<T> get stream => _stream;
  async.StreamController<T> get controller => _controller;

  EventStream({Function onListen: null, Function onCancel: null, bool sync: false}) {
    _controller = new async.StreamController<T>(onListen: onListen, onCancel: onCancel, sync: sync);
    _stream = _controller.stream.asBroadcastStream();
  }
}

class AppPokus{
  AppPokus(){
    EventStream myEventStream = new EventStream();
    myEventStream.controller.add(new T("obsah"));

//    myEventStream.stream.listen((T t) => print(t.content));
    myEventStream.controller.stream.listen((T t) => print(t.content));
    myEventStream.controller.stream.listen((T t) => print(t.content));
    myEventStream.controller.stream.listen((T t) => print(t.content));
  }
}

class T{
  String content = "content";
  T(this.content);
}

