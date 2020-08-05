import 'package:flutter/material.dart';
import 'package:flutter_agenda/helpers/contact_helper.dart';
import 'package:flutter_agenda/pages/home/bloc.dart';
import 'package:bloc/bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ContactHelper repository;

  HomeBloc({@required this.repository})
      : super(HomeState(contactList: [], loading: true));

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is GetContacts) {
      try {
        final List<Contact> contactList = await repository.getAllContacts();
        yield HomeState(contactList: contactList);
      } catch (e) {
        print(e);
        yield HomeState(contactList: []);
      }
    }
  }
}
