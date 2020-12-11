import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_bloc_stream/flutter_bloc_stream.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:share/share.dart';
import 'package:vouchervault/app/vouchers_bloc.dart';
import 'package:vouchervault/lib/files.dart' as files;
import 'package:vouchervault/vouchers/vouchers_menu/vouchers_menu.dart';

part 'vouchers_menu_container.g.dart';

@hwidget
Widget vouchersMenuContainer() {
  final bloc = useBlocStream<VouchersBloc>();
  final vouchersState = useBlocStreamState<VouchersBloc, VouchersState>();

  Future<void> import() => files.pick(['json']).then((f) => f
      .map((f) => String.fromCharCodes(f.bytes))
      .map(VoucherActions.import)
      .map(bloc.add));

  Future<void> export() => files
      .writeString('vouchervault.json', jsonEncode(vouchersState.toJson()))
      .then((file) => Share.shareFiles(
            [file.path],
            subject: "VoucherVault export",
          ));

  return VouchersMenu(onSelected: (action) {
    switch (action) {
      case VouchersMenuAction.EXPORT:
        export();
        break;
      case VouchersMenuAction.IMPORT:
        import();
        break;
    }
  });
}
