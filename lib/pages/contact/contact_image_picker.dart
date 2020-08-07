import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_agenda/pages/contact/contact_bloc.dart';
import 'package:flutter_agenda/pages/contact/contact_event.dart';
import 'package:flutter_agenda/pages/contact/contact_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ContactImagePicker extends StatelessWidget {
  final ContactState state;

  ContactImagePicker({@required this.state});

  @override
  Widget build(BuildContext c) {
    return BlocBuilder<ContactBloc, ContactState>(
      builder: (context, state) => GestureDetector(
        child: CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 76,
          child: state.contact.img == null
              ? Text(
                  state.contact.name != null && state.contact.name.length > 0
                      ? state.contact.name[0].toUpperCase()
                      : '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 54,
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(76),
                  child: Image(
                    image: FileImage(File(state.contact.img)),
                    fit: BoxFit.cover,
                    width: 152,
                    height: 152,
                  ),
                ),
        ),
        onTap: () => _pickImageSource(context),
      ),
    );
  }

  void _pickImageSource(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (c) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Text(
                'Completar ação usando:',
                style: TextStyle(fontSize: 22, color: Colors.grey),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      height: 120,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.camera_alt,
                              color: Colors.grey,
                              size: 48,
                            ),
                            Text(
                              'Câmera',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ),
                    onTap: () => _pickImage(context, ImageSource.camera),
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 16)),
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      height: 120,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.picture_in_picture,
                              color: Colors.grey,
                              size: 48,
                            ),
                            Text(
                              'Galeria',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ),
                    onTap: () => _pickImage(context, ImageSource.gallery),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future _pickImage(BuildContext context, ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final PickedFile pickedFile = await picker.getImage(source: source);

    if (pickedFile != null)
      context.bloc<ContactBloc>().add(PickImageContact(pickedFile.path));
    Navigator.of(context).pop();
  }
}
