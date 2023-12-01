import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'data.dart';

class ScreenSchedule extends StatefulWidget {
  final UserGroup userGroup;
  final String groupName;

  const ScreenSchedule(
      {Key? key, required this.userGroup, required this.groupName})
      : super(key: key);

  @override
  _EmployeeScheduleState createState() =>
      _EmployeeScheduleState(groupName: groupName);
}

class _EmployeeScheduleState extends State<ScreenSchedule> {
  DateTime _selectedDateFrom = DateTime.now();
  DateTime _selectedDateTo = DateTime.now().add(Duration(days: 1));
  TimeOfDay _selectedTimeFrom = TimeOfDay(hour: 8, minute: 0);
  TimeOfDay _selectedTimeTo = TimeOfDay(hour: 17, minute: 0);
  final DateFormat _dateFormatter = DateFormat.yMd();
  late List<bool> _selectedWeekdays;

  final String groupName;
  _EmployeeScheduleState({Key? key, required this.groupName}) {
    _selectedWeekdays = List.filled(7, true);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _groupNameController =
        TextEditingController(text: groupName);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text('Schedule $groupName'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Date From: ${_dateFormatter.format(_selectedDateFrom)}',
                  style: TextStyle(fontSize: 18),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 8.0), // Ajusta según sea necesario
                  child: InkWell(
                    onTap: () async {
                      await _pickStartDateFrom();
                    },
                    child: Icon(
                      Icons.date_range,
                      color: Colors.indigo, // Cambia el color del icono
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Date To: ${_dateFormatter.format(_selectedDateTo)}',
                  style: TextStyle(fontSize: 18),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: InkWell(
                    onTap: () async {
                      await _pickStartDateTo();
                    },
                    child: Icon(
                      Icons.date_range,
                      color: Colors.indigo, // Cambia el color del icono
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Selected Weekdays:',
              style: TextStyle(fontSize: 18),
            ),
            WeekdaySelector(
              onChanged: (int day) {
                setState(() {
                  _selectedWeekdays[day % 7] = !_selectedWeekdays[day % 7];
                });
              },
              values: _selectedWeekdays,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Time From: ${_selectedTimeFrom.format(context)}',
                  style: TextStyle(fontSize: 18),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: InkWell(
                    onTap: () async {
                      await _pickStartTimeFrom();
                    },
                    child: Icon(
                      Icons.access_time,
                      color: Colors.indigo, // Cambia el color del icono
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Time To: ${_selectedTimeTo.format(context)}',
                  style: TextStyle(fontSize: 18),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: InkWell(
                    onTap: () async {
                      await _pickStartTimeTo();
                    },
                    child: Icon(
                      Icons.access_time,
                      color: Colors.indigo, // Cambia el color del icono
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _showAlert('Saved', 'Schedule has been saved');
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickStartDateFrom() async {
    DateTime? newStartDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateFrom,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (newStartDate != null) {
      setState(() {
        _selectedDateFrom = newStartDate;

        if (_selectedDateFrom.isAfter(_selectedDateTo)) {
          _selectedDateTo = _selectedDateFrom.add(Duration(days: 1));
        }
      });
    }
  }

  Future<void> _pickStartDateTo() async {
    DateTime? newStartDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateFrom,
      firstDate:
          _selectedDateFrom, // Establecemos la fecha mínima como la fecha seleccionada en el dateFrom
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (newStartDate != null) {
      setState(() {
        _selectedDateTo = newStartDate;
        if (_selectedDateFrom == _selectedDateTo) {
          _selectedTimeTo = TimeOfDay(
            hour: _selectedTimeFrom.hour + 1,
            minute: _selectedTimeFrom.minute,
          );
        }
      });
    }
  }

  Future<void> _pickStartTimeFrom() async {
    TimeOfDay? newStartTime = await showTimePicker(
      context: context,
      initialTime: _selectedTimeFrom,
    );

    if (newStartTime != null) {
      setState(() {
        _selectedTimeFrom = newStartTime;
      });
    }
  }

  Future<void> _pickStartTimeTo() async {
    TimeOfDay? newStartTime = await showTimePicker(
      context: context,
      initialTime: _selectedTimeTo,
    );

    if (newStartTime != null) {
      if (_selectedDateFrom == _selectedDateTo &&
          (newStartTime.hour < _selectedTimeFrom.hour ||
              (newStartTime.hour == _selectedTimeFrom.hour &&
                  newStartTime.minute < _selectedTimeFrom.minute))) {
        // Muestra un mensaje de error
        _showAlert('Error', "El 'TimeTo' no puede ser anterior al 'Time From'");
      } else {
        setState(() {
          _selectedTimeTo = newStartTime;
        });
      }
    }
  }

  void _showAlert(String title, String message) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Accept'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
