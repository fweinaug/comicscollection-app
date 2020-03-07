import 'package:comics_app/models/comic.dart';
import 'package:comics_app/models/issue.dart';
import 'package:comics_app/stores/comic_store.dart';
import 'package:comics_app/widgets/buttons.dart';
import 'package:flutter/material.dart' hide CloseButton;
import 'package:provider/provider.dart';

class EditSummaryDialog extends StatefulWidget {
  const EditSummaryDialog(
    this.comic,
    this.issue, {
    Key key,
  }) : super(key: key);

  final Comic comic;
  final Issue issue;

  @override
  _EditSummaryDialogState createState() => _EditSummaryDialogState();
}

class _EditSummaryDialogState extends State<EditSummaryDialog> {
  TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.issue.summary);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      elevation: 20.0,
      contentPadding: EdgeInsets.all(0.0),
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    if (widget.comic.series) Text(
                      widget.comic.name,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    Text(
                      widget.issue.title,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    TextField(
                      controller: _textEditingController,
                      minLines: 3,
                      maxLines: 10,
                      maxLength: 1000,
                      maxLengthEnforced: false,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(0),
                          labelText: 'Summary',
                          labelStyle: TextStyle(
                            color: Color(0xFFD6D6D6),
                          ),
                          hasFloatingPlaceholder: false,
                          alignLabelWithHint: true
                      ),
                    ),
                    RaisedButton(
                      onPressed: () async {
                        final store = Provider.of<ComicStore>(context, listen: false);
                        final updated = await store.updateIssue(widget.issue, _textEditingController.text);

                        if (updated) {
                          Navigator.pop(context);
                        }
                      },
                      highlightElevation: 5.0,
                      child: Text('Save changes'),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 10.0,
                right: 10.0,
                child: CloseButton(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
