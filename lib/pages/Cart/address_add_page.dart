import 'package:flutter/material.dart';

class AddressAddPage extends StatefulWidget {
  const AddressAddPage({Key? key}) : super(key: key);

  @override
  State<AddressAddPage> createState() => _AddressAddPageState();
}

class _AddressAddPageState extends State<AddressAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("添加地址")),
      body: Container(),
    );
  }
}
