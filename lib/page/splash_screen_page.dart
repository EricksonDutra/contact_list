import 'package:flutter/material.dart';
import 'package:lista_contatos/page/home_page.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), (){
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (_) => const HomePage(),
        settings: const RouteSettings(name: "Home_Page"),
      ));
    });
    return Container(
      color: Colors.indigo,
      alignment: Alignment.center,
      child: Image.asset('assets/icon/icon.png', width: 250)
    );
  }
}