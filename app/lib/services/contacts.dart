import 'package:flutter/foundation.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

abstract class AbstractContactsService {
  Future<Iterable<String>> getPhoneNumbers();
}

class MockContacts implements AbstractContactsService {
  MockContacts();
  @override
  Future<Iterable<String>> getPhoneNumbers() async {
    await Future.delayed(Duration(seconds: 1));
    return [
      '1234567890',
      '0987654321',
      '1111111111',
      '2222222222',
      '3333333333',
    ];
  }
}

class Contacts implements AbstractContactsService {
  Contacts();

  bool _hasPermission = false;
  bool get hasPermission => _hasPermission;

  Future<bool> _requestPermission() async {
    _hasPermission = await FlutterContacts.requestPermission(readonly: true);
    return _hasPermission;
  }

  @override
  Future<Iterable<String>> getPhoneNumbers() async {
    if (kIsWeb) {
      throw Exception("not support on web");
    }
    if (!await _requestPermission()) {
      throw Exception("No permission");
    }
    var contacts = await FlutterContacts.getContacts(withProperties: true);
    return contacts.expand(
      (contact) => contact.phones.map((phone) => phone.number),
    );
  }
}
