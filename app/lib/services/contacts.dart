import 'package:flutter_contacts/flutter_contacts.dart';

class Contacts {
  static Future<Iterable<String>> getPhoneNumbers() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      throw Exception("No permission");
    }
    var contacts = await FlutterContacts.getContacts(withProperties: true);
    return contacts.expand(
      (contact) => contact.phones.map((phone) => phone.number),
    );
  }
}
