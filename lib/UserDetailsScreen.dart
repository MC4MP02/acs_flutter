import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'data.dart';
import 'the_drawer.dart';

class UserDetailsScreen extends StatefulWidget {
  final BuildContext context;
  final User user;

  UserDetailsScreen({required this.context, required this.user});

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _credentialController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Inicializar los controladores con los datos actuales del usuario
    _nameController.text = widget.user.name ?? "";
    _credentialController.text = widget.user.credential ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text('Edit User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: Colors.blue,
                width: 2.0,
              ),
            ),
            child: Column(
              children: [
                _buildTextBox("Name", _nameController),
                SizedBox(height: 16.0),
                _buildTextBox("Credential", _credentialController),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _updateUser();
                      _showConfirmationSnackBar();
                    }
                  },
                  child: Text('Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextBox(String labelText, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: InputBorder.none,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $labelText';
          }
          return null;
        },
      ),
    );
  }

  void _updateUser() {
    // Actualizar los datos del usuario con los valores de los controladores
    widget.user.name = _nameController.text;
    widget.user.credential = _credentialController.text;
  }

  void _showConfirmationSnackBar() {
    ScaffoldMessenger.of(widget.context).showSnackBar(
      SnackBar(
        content: Text(
            'User updated\nName: ${_nameController.text}\nCredential: ${_credentialController.text}'),
      ),
    );
  }
}
