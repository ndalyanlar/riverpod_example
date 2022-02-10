import 'package:flutter/material.dart';

import 'note_model.dart';

class NotePageViewModel extends ChangeNotifier {
  bool _isOpened = false;

  bool get pageStatus => _isOpened;
  void changePageStatus() {
    _isOpened = !_isOpened;
    notifyListeners();
  }

  List<MyNote> notes = [];
  void addNote(MyNote myNote) {
    notes.add(myNote);
    notifyListeners();
  }
}
