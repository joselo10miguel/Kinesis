import 'package:flutter/material.dart';

import 'package:kinesis/routes/app_routes.dart';

import 'package:kinesis/providers/nav_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => NavProvider())],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Kinesis',
          initialRoute: AppRoutes.initialRoute,
          routes: AppRoutes.routes,
        ));
  }
}
