import 'package:flutter/material.dart';
import 'screens/register_screen.dart';
import 'screens/login_screen.dart';
import 'screens/forgot_screen.dart';
import 'screens/todos_screen.dart';
import 'screens/tabs_screen.dart';



Map<String, WidgetBuilder> routesBuilder(){
  return {
    '/register': (BuildContext context)=> Registerscreen(),
    '/login'   : (BuildContext context)=> LoginScreen(),
    '/forgot'  : (BuildContext context)=> ForgotScreen(),
    '/todos'   : (BuildContext context)=> TodosScreen(),
    '/tabs'    : (BuildContext context)=> TabsScreen()
  };
}