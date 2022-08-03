// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_scaffold.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class AppScaffold extends HookWidget {
  const AppScaffold(
      {Key? key,
      required this.title,
      required this.slivers,
      this.actions = const [],
      this.floatingActionButton = O.kNone,
      this.leading = false})
      : super(key: key);

  final String title;

  final List<Widget> slivers;

  final List<Widget> actions;

  final Option<Widget> floatingActionButton;

  final bool leading;

  @override
  Widget build(BuildContext _context) => appScaffold(_context,
      title: title,
      slivers: slivers,
      actions: actions,
      floatingActionButton: floatingActionButton,
      leading: leading);
}
