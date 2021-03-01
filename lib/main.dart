import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'simple_blog.dart';
import 'src/dependency_injection/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await DependencyInjector.injectAll();
  runApp(MainApp());
}
