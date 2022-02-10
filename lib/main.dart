import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      appBar: AppBar(
        backgroundColor: AppColor.instance.appBarColor,
        title: Text(Constant.instance.kTitle),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.all(30),
        child: NoteList(list: ref.watch(pageStatusProvider)),
      ),
      floatingActionButton: Consumer(
        builder: ((context, ref, child) {
          final _provider = ref.watch(pageStatusProvider);

          return FloatingActionButton(
            onPressed: !_provider.pageStatus
                ? () {
                    _provider.changePageStatus();
                    showBottomSheet(
                        constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.8),
                        context: context,
                        builder: (_) => NotePage(
                              provider: _provider,
                            ));
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
        }),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: ref.watch(pageStatusProvider).pageStatus
          ? FloatingActionButtonLocation.endFloat
          : FloatingActionButtonLocation.centerFloat,
    );
  }
}
