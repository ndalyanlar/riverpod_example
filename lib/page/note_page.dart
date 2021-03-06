import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utility/padding.dart';
import '../core/note_model.dart';
import '../core/note_page_view_modal.dart';
import '../core/slider_view_model.dart';
import '../theme/color.dart';
import '../theme/theme.dart';

final valueProvider = ChangeNotifierProvider((ref) => SliderProvider());
final notePageProvider = ChangeNotifierProvider((ref) => NotePageViewModel());

TextEditingController _titleController = TextEditingController();
TextEditingController _descController = TextEditingController();

class NotePage extends StatelessWidget {
  final NotePageViewModel provider;
  const NotePage({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const BodyPadding().padding,
      child: buildForm(),
    );
  }

  Form buildForm() {
    return Form(
      child: Column(
        children: [
          buildTitleTextField(),
          const SizedBox(
            height: 5,
          ),
          buildDescTextField(),
          buildConsumer()
        ],
      ),
    );
  }

  Consumer buildConsumer() {
    return Consumer(builder: ((context, ref, child) {
      final _providerValue = ref.watch(valueProvider);

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildSlider(_providerValue),
          buildSliderText(_providerValue, context),
          buildSaveButton(_providerValue, context)
        ],
      );
    }));
  }

  Slider buildSlider(SliderProvider _providerValue) {
    return Slider(
      activeColor: AppColor.instance.appBarColor,
      inactiveColor: AppColor.instance.scaffoldBackgroundColor,
      value: _providerValue.value,
      max: 5,
      // divisions: 5,
      label: _providerValue.value.round().toString(),
      onChanged: (double value) {
        _providerValue.increaseSlider(value);
      },
    );
  }

  Align buildSaveButton(SliderProvider _providerValue, BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: ElevatedButton(
        style: ButtonStyle(
            alignment: AlignmentDirectional.center,
            fixedSize: MaterialStateProperty.all(const Size(85, 45)),
            backgroundColor: MaterialStateProperty.all(Colors.green)),
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
    );
  }

  Column buildSliderText(SliderProvider _providerValue, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(_providerValue.value.round().toString(),
            style: sliderChangeColor(context, _providerValue)),
        Text(
          "Seviye",
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    );
  }

  TextFormField buildDescTextField() {
    return TextFormField(
      controller: _descController,
      maxLines: 7,
      decoration: MyTheme.instance.myInputDecoration(
          labelText: "A????klama",
          hintText: "??lk A????klamam",
          borderColor: Colors.blue),
    );
  }

  TextFormField buildTitleTextField() {
    return TextFormField(
      controller: _titleController,
      decoration: MyTheme.instance.myInputDecoration(
          labelText: "Ba??l??k",
          hintText: "??lk Ba??l??????m",
          borderColor: Colors.blue,
          icon: const Icon(Icons.abc_outlined)),
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
