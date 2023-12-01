import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'data.dart';
import 'the_drawer.dart';

class ActionsScreen extends StatefulWidget {
  @override
  _ActionsScreenState createState() => _ActionsScreenState();
}

class _ActionsScreenState extends State<ActionsScreen> {
  List<bool> selectedActions = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text("Actions"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CheckboxListTile(
              title: Text('Open'),
              subtitle: Text('opens an unlocked door'),
              value: selectedActions[0],
              onChanged: (bool? value) {
                setState(() {
                  selectedActions[0] = value ?? false;
                });
              },
            ),
            Divider(),
            CheckboxListTile(
              title: Text('Close'),
              subtitle: Text('closes an open door'),
              value: selectedActions[1],
              onChanged: (bool? value) {
                setState(() {
                  selectedActions[1] = value ?? false;
                });
              },
            ),
            Divider(),
            CheckboxListTile(
              title: Text('Lock'),
              subtitle: Text(
                  'Locks a door or all the doors in a rrom or group of rooms, if closed'),
              value: selectedActions[2],
              onChanged: (bool? value) {
                setState(() {
                  selectedActions[2] = value ?? false;
                });
              },
            ),
            Divider(),
            CheckboxListTile(
              title: Text('Unlock'),
              subtitle: Text(
                  'Unlocks a locked door or all the locked doors in a room'),
              value: selectedActions[3],
              onChanged: (bool? value) {
                setState(() {
                  selectedActions[3] = value ?? false;
                });
              },
            ),
            Divider(),
            CheckboxListTile(
              title: Text('Unlock shortly'),
              subtitle: Text(
                  'Unlocks a door during 10 seconds and then locks it if it is closed'),
              value: selectedActions[4],
              onChanged: (bool? value) {
                setState(() {
                  selectedActions[4] = value ?? false;
                });
              },
            ),
            Divider(),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _showConfirmationSnackBar();
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Actions submitted: $selectedActions'),
      ),
    );
  }
}
