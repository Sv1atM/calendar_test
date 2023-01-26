part of 'calendar_page.dart';

class CalendarPageDayView<T extends Object?> extends StatelessWidget {
  const CalendarPageDayView({
    super.key,
    this.viewKey,
    required this.eventController,
    this.onDateLongPress,
    this.onEventTap,
    this.theme,
  });

  final GlobalKey<DayViewState>? viewKey;
  final EventController<T> eventController;
  final void Function(DateTime)? onDateLongPress;
  final void Function(List<CalendarEventData<T>>, DateTime)? onEventTap;
  final ThemeData? theme;

  @override
  Widget build(BuildContext context) {
    return DayView(
      key: viewKey,
      controller: eventController,
      onDateLongPress: onDateLongPress,
      onEventTap: onEventTap,
    );
  }
}
