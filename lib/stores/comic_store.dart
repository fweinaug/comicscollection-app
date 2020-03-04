import 'package:comics_app/models/comic.dart';
import 'package:comics_app/models/issue.dart';
import 'package:comics_app/models/publisher.dart';
import 'package:mobx/mobx.dart';

part 'comic_store.g.dart';

class ComicStore = _ComicStoreBase with _$ComicStore;

abstract class _ComicStoreBase with Store {
  ObservableList<Comic> comics = ObservableList<Comic>();

  int issuesCount;

  _ComicStoreBase() {
    comics.add(Comic()
      ..name = 'Secret'
      ..publisher = Publisher(name: 'Image', description: 'Description', website: 'https://imagecomics.com')
      ..issuesCount = 1
      ..issuesTotal = 1
      ..concluded = true
      ..issuesRead = 0
      ..issues = [
        Issue()
          ..number = 1
          ..title = 'Secret'
          ..summary = 'Summary'
          ..read = false,
      ],
    );
    comics.add(Comic()
      ..name = 'Southern Bastards'
      ..publisher = Publisher(name: 'Image', description: 'Description', website: 'https://imagecomics.com')
      ..issuesCount = 4
      ..issuesTotal = 4
      ..concluded = true
      ..issuesRead = 0
      ..issues = [
        Issue()
          ..number = 1
          ..title = 'Vol. 1: Here Was A Man'
          ..summary = 'Summary'
          ..read = false,
        Issue()
          ..number = 2
          ..title = 'Vol. 2: Gridiron'
          ..summary = 'Summary'
          ..read = false,
        Issue()
          ..number = 3
          ..title = 'Vol. 3: Homecoming'
          ..summary = 'Summary'
          ..read = false,
        Issue()
          ..number = 4
          ..title = 'Vol. 4: Gut Check'
          ..summary = 'Summary'
          ..read = false,
      ],
    );

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
