import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/app_scaffold/app_scaffold.dart';
import 'package:vouchervault/hooks/hooks.dart';
import 'package:vouchervault/models/voucher.dart';
import 'package:vouchervault/voucher_form/voucher_form.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

part 'voucher_form_dialog.g.dart';

@hwidget
Widget voucherFormDialog(BuildContext context,
    {Option<Voucher> initialValue = const None()}) {
  final formKey = useFormKey();
  final title = initialValue.fold(() => 'Add voucher', (_) => 'Edit voucher');
  final action = initialValue.fold(() => 'Create', (_) => 'Update');

  return AppScaffold(
    leading: true,
    title: title,
    slivers: [
      SliverPadding(
        padding: EdgeInsets.symmetric(
          horizontal: AppTheme.space4,
        ),
        sliver: SliverToBoxAdapter(
          child: VoucherForm(
            formKey: formKey,
            initialValue: initialValue | Voucher(),
          ),
        ),
      ),
      SliverPadding(
        padding: EdgeInsets.only(
          bottom: AppTheme.space5,
          left: AppTheme.space4,
          right: AppTheme.space4,
          top: AppTheme.space3,
        ),
        sliver: SliverToBoxAdapter(
          child: RaisedButton(
            child: Text(action),
            onPressed: () {
              if (formKey.currentState.saveAndValidate()) {
                final voucher =
                    Voucher.fromFormValue(formKey.currentState.value);
                Navigator.pop(context, voucher);
              }
            },
          ),
        ),
      ),
    ],
  );
}

// class VoucherFormDialog extends StatefulWidget {
//   VoucherFormDialog({
//     Key key,
//     this.initialValue = const None(),
//   }) : super(key: key);

//   final Option<Voucher> initialValue;

//   @override
//   _VoucherFormDialogState createState() => _VoucherFormDialogState();
// }

// class _VoucherFormDialogState extends State<VoucherFormDialog> {
//   final _formKey = GlobalKey<FormBuilderState>();

//   String get _title =>
//       widget.initialValue.isNone() ? 'Add voucher' : 'Edit voucher';

//   String get _action => widget.initialValue.isNone() ? 'Create' : 'Update';

//   @override
//   Widget build(BuildContext context) {
//     return AppScaffold(
//       leading: true,
//       title: _title,
//       slivers: [
//         SliverPadding(
//           padding: EdgeInsets.symmetric(
//             horizontal: AppTheme.space4,
//           ),
//           sliver: SliverToBoxAdapter(
//             child: VoucherForm(
//               formKey: _formKey,
//               initialValue: widget.initialValue | Voucher(),
//             ),
//           ),
//         ),
//         SliverPadding(
//           padding: EdgeInsets.only(
//             bottom: AppTheme.space5,
//             left: AppTheme.space4,
//             right: AppTheme.space4,
//             top: AppTheme.space3,
//           ),
//           sliver: SliverToBoxAdapter(
//             child: RaisedButton(
//               child: Text(_action),
//               onPressed: () {
//                 if (_formKey.currentState.saveAndValidate()) {
//                   final voucher =
//                       Voucher.fromFormValue(_formKey.currentState.value);
//                   Navigator.pop(context, voucher);
//                 }
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
