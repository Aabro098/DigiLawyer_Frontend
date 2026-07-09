import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:digi_lawyer/app.dart';
import 'package:digi_lawyer/providers/chatbot_provider.dart';
import 'package:digi_lawyer/providers/localization_provider.dart';
import 'package:digi_lawyer/providers/theme_provider.dart';
import 'package:digi_lawyer/utils/helpers/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Notification Service initialization
  await NotificationService().initiNotification();

  // Restore system UI and set status bar style
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.black, // Primary purple color
        statusBarIconBrightness:
            Brightness.light, // White icons on dark background
        statusBarBrightness: Brightness.dark, // For iOS
        systemNavigationBarColor: Colors.black),
  );

  // Allow only portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then(
    (_) {
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
            ChangeNotifierProvider(create: (_) => LocalizationProvider()),
            ChangeNotifierProvider(create: (_) => ChatbotProvider()),
          ],
          child: const App(),
        ),
      );
    },
  );
}
