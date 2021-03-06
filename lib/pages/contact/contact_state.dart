import 'package:equatable/equatable.dart';
import 'package:flutter_agenda/helpers/contact_helper.dart';

class ContactState extends Equatable {
  final bool saving;
  final Contact contact;

  ContactState({this.saving = false, this.contact});

  ContactState evolute({bool saving, String name, Contact contact}) {
    return ContactState(
      saving: saving ?? this.saving,
      contact: contact ?? this.contact,
    );
  }

  @override
  List<Object> get props => [saving, contact];
}
