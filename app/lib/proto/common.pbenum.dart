// This is a generated file - do not edit.
//
// Generated from proto/common.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ClientPlatform extends $pb.ProtobufEnum {
  static const ClientPlatform CLIENT_PLATFORM_UNKNOWN =
      ClientPlatform._(0, _omitEnumNames ? '' : 'CLIENT_PLATFORM_UNKNOWN');
  static const ClientPlatform CLIENT_PLATFORM_ANDROID =
      ClientPlatform._(1, _omitEnumNames ? '' : 'CLIENT_PLATFORM_ANDROID');
  static const ClientPlatform CLIENT_PLATFORM_IOS =
      ClientPlatform._(2, _omitEnumNames ? '' : 'CLIENT_PLATFORM_IOS');
  static const ClientPlatform CLIENT_PLATFORM_WEB =
      ClientPlatform._(3, _omitEnumNames ? '' : 'CLIENT_PLATFORM_WEB');

  static const $core.List<ClientPlatform> values = <ClientPlatform>[
    CLIENT_PLATFORM_UNKNOWN,
    CLIENT_PLATFORM_ANDROID,
    CLIENT_PLATFORM_IOS,
    CLIENT_PLATFORM_WEB,
  ];

  static final $core.List<ClientPlatform?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static ClientPlatform? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ClientPlatform._(super.value, super.name);
}

class FeedItemType extends $pb.ProtobufEnum {
  static const FeedItemType FEED_ITEM_UNKNOWN =
      FeedItemType._(0, _omitEnumNames ? '' : 'FEED_ITEM_UNKNOWN');

  /// This item is in the feed, because it's subscribed.
  static const FeedItemType FEED_ITEM_SUBSCRIPTION =
      FeedItemType._(1, _omitEnumNames ? '' : 'FEED_ITEM_SUBSCRIPTION');

  /// This item is in the feed, because a friend listened
  /// to it.
  static const FeedItemType FEED_ITEM_FOLLOWER_LISTEN =
      FeedItemType._(2, _omitEnumNames ? '' : 'FEED_ITEM_FOLLOWER_LISTEN');

  static const $core.List<FeedItemType> values = <FeedItemType>[
    FEED_ITEM_UNKNOWN,
    FEED_ITEM_SUBSCRIPTION,
    FEED_ITEM_FOLLOWER_LISTEN,
  ];

  static final $core.List<FeedItemType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static FeedItemType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const FeedItemType._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
