part of 'calendar_page.dart';

class CalendarPageMonthView<T extends Object?> extends StatelessWidget {
  const CalendarPageMonthView({
    super.key,
    this.viewKey,
    required this.eventController,
    this.onDateLongPress,
    this.onCellTap,
    this.theme,
  });

  final GlobalKey<MonthViewState>? viewKey;
  final EventController<T> eventController;
  final void Function(DateTime)? onDateLongPress;
  final void Function(List<CalendarEventData<T>>, DateTime)? onCellTap;
  final ThemeData? theme;

  @override
  Widget build(BuildContext context) {
    return MonthView(
      key: viewKey,
      controller: eventController,
      onDateLongPress: onDateLongPress,
      onCellTap: onCellTap,
      cellBuilder: _cellBuilder,
    );
  }

  Widget _cellBuilder(
    DateTime dayDate,
    List<CalendarEventData<T>> events,
    bool isToday,
    bool isInMonth,
  ) {
    if (!isInMonth) return const SizedBox.shrink();

    final eventsCount = eventController.getEventsOnDay(dayDate).length;

    return ColoredBox(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 4),
          Container(
            decoration: BoxDecoration(
              color: isToday ? theme?.primaryColor : Colors.transparent,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(6),
            alignment: Alignment.center,
            child: Text(
              dayDate.day.toString(),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: !isToday ? Colors.grey : Colors.white,
              ),
            ),
          ),
          if (eventsCount > 0)
            Expanded(
              child: Center(
                child: Text(
                  eventsCount.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: theme?.primaryColor,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
