import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  static const String routeName = "/login";
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.close),
        ),
        actions: [
          TextButton(onPressed: (){}, child: const Text("客服"))
        ],
      ),
      body: ListView(
        children: [
          buildLogoImageWidget(),
        ],
      ),
    );
  }

  Widget buildLogoImageWidget() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Image.asset("assets/images/login.png"),
    );
  }
}
