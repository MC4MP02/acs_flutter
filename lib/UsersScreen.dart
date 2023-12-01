import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'data.dart';
import 'the_drawer.dart';
import 'UserDetailsScreen.dart';

class UsersScreen extends StatefulWidget {
  final List<User> users;
  final String groupName;
  final BuildContext context; // Agrega el contexto aquí

  UsersScreen(
      {required this.users, required this.groupName, required this.context});

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text("Users ${widget.groupName}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: widget.users.length,
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemBuilder: (BuildContext context, int index) {
            return _buildUserRow(widget.users[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.person_add),
        onPressed: () {
          // TODO: Agregar un nuevo usuario con un nombre predeterminado
          User newUser = User("New User", "New Credential");
          widget.users.add(newUser);
          setState(() {});
        },
      ),
    );
  }

  Widget _buildUserRow(User user) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute<void>(
          builder: (context) => UserDetailsScreen(context: context, user: user),
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  foregroundImage: _buildUserImage(user),
                ),
                SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Credential: ${user.credential}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ImageProvider<Object> _buildUserImage(User user) {
    final imageUrl = Data.images[user.name.toLowerCase()];

    // Verificar si la URL de la imagen existe
    if (imageUrl != null) {
      // Devolver la imagen si la URL existe
      return NetworkImage(imageUrl);
    } else {
      // Devolver una imagen predeterminada si la URL no existe
      return AssetImage("assets/default_avatar.png");
    }
  }
}
