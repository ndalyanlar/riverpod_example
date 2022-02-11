import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'utility/padding.dart';
import 'core/note_page_view_modal.dart';
import 'core/slider_view_model.dart';
import 'page/note_page.dart';
import 'theme/color.dart';
import 'widget/note_list.dart';
import 'utility/contant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Riverpod Demo',
        theme: ThemeData(),
        home: const MyHomePage(),
      ),
    );
  }
}

final pageStatusProvider =
    ChangeNotifierProvider(((ref) => NotePageViewModel()));
final valueProvider = ChangeNotifierProvider((ref) => SliderProvider());

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColor.instance.scaffoldBackgroundColor,
      appBar: buildAppBar(context, ref),
      body: buildBody(ref),
      floatingActionButton: buildConsumer(),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: ref.watch(pageStatusProvider).pageStatus
          ? FloatingActionButtonLocation.endFloat
          : FloatingActionButtonLocation.centerFloat,
    );
  }

  AppBar buildAppBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: ref.read(pageStatusProvider).pageStatus
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                ref.watch(pageStatusProvider).changePageStatus();
                Navigator.of(context).pop();
              },
            )
          : null,
      backgroundColor: AppColor.instance.appBarColor,
      title: Text(Constant.instance.kTitle),
    );
  }

  Padding buildBody(WidgetRef ref) {
    return Padding(
      padding: const BodyPadding().padding,
      child: NoteList(list: ref.watch(pageStatusProvider)),
    );
  }

  Consumer buildConsumer() {
    return Consumer(
      builder: ((context, ref, child) {
        final _provider = ref.watch(pageStatusProvider);

        return buildFloatingActionButton(_provider, context);
      }),
    );
  }

  FloatingActionButton buildFloatingActionButton(
      NotePageViewModel _provider, BuildContext context) {
    return FloatingActionButton(
      onPressed: !_provider.pageStatus
          ? () {
              _provider.changePageStatus();
              navigatePage(context, _provider);
            }
          : () {
              _provider.changePageStatus();
              Navigator.pop(context);
            },
      child: _provider.pageStatus
          ? const Icon(Icons.close)
          : const Icon(Icons.add),
      backgroundColor: _provider.pageStatus
          ? AppColor.instance.closeFloatButtonColor
          : AppColor.instance.appBarColor,
    );
  }

  PersistentBottomSheetController<dynamic> navigatePage(
      BuildContext context, NotePageViewModel _provider) {
    return showBottomSheet(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
        context: context,
        builder: (_) => NotePage(
              provider: _provider,
            ));
  }
}
