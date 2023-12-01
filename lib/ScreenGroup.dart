import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'UsersScreen.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'data.dart';
import 'the_drawer.dart';
import 'InfoScreen.dart';
import 'ActionsScreen.dart';
import 'UsersScreen.dart';
import 'screen_schedule.dart';

class ScreenGroup extends StatelessWidget {
  final UserGroup userGroup;

  ScreenGroup({required this.userGroup});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text("Group " + userGroup.name),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        padding: EdgeInsets.all(16.0),
        children: [
          _buildGroupButton(
            context,
            "Info",
            Icons.info,
            InfoScreen(userGroup: userGroup),
          ),
          _buildGroupButton(
            context,
            "Schedule",
            Icons.schedule,
            ScreenSchedule(
                userGroup: userGroup, groupName: userGroup.name ?? ""),
          ),
          _buildGroupButton(
            context,
            "Actions",
            Icons.accessibility,
            ActionsScreen(),
          ),
          _buildGroupButton(
            context,
            "Places",
            Icons.place,
            InfoScreen(userGroup: userGroup),
          ),
          _buildGroupButton(
            context,
            "Users",
            Icons.people,
            UsersScreen(
                users: userGroup.users,
                groupName: userGroup.name ?? "",
                context: context),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupButton(
    BuildContext context,
    String buttonText,
    IconData icon,
    Widget screen,
  ) {
    return InkWell(
      onTap: () {
        if (buttonText == "Info" ||
            buttonText == "Actions" ||
            buttonText == "Users" ||
            buttonText == "Schedule") {
          Navigator.of(context).push(MaterialPageRoute<void>(
            builder: (context) => screen,
          ));
        } else {
          print('Botón seleccionado: $buttonText');
        }
      },
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40.0, color: Colors.blue),
            SizedBox(height: 8.0),
            Text(
              buttonText,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
