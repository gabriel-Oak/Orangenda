import 'package:flutter/cupertino.dart';

enum HomeTypes { getContacts }

abstract class HomeEvent {
  // final dynamic payload;
  // HomeTypes _type;
  // HomeTypes get type => _type;

  // HomeEvent.getContacts({this.payload}) {
  //   this._type = HomeTypes.getContacts;
  // }
}

class GetContacts extends HomeEvent {}
