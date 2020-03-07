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

  @action
  Future toggleRead(Issue issue) async {
    if (issue.read) {
      await _markIssueAsUnread(issue);
    } else {
      await _markIssueAsRead(issue);
    }
  }

  Future _markIssueAsRead(Issue issue) async {
    final updated = await webService.updateIssueSettings(issue, true);

    if (updated) {
      final comic = comics.firstWhere((comic) => comic.issues.contains(issue));

      comic.markIssueAsRead(issue);
    }
  }

  Future _markIssueAsUnread(Issue issue) async {
    final updated = await webService.updateIssueSettings(issue, false);

    if (updated) {
      final comic = comics.firstWhere((comic) => comic.issues.contains(issue));

      comic.markIssueAsUnread(issue);
    }
  }
}
