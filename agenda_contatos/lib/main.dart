import 'package:agenda_contatos/Screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

main(List<String> args) {

   

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.indigo, // navigation bar color
    statusBarColor: Colors.indigo[300],
    statusBarBrightness: Brightness.light // status bar color
  ));

  runApp(MaterialApp(
    home: HomePage(),  
    debugShowCheckedModeBanner: false,
    ));
  
}