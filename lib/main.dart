import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy_ride/provider/api_provider.dart';
import 'package:flutter_easy_ride/Book_Now/provider/cab_book_provider.dart';
import 'package:flutter_easy_ride/provider/map_provider.dart';
import 'package:flutter_easy_ride/utils/converter_function.dart';
import 'package:flutter_easy_ride/utils/routes.dart';
import 'package:flutter_easy_ride/view/home/home_view.dart';
import 'package:provider/provider.dart';
import 'Book_Now/provider/drive_looking_provider.dart';
import 'Pre_Booking/provider/preebooking_provider.dart';
import 'book_easyride/provider/triphistry_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CabBookProvider()),
        ChangeNotifierProvider(create: (_) => ApiProvider()),
        ChangeNotifierProvider(create: (_) => MapProvider()),
        ChangeNotifierProvider(create: (_) => ProgressBarState()),
        ChangeNotifierProvider(create: (_) => TriphistryProvider()),
        ChangeNotifierProvider(create: (_) => PreebookingProvider()),
      ],
      child:
          //MyApp()
          DevicePreview(
        builder: (BuildContext context) {
          return MyApp();
        },
      ),
    ),
  );
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Provider.of<ApiProvider>(context, listen: false).fetchAuth().then((_) {
      Provider.of<ApiProvider>(context, listen: false).fetchTheme();
    }).catchError((error) {
      print("Error: $error");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ApiProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: ConverterFunction.parseColor(
                value.themeConfigg?.lightTheme.primaryColor ?? ''),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: Routes.homeview,
          onGenerateRoute: Routes.generateRoute,
          home: HomeView(),
        );
      },
    );
  }
}
