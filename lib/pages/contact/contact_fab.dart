import 'package:flutter/material.dart';
import 'package:flutter_agenda/helpers/contact_helper.dart';
import 'package:flutter_agenda/pages/contact/contact_bloc.dart';
import 'package:flutter_agenda/pages/contact/contact_event.dart';
import 'package:flutter_agenda/pages/contact/contact_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactFab extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;

  ContactFab({
    @required this.formKey,
    @required this.nameController,
    @required this.phoneController,
    @required this.emailController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactBloc, ContactState>(
      builder: (context, state) {
        return FloatingActionButton(
          tooltip: 'Salvar',
          child: state.saving
              ? CircularProgressIndicator(
                  backgroundColor: Colors.white,
                )
              : Icon(Icons.save),
          onPressed: () {
            if (formKey.currentState.validate() && !state.saving)
              _saveContact(context, state.contact);
          },
        );
      },
    );
  }

  void _saveContact(BuildContext context, Contact contact) {
    contact.name = nameController.text;
    contact.phone = phoneController.text;
    contact.email = emailController.text;

    context
        .bloc<ContactBloc>()
        .add(SaveContact(context: context, contact: contact));
  }
}
