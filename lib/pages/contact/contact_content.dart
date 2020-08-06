import 'package:flutter/material.dart';
import 'package:flutter_agenda/helpers/contact_helper.dart';
import 'package:flutter_agenda/helpers/fomaters.dart';
import 'package:flutter_agenda/helpers/validators.dart';
import 'package:flutter_agenda/pages/contact/contact_bloc.dart';
import 'package:flutter_agenda/pages/contact/contact_event.dart';
import 'package:flutter_agenda/pages/contact/contact_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactContent extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ContactContent({@required this.nameController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactBloc, ContactState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text(state.name),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(8),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                GestureDetector(
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 76,
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    labelStyle: TextStyle(fontSize: 24),
                  ),
                  style: TextStyle(fontSize: 24),
                  controller: nameController,
                  onChanged: (value) {
                    context.bloc<ContactBloc>().add(ChangeNameContact(value));
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Telefone',
                    labelStyle: TextStyle(fontSize: 24),
                  ),
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  inputFormatters: [phoneFormatter],
                  validator: isPhone,
                  controller: phoneController,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(fontSize: 24),
                  ),
                  style: TextStyle(fontSize: 24),
                  validator: isEmail,
                  controller: emailController,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: () {
            if (_formKey.currentState.validate())
              _saveContact(context, state.contact);
          },
        ),
      ),
    );
  }

  void _saveContact(BuildContext context, Contact contact) {
    contact.name = nameController.text;
    contact.phone = phoneController.text;
    contact.email = emailController.text;
    print(contact);
    // context
    //     .bloc<ContactBloc>()
    //     .add(SaveContact(context: context, contact: contact));
  }
}
