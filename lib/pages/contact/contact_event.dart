import 'package:flutter/material.dart';
import 'package:flutter_agenda/helpers/contact_helper.dart';

abstract class ContactEvent {}

class SaveContact extends ContactEvent {
  final Contact contact;
  final BuildContext context;
  SaveContact({@required this.contact, @required this.context});
}

class ChangeNameContact extends ContactEvent {
  final String name;
  ChangeNameContact(this.name);
}
