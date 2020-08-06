import 'package:flutter/material.dart';
import 'package:flutter_agenda/helpers/contact_helper.dart';

class HomeState {
  final bool loading;
  final List<Contact> contactList;

  HomeState({@required this.contactList, this.loading = false});

  @override
  String toString() {
    return 'Home State(loading: $loading, ${contactList.toString()})';
  }
}
