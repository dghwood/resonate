import 'package:resonate/models/models.dart';

class SearchableModel<T extends BaseModel> {
  SearchableModel(this.model);
  final T model;

  Iterable<String> _getSearchableFields() {
    throw UnimplementedError();
  }

  bool search(String query) {
    if (query.isEmpty) return false;
    return _getSearchableFields().any(
      (text) => text.toLowerCase().contains(query.toLowerCase()),
    );
  }
}

class SearchableUserModel extends SearchableModel<PublicUser> {
  SearchableUserModel(super.model);

  @override
  Iterable<String> _getSearchableFields() {
    return [model.name];
  }
}

class SearchablePodcastModel extends SearchableModel<Podcast> {
  SearchablePodcastModel(super.model);

  @override
  Iterable<String> _getSearchableFields() {
    return [model.title];
  }
}
