import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo/data/data.dart';
import 'package:todo/data/repo/repository.dart';
import 'package:todo/data/source/hive_task_source.dart';
import 'package:todo/screens/home/home.dart';

const taskBoxName = 'tasks';
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskEntityAdapter());
  Hive.registerAdapter(PriorityAdapter());
  await Hive.openBox<TaskEntity>(taskBoxName);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: primaryVariantColor,
    ),
  );
  runApp(
    ChangeNotifierProvider<Repository<TaskEntity>>(
      create: (context) => Repository<TaskEntity>(
        HiveTaskDataSource(
          box: Hive.box(taskBoxName),
        ),
      ),
      child: const MyApp(),
    ),
  );
}

const Color primaryColor = Color(0xff794CFF);
const Color primaryVariantColor = Color(0xff5C0AFF);
const secondaryTextColor = Color(0xffAFBED0);
const normalPriority = Color(0xffF09819);
const lowPriority = Color(0xff3BE1F1);
const highPriority = primaryColor;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryTextColor = Color(0xff1D2830);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(const TextTheme(
              titleLarge: TextStyle(fontWeight: FontWeight.bold))),
          inputDecorationTheme: const InputDecorationTheme(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelStyle: TextStyle(color: secondaryTextColor),
              border: InputBorder.none,
              iconColor: secondaryTextColor),
          colorScheme: const ColorScheme.light(
              primary: primaryColor,
              surface: Color(0xffF3F5F8),
              onSurface: primaryTextColor,
              onPrimary: Colors.white,
              secondary: primaryColor,
              onSecondary: Colors.white)),
      home: HomeScreen(),
    );
  }
}
