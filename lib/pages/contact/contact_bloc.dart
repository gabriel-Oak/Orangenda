import 'package:flutter_agenda/pages/contact/contact_event.dart';
import 'package:flutter_agenda/pages/contact/contact_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc() : super(ContactState());

  @override
  Stream<ContactState> mapEventToState(ContactEvent event) async* {
    if (event is ChangeNameContact) {
      yield state.evolute(name: event.name);
    } else if (event is SaveContact) {
      yield state.evolute(saving: true);
    }
  }
}
