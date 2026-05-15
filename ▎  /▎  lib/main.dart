 dart
▎  import 'package:flutter/material.dart'; 
▎  import 'screens/home_screen.dart'; 
▎   
▎  void main() { 
▎    runApp(const DurianMasterApp()); 
▎  } 
▎   
▎  class DurianMasterApp extends StatelessWidget { 
▎    const DurianMasterApp({super.key}); 
▎   
▎    @override 
▎    Widget build(BuildContext context) { 
▎      return MaterialApp( 
▎        title: '榴莲大师', 
▎        debugShowCheckedModeBanner: false, 
▎        theme: ThemeData( 
▎          colorSchemeSeed: const Color(0xFFFF8F00), 
▎          useMaterial3: true, 
▎          fontFamily: 'Roboto', 
▎        ), 
▎        home: const HomeScreen(), 
▎      ); 
▎    } 
▎  } 
▎
