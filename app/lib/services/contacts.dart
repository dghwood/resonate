import 'package:flutter/foundation.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:resonate/models/models.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class AbstractContactsService {
  Future<bool> get hasPermission;
  Future<Iterable<UserContact>> getContacts();
  Future<bool> requestPermission();
}

class MockContacts implements AbstractContactsService {
  MockContacts();

  bool _hasPermission = false;

  @override
  Future<bool> get hasPermission async {
    return _hasPermission;
  }

  @override
  Future<bool> requestPermission() async {
    await Future.delayed(Duration(seconds: 5));
    _hasPermission = true;
    return true;
  }

  @override
  Future<Iterable<UserContact>> getContacts() async {
    var phoneNumbers = [
      '1234567890',
      '0987654321',
      '1111111111',
      '2222222222',
      '3333333333',
    ];

    return phoneNumbers.map((e) => UserContact(id: e, phoneNumber: e));
  }
}

class Contacts implements AbstractContactsService {
  Contacts();

  @override
  Future<bool> get hasPermission async {
    var status = await Permission.contacts.status;
    return _permissionFromStatus(status);
  }

  bool _permissionFromStatus(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        return true;
      // Some of these I think are not relevant.
      case PermissionStatus.denied:
      case PermissionStatus.provisional:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        return false;
    }
  }

  @override
  Future<bool> requestPermission() async {
    if (await hasPermission) return true;
    return _permissionFromStatus(await Permission.contacts.request());
  }

  @override
  Future<Iterable<UserContact>> getContacts() async {
    if (kIsWeb) {
      throw Exception("not support on web");
    }
    // Don't request permission, let is fail if no permission.
    var contacts = await FlutterContacts.getContacts(withProperties: true);
    return contacts.expand(
      (contact) => contact.phones.map(
        (phone) => UserContact(id: contact.id, phoneNumber: phone.number),
      ),
    );
  }
}
