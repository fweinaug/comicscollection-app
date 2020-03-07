import 'package:comics_app/models/comic.dart';
import 'package:comics_app/models/issue.dart';
import 'package:comics_app/services/web_service.dart';
import 'package:mobx/mobx.dart';

part 'comic_store.g.dart';

class ComicStore = _ComicStoreBase with _$ComicStore;

abstract class _ComicStoreBase with Store {
  final WebService webService;

  ObservableList<Comic> comics = ObservableList<Comic>();

  @observable
  int issuesCount = 0;

  @computed
  FutureStatus get initializeStatus => _initializeFuture.status;

  ObservableFuture _initializeFuture;

  _ComicStoreBase(this.webService) {
    _initializeFuture = ObservableFuture(initialize());
  }

  Future initialize() async {
    await Future.wait([
      _loadComics(),
      Future.delayed(Duration(milliseconds: 1000)),
    ]);
  }

  Future _loadComics() async {
    final loadedComics = await webService.getComics();

    comics.addAll(loadedComics);
    issuesCount = comics.fold(0, (count, comic) => count += comic.issuesCount);
  }

  void toggleRead(Issue issue) {
    final comic = comics.firstWhere((comic) => comic.issues.contains(issue));

    if (issue.read) {
      comic.markIssueAsRead(issue);
    } else {
      comic.markIssueAsUnread(issue);
    }
  }
}
