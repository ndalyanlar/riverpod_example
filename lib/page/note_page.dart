import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/modal_view.dart';
import '../core/note_page_view_modal.dart';
import '../core/slider_view_model.dart';
import '../theme/color.dart';
import '../theme/theme.dart';

final valueProvider = ChangeNotifierProvider((ref) => SliderProvider());
final notePageProvider = ChangeNotifierProvider((ref) => NotePageViewModel());

TextEditingController _titleController = TextEditingController();
TextEditingController _descController = TextEditingController();

class NotePage extends StatelessWidget {
  NotePageViewModel provider;
  NotePage({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.all(30),
      child: Form(
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: MyTheme.instance.myInputDecoration(
                  labelText: "Başlık",
                  hintText: "İlk Başlığım",
                  borderColor: Colors.blue,
                  icon: const Icon(Icons.abc_outlined)),
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: _descController,
              maxLines: 7,
              decoration: MyTheme.instance.myInputDecoration(
                  labelText: "Açıklama",
                  hintText: "İlk Açıklamam",
                  borderColor: Colors.blue),
            ),
            Consumer(builder: ((context, ref, child) {
              final _providerValue = ref.watch(valueProvider);

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Slider(
                    activeColor: AppColor.instance.appBarColor,
                    inactiveColor: AppColor.instance.scaffoldBackgroundColor,
                    value: _providerValue.value,
                    max: 5,
                    // divisions: 5,
                    label: _providerValue.value.round().toString(),
                    onChanged: (double value) {
                      _providerValue.increaseSlider(value);
                    },
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(_providerValue.value.round().toString(),
                          style: sliderChangeColor(context, _providerValue)),
                      Text(
                        "Seviye",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          alignment: AlignmentDirectional.center,
                          fixedSize:
                              MaterialStateProperty.all(const Size(85, 45)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green)),
                      onPressed: () {
                        MyNote note = MyNote(
                            title: _titleController.text,
                            desc: _descController.text,
                            priority: _providerValue.value.toInt());

                        provider.addNote(note);
                        provider.changePageStatus();
                        _titleController.clear();
                        _descController.clear();
                        _providerValue.increaseSlider(0);
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.done),
                    ),
                  )
                ],
              );
            }))
          ],
        ),
      ),
    );
  }

  TextStyle sliderChangeColor(
      BuildContext context, SliderProvider sliderProvider) {
    switch (sliderProvider.value.round()) {
      case 0:
        return Theme.of(context)
            .textTheme
            .headline3!
            .copyWith(color: Colors.grey);

      case 1:
        return Theme.of(context)
            .textTheme
            .headline3!
            .copyWith(color: Colors.lightBlue);

      case 2:
        return Theme.of(context)
            .textTheme
            .headline3!
            .copyWith(color: Colors.green);

      case 3:
        return Theme.of(context)
            .textTheme
            .headline3!
            .copyWith(color: Colors.orange);

      case 4:
        return Theme.of(context)
            .textTheme
            .headline3!
            .copyWith(color: Colors.redAccent);
      case 5:
        return Theme.of(context)
            .textTheme
            .headline3!
            .copyWith(color: Colors.red);
      default:
        return Theme.of(context).textTheme.headline3!;
    }
  }
}
