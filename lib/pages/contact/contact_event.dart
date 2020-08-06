abstract class ContactEvent {}

class SaveContact extends ContactEvent {}

class ChangeNameContact extends ContactEvent {
  final String name;
  ChangeNameContact(this.name);
}
