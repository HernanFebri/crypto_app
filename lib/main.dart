import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_crypto_app/pages/home_page.dart';
import 'package:getx_crypto_app/utils.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await registerServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Crypto App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
          ),
          useMaterial3: true,
          textTheme: GoogleFonts.quicksandTextTheme()),
      routes: {
        "/home": (context) => HomePage(),
      },
      initialRoute: "/home",
    );
  }
}
