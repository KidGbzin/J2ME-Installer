part of '../home_handler.dart';

class _Home extends StatelessWidget {
  const _Home();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: <Widget> [
            ValueListenableBuilder(
              valueListenable: _Notifier.of(context)!.isListView,
              builder: (BuildContext context, bool isListView, Widget? _) {
                if (isListView) {
                  return Button(
                    icon: Icons.list_rounded,
                    onTap: () => _Notifier.of(context)!.changeView(),
                  );
                }
                else {
                  return Button(
                    icon: Icons.grid_3x3_rounded,
                    onTap: () => _Notifier.of(context)!.changeView(),
                  );
                }
              }
            ),
          ],
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: _Notifier.of(context)!.isListView,
        builder: (BuildContext context, bool isListView, Widget? _) {
          if (isListView) {
            return _ListView(_Notifier.of(context)!.games);
          }
          else {
            return _GridView(_Notifier.of(context)!.games);
          }
        }
      ),
    );
  }
}