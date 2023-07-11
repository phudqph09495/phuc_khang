import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'bloc/auth/bloc_checkLogin.dart';
import 'bloc/bloc_counter.dart';
import 'bloc/cart/bloc_cart.dart';
import 'bloc/cart/event_bloc2.dart';
import 'bloc/counter_observer.dart';
import 'bloc/event_bloc.dart';
import 'config/share_pref.dart';
import 'home.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = CounterObserver();
  await SharedPrefs.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => CounterCubit()),
        BlocProvider(create: (_) => BlocCheckLogin()..add(GetData())),
        BlocProvider(create: (_) => BlocCartLocal()..add(GetCart())),
        // BlocProvider(create: (_) => BlocFireBaseMS()..add(firebase())),
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.

        // CartModel is implemented as a ChangeNotifier, which calls for the use
        // of ChangeNotifierProvider. Moreover, CartModel depends
        // on CatalogModel, so a ProxyProvider is needed.
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [Locale('en'), Locale('vi')],
        // builder: DevicePreview.appBuilder,
        // theme: ThemeData.light(),
        // darkTheme: ThemeData.dark(),
        home: MyHomePage(),
      ),
    );
  }
}
