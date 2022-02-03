import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math';

Future<int> testRandom() {
  return Future.delayed(Duration(seconds: 1), () {
    var random = Random().nextInt(5);
    if (random == 0) {
      throw "Error you have got 0";
    }
    return random;
  });
}

Future<void> wait(int time) {
  return Future.delayed(Duration(seconds: time), () {
    print("Please wait! ...");
  });
}

void acceptEventOnly(StreamController<int> controller, int input) {
  if (input % 2 == 0) {
    controller.sink.add(input);
  } else {
    controller.sink.addError("$input is not an even number");
  }
}

void main() {
  StreamController<int> streamController = StreamController<int>();

  for (var i = 0; i < 10; i++) {
    acceptEventOnly(streamController, i);
  }
  streamController.sink.add(2022);
  streamController.close();
  streamController.stream.listen(
      (value) {
        print(value);
      },
      onError: (e) {
        print(e.toString());
      },
      cancelOnError: false,
      onDone: () {
        print("There is onDone event when ending using stream!");
      });
}
