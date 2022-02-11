// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/core/note_page_view_modal.dart';
import 'package:riverpod_example/theme/color.dart';

class NoteList extends ConsumerWidget {
  NotePageViewModel list;
  NoteList({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return buildListViewB();
  }

  ListView buildListViewB() {
    return ListView.builder(
      itemCount: list.notes.length,
      itemBuilder: (BuildContext context, int index) {
        return buildPadding(index, context);
      },
    );
  }

  Padding buildPadding(int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: buildInkwell(index, context),
    );
  }

  InkWell buildInkwell(int index, BuildContext context) {
    return InkWell(
      onTap: null,
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: AppColor.instance.noteBackgroundColor,
          borderRadius: BorderRadiusDirectional.circular(12),
        ),
        child: buildNoteTitle(index, context),
      ),
    );
  }

  Padding buildNoteTitle(int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          list.notes[index].title,
          maxLines: 1,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
