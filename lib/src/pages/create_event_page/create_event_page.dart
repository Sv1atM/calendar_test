import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({
    super.key,
    required this.dateTime,
  });

  final DateTime dateTime;

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final _formKey = GlobalKey<FormState>();
  final _startDateTimeController = TextEditingController();
  final _endDateTimeController = TextEditingController();
  late DateTime _initialDate;
  var _title = '';
  var _description = '';
  var _startDateTime = DateTime.now();
  var _endDateTime = DateTime.now();
  var _autovalidateMode = AutovalidateMode.disabled;

  void _onTitleChange(String value) => _title = value;

  Future<void> _onStartDateTimeTap() async {
    final selectedDate = await _selectDate();
    if (selectedDate == null) return;
    final selectedTime = await _selectTime();
    if (selectedTime == null) return;
    _startDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
    _startDateTimeController.text = _formatDate(_startDateTime);
  }

  Future<void> _onEndDateTimeTap() async {
    final selectedDate = await _selectDate();
    if (selectedDate == null) return;
    final selectedTime = await _selectTime();
    if (selectedTime == null) return;
    _endDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
    _endDateTimeController.text = _formatDate(_endDateTime);
  }

  void _onDescriptionChange(String value) => _description = value;

  Future<DateTime?> _selectDate() async {
    final now = DateTime.now();
    return showDatePicker(
      context: context,
      initialDate: _initialDate.isAfter(now) ? _initialDate : now,
      firstDate: DateUtils.dateOnly(now),
      lastDate: DateUtils.addMonthsToMonthDate(now, 12),
    );
  }

  Future<TimeOfDay?> _selectTime() => showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_initialDate),
      );

  String _formatDate(DateTime dateTime) =>
      DateFormat.yMMMd().add_jm().format(dateTime);

  void _saveEvent() {
    final valuesAreValid = _formKey.currentState!.validate();

    if (!valuesAreValid) {
      _autovalidateMode = AutovalidateMode.onUserInteraction;
      setState(() {});
      return;
    }

    final newEvent = CalendarEventData(
      title: _title,
      description: _description,
      date: _startDateTime,
      startTime: _startDateTime,
      endDate: _endDateTime,
      endTime: _endDateTime
    );

    Navigator.of(context).pop(newEvent);
  }

  @override
  void initState() {
    super.initState();
    _initialDate = widget.dateTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create event'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 32,
            horizontal: 16,
          ),
          child: _createEventForm(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveEvent,
        child: const Icon(Icons.save),
      ),
    );
  }

  @override
  void dispose() {
    _startDateTimeController.dispose();
    _endDateTimeController.dispose();
    super.dispose();
  }

  Widget _createEventForm() => Form(
        key: _formKey,
        autovalidateMode: _autovalidateMode,
        child: Column(
          children: [
            _titleField(),
            const SizedBox(height: 12),
            _startDateTimeField(),
            const SizedBox(height: 12),
            _endDateTimeField(),
            const SizedBox(height: 12),
            _descriptionField(),
          ],
        ),
      );

  Widget _titleField() => TextFormField(
        autofocus: true,
        onChanged: _onTitleChange,
        decoration: const InputDecoration(
          label: Text('Title'),
        ),
        validator: (value) {
          if (value?.isEmpty ?? true) return "Title mustn't be empty";
          return null;
        },
      );

  Widget _startDateTimeField() => TextFormField(
        readOnly: true,
        controller: _startDateTimeController,
        onTap: _onStartDateTimeTap,
        decoration: const InputDecoration(
          label: Text('Start'),
        ),
        validator: (value) {
          if (value?.isEmpty ?? true) return "Start must be set";
          return null;
        },
      );

  Widget _endDateTimeField() => TextFormField(
        readOnly: true,
        controller: _endDateTimeController,
        onTap: _onEndDateTimeTap,
        decoration: const InputDecoration(
          label: Text('End'),
        ),
        validator: (value) {
          if (value?.isEmpty ?? true) return "End must be set";
          return null;
        },
      );

  Widget _descriptionField() => TextFormField(
        maxLines: null,
        onChanged: _onDescriptionChange,
        decoration: const InputDecoration(
          label: Text('Description'),
        ),
      );
}
