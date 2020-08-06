import 'package:flutter/material.dart';
import 'package:flutter_agenda/helpers/contact_helper.dart';
import 'package:flutter_agenda/pages/contact/contact_bloc.dart';
import 'package:flutter_agenda/pages/contact/contact_content.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactPage extends StatelessWidget {
  final Contact contact;

  ContactPage({@required this.contact});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactBloc(),
      child: ContactContent(),
    );
  }
}
