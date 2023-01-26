import 'package:calendar_test/src/config/app_routes.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

part 'calendar_page_day_view.dart';
part 'calendar_page_week_view.dart';
part 'calendar_page_month_view.dart';

class CalendarPage<T extends Object?> extends StatefulWidget {
  const CalendarPage({
    super.key,
    required this.eventController,
  });

  final EventController<T> eventController;

  @override
  State<CalendarPage<T>> createState() => _CalendarPageState<T>();
}

class _CalendarPageState<T extends Object?> extends State<CalendarPage<T>>
    with SingleTickerProviderStateMixin {
  final _dayViewKey = GlobalKey<DayViewState>();
  late final TabController _tabController;
  late ThemeData _theme;

  final _tabs = [
    'Day',
    'Week',
    'Month',
  ];

  Future<void> _createEvent(DateTime dateTime) async {
    final event = await Navigator.of(context).pushNamed(
      AppRoutes.createEvent,
      arguments: dateTime,
    ) as CalendarEventData<T>?;

    if (event != null) widget.eventController.add(event);
  }

  void _openEventDetails(CalendarEventData<T> event) =>
      Navigator.of(context).pushNamed(
        AppRoutes.eventDetails,
        arguments: event,
      );

  Future<void> _navigateToDay(DateTime dayDate) async {
    _tabController.animateTo(0);
    await Future.delayed(_tabController.animationDuration);
    _dayViewKey.currentState!.jumpToDate(dayDate);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _tabs.length,
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _theme = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar App'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: _tabBarView()),
            const SizedBox(height: 16),
            SizedBox(
              height: 40,
              child: _tabPicker(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _tabBarView() => TabBarView(
        controller: _tabController,
        children: [
          _dayView(),
          _weekView(),
          _monthView(),
        ],
      );

  Widget _tabPicker() => TabBar(
        controller: _tabController,
        labelColor: _theme.primaryColor,
        tabs: _tabs.map((tab) => Tab(text: tab)).toList(growable: false),
      );

  Widget _dayView() => CalendarPageDayView(
        viewKey: _dayViewKey,
        eventController: widget.eventController,
        onDateLongPress: _createEvent,
        onEventTap: (events, date) =>
            events.isNotEmpty ? _openEventDetails(events.first) : null,
        theme: _theme,
      );

  Widget _weekView() => CalendarPageWeekView(
        eventController: widget.eventController,
        onDateLongPress: _createEvent,
        onEventTap: (events, date) =>
            events.isNotEmpty ? _openEventDetails(events.first) : null,
        theme: _theme,
      );

  Widget _monthView() => CalendarPageMonthView(
        eventController: widget.eventController,
        onDateLongPress: _createEvent,
        onCellTap: (events, date) => _navigateToDay(date),
        theme: _theme,
      );
}
