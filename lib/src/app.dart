import 'package:calendar_test/src/config/app_routes.dart';
import 'package:calendar_test/src/pages/pages.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _eventController = EventController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      initialRoute: AppRoutes.calendar,
      onGenerateRoute: (settings) {
        final args = settings.arguments;

        switch (settings.name) {
          case AppRoutes.calendar:
            return MaterialPageRoute(
              builder: (context) => CalendarPage(
                eventController: _eventController,
              ),
            );

          case AppRoutes.createEvent:
            return MaterialPageRoute(
              builder: (context) => CreateEventPage(
                dateTime: args as DateTime,
              ),
            );

          case AppRoutes.eventDetails:
            return MaterialPageRoute(
              builder: (context) => EventDetailsPage(
                eventController: _eventController,
                event: args as CalendarEventData,
              ),
            );

          default:
            return null;
        }
      },
    );
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }
}
