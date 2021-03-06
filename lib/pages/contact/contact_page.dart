import 'package:flutter/material.dart';
import 'package:flutter_agenda/helpers/contact_helper.dart';
import 'package:flutter_agenda/pages/contact/contact_bloc.dart';
import 'package:flutter_agenda/pages/contact/contact_content.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactPage extends StatelessWidget {
  final Contact contact;
  final ContactHelper repository;

  ContactPage({@required this.repository, this.contact});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactBloc(
        repository: repository,
        contact: contact,
      ),
      child: ContactContent(
        nameController: TextEditingController(text: contact.name ?? ''),
        phoneController: TextEditingController(text: contact.phone ?? ''),
        emailController: TextEditingController(text: contact.email ?? ''),
      ),
    );
  }
}
