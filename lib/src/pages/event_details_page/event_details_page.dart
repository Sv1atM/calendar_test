import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

class EventDetailsPage<T extends Object?> extends StatelessWidget {
  const EventDetailsPage({
    super.key,
    required this.eventController,
    required this.event,
  });

  final EventController<T> eventController;
  final CalendarEventData<T> event;

  void _deleteEvent(BuildContext context) {
    eventController.remove(event);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          event.title,
          style: const TextStyle(
            overflow: TextOverflow.ellipsis,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _deleteEvent(context),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 32,
            horizontal: 16,
          ),
          child: _pageBody(),
        ),
      ),
    );
  }

  Widget _pageBody() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          if (event.description.isNotEmpty)
            Text(
              event.description,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
        ],
      );
}
