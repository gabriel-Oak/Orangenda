import 'package:flutter/cupertino.dart';
import 'package:flutter_agenda/helpers/contact_helper.dart';

enum OrderOptions {
  asc,
  desc,
}

abstract class HomeEvent {}

class GetContacts extends HomeEvent {}

class RemoveContact extends HomeEvent {
  final Contact contact;
  final BuildContext context;
  RemoveContact({@required this.contact, @required this.context});
}

class OrderList extends HomeEvent {
  final OrderOptions order;
  OrderList(this.order);
}
