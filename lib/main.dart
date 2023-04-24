import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:remote_congigue_demoapp/data/services/remote_service.dart';
import 'package:remote_congigue_demoapp/firebase_options.dart';
import 'package:remote_congigue_demoapp/presentation/bloc/product_detail_bloc.dart';
import 'package:remote_congigue_demoapp/presentation/view/event_page.dart';
import 'common/DI/dependancy_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // final firebaseRemoteConfigService = FirebaseRemoteConfigService(
  //     firebaseRemoteConfig: FirebaseRemoteConfig.instance);

  setup();
  await getIt<FirebaseRemoteConfigService>().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: BlocProvider<ProductDetailBloc>(
        create: (context) => getIt(),
        child: Builder(builder: (context) {
          return const EventPage();
        }),
      ),
    );
  }
}
