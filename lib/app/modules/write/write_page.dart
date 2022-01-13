import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halloween_stories/app/modules/write/write_controller.dart';

class WritePage extends GetView<WriteController> {
  const WritePage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
    appBar: AppBar(title: const Text('WritePage')),
    body: const SafeArea(
      child: Text('WriteController'))
    );
  }
}