import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'me_logic.dart';

class MePage extends StatelessWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的'),
        centerTitle: true,

      ),
    );
  }
}
