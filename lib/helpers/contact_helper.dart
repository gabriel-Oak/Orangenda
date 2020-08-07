import 'package:equatable/equatable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final contactTable = 'contact';
final idColumn = 'id';
final nameColumn = 'name';
final emailColumn = 'email';
final phoneColumn = 'phone';
final imgColumn = 'img';

class ContactHelper {
  static final ContactHelper _instance = ContactHelper.internal();

  ContactHelper.internal();

  factory ContactHelper() => _instance;

  Database _db;

  get db async {
    if (_db == null) _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'contacts.db');

    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE $contactTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $emailColumn TEXT, $phoneColumn TEXT, $imgColumn TEXT)',
      );
    });
  }

  Future<int> saveContact(Contact contact) async {
    Database database = await db;
    return await database.insert(contactTable, contact.toMap());
  }

  Future<Contact> getContact(int id) async {
    Database database = await db;
    List<Map> contactList = await database.query(
      contactTable,
      columns: [idColumn, nameColumn, phoneColumn, emailColumn, imgColumn],
      where: '$idColumn = ?',
      whereArgs: [id],
    );

    if (contactList.length > 0) return Contact.fromMap(contactList.first);
    return null;
  }

  Future<int> deletContact(int id) async {
    Database database = await db;
    return await database.delete(
      contactTable,
      where: '$idColumn = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateContact(Contact contact) async {
    Database database = await db;
    return await database.update(
      contactTable,
      contact.toMap(),
      where: '$idColumn = ?',
      whereArgs: [contact.id],
    );
  }

  Future<List<Contact>> getAllContacts() async {
    Database database = await db;
    List<Map> contactList = await database.rawQuery(
      'SELECT * FROM $contactTable ORDER BY $nameColumn ASC',
    );

    return contactList.map((contact) => Contact.fromMap(contact)).toList();
  }

  Future<int> getNumber() async {
    Database database = await db;
    return Sqflite.firstIntValue(await database.rawQuery(
      'SELECT COUNT (*) FROM $contactTable',
    ));
  }

  Future close() async {
    Database database = await db;
    await database.close();
  }
}

class Contact extends Equatable {
  int id;
  String name;
  String email;
  String phone;
  String img;

  Contact() {
    name = '';
  }

  Contact.fromMap(Map map) {
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    phone = map[phoneColumn];
    img = map[imgColumn];
  }

  Map<String, dynamic> toMap() {
    return {
      idColumn: id,
      nameColumn: name,
      emailColumn: email,
      phoneColumn: phone,
      imgColumn: img,
    };
  }

  Contact copyWith({id, name, phone, email, img}) => Contact.fromMap({
        idColumn: id ?? this.id,
        nameColumn: name ?? this.name,
        phoneColumn: phone ?? this.phone,
        emailColumn: email ?? this.email,
        imgColumn: img ?? this.img,
      });

  @override
  String toString() {
    return 'Contact:(id: $id, name: $name, phone: $phone, email: $email, img> $img)';
  }

  List<Object> get props => [id, name, phone, email, img];
}
