import 'package:e_commernce_ui/Data/SearchModel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Route.dart';
import 'package:provider/provider.dart';
import 'package:e_commernce_ui/Data/Sharedprefs.dart';
import 'package:e_commernce_ui/Data/HintsModel.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await   CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Search>( create: (_) =>Search(),),
        ChangeNotifierProvider<Hints>( create: (_) =>Hints(),)

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: "FrizQuadrata",
          primarySwatch: Colors.blue,
        ),
        initialRoute:'/',
        onGenerateRoute: MyRouter.generateRoutes,

      ),
    );
  }
}
