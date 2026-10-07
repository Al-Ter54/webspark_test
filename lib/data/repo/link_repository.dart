import 'package:webspark_test/data/source/link_local_datasource.dart';

class LinkRepositoryImpl extends LinkRepository {
  LinkRepositoryImpl(this._localDataSource);

  final LinkLocalDataSource _localDataSource;

  @override
  Future<void> saveLink(String url) {
    return _localDataSource.saveUrl(url);
  }

  @override
  Future<String?> getLink() async {
    return _localDataSource.getUrl();
  }
}

abstract class LinkRepository {
  Future<void> saveLink(String link);

  Future<String?> getLink();
}
