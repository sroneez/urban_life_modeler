import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_life_modeler/core/theme/app_theme.dart';

import 'core/usecases/app_bloc_observer.dart';
import 'features/commute/presentation/cubit/commute_cubit.dart';
import 'features/commute/presentation/pages/commute_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  Bloc.observer = AppBlocObserver();

  runApp(UrbanLIfeModelerApp());
}

class UrbanLIfeModelerApp extends StatelessWidget {
  const UrbanLIfeModelerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Urban Life Modeler',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: BlocProvider(
        create: (context) => di.sl<CommuteCubit>(),
        child: const CommutePage(),
      ),
    );
  }
}
