import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agenda/helpers/contact_helper.dart';
import 'package:flutter_agenda/pages/contact/contact_event.dart';
import 'package:flutter_agenda/pages/contact/contact_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactHelper repository;
  ContactBloc({@required this.repository, contact})
      : super(ContactState(contact: contact ?? Contact()));

  @override
  Stream<ContactState> mapEventToState(ContactEvent event) async* {
    if (event is ChangeNameContact) {
      yield state.evolute(name: event.name);
    } else if (event is SaveContact) {
      yield state.evolute(saving: true);

      try {
        int result;
        if (event.contact.id == null)
          result = await repository.saveContact(event.contact);
        else
          result = await repository.updateContact(event.contact);

        yield state.evolute(saving: false);
        if (result == null) {
          _displayContactError(event);
        } else {
          final snack = SnackBar(
            content: Text('Contato ${event.contact.name}, salvo!'),
            duration: Duration(seconds: 5),
          );

          Scaffold.of(event.context).removeCurrentSnackBar();
          Scaffold.of(event.context).showSnackBar(snack);
        }
      } catch (e) {
        yield state.evolute(saving: false);
        print(e);
        _displayContactError(event);
      }
    }
  }

  void _displayContactError(SaveContact event) {
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
