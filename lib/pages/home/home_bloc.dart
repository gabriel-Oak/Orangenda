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
    } else if (event is RemoveContact) {
      try {
        final int result = await repository.deletContact(event.contact.id);
        if (result > 0) {
          this.add(GetContacts());
        }
      } catch (e) {
        print(e);
        _displayContactError(event);
      }
    } else if (event is OrderList) {
      if (event.order == OrderOptions.asc) {
        state.contactList.sort((a, b) => a.name.compareTo(b.name));
      } else {
        state.contactList.sort((a, b) => b.name.compareTo(a.name));
      }
      yield state.evolute();
    }
  }

  void _displayContactError(RemoveContact event) {
    final snack = SnackBar(
      content: Text('Ocorreu um erro ao salvar ${event.contact.name}'),
      duration: Duration(seconds: 5),
      action: SnackBarAction(
        label: 'Repetir',
        onPressed: () => this.add(event),
      ),
    );

    Scaffold.of(event.context).removeCurrentSnackBar();
    Scaffold.of(event.context).showSnackBar(snack);
  }
}
