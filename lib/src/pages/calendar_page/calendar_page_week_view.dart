part of 'calendar_page.dart';

class CalendarPageWeekView<T extends Object?> extends StatelessWidget {
  const CalendarPageWeekView({
    super.key,
    this.viewKey,
    required this.eventController,
    this.onDateLongPress,
    this.onEventTap,
    this.theme,
  });

  final GlobalKey<WeekViewState>? viewKey;
  final EventController<T> eventController;
  final void Function(DateTime)? onDateLongPress;
  final void Function(List<CalendarEventData<T>>, DateTime)? onEventTap;
  final ThemeData? theme;

  @override
  Widget build(BuildContext context) {
    return WeekView(
      key: viewKey,
      controller: eventController,
      onDateLongPress: onDateLongPress,
      onEventTap: onEventTap,
      weekDayBuilder: _weekDayBuilder,
    );
  }

  Widget _weekDayBuilder(DateTime dayDate) {
    final weekday = DateFormat.E().format(dayDate);
    final dayNumber = dayDate.day.toString();
    final eventsCount = eventController.getEventsOnDay(dayDate).length;

    return Column(
      children: [
        Text(
          weekday,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w300,
          ),
        ),
        Text(
          dayNumber,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        OverflowBar(
          alignment: MainAxisAlignment.start,
          children: List.generate(
            eventsCount,
            (_) => Icon(
              Icons.circle,
              size: 8,
              color: theme?.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
