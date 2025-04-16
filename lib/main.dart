import 'package:brasil_cripto/src/core/app/app.dart';
import 'package:brasil_cripto/src/features/app_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_ce/hive.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);
  await dotenv.load(fileName: ".env");

  final appDir = await getApplicationCacheDirectory();
  Hive.init(appDir.path);
  runApp(ModularApp(module: AppModule(), child: const App()));
}
