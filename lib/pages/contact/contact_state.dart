import 'package:equatable/equatable.dart';

class ContactState extends Equatable {
  final bool saving;
  final String name;

  ContactState({this.saving = false, this.name = ''});

  ContactState evolute({bool saving, String name}) {
    return ContactState(
      saving: saving ?? this.saving,
      name: name ?? this.name,
    );
  }

  @override
  List<Object> get props => [saving, name];
}
