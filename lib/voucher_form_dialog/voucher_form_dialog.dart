import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/app_scaffold/app_scaffold.dart';
import 'package:vouchervault/models/voucher.dart';
import 'package:vouchervault/voucher_form/voucher_form.dart';

class VoucherFormDialog extends StatefulWidget {
  VoucherFormDialog({
    Key key,
    this.initialValue = const None(),
  }) : super(key: key);

  final Option<Voucher> initialValue;

  @override
  _VoucherFormDialogState createState() => _VoucherFormDialogState();
}

class _VoucherFormDialogState extends State<VoucherFormDialog> {
  final _formKey = GlobalKey<FormBuilderState>();

  String get _title =>
      widget.initialValue.isNone() ? 'Add voucher' : 'Edit voucher';

  String get _action => widget.initialValue.isNone() ? 'Create' : 'Update';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      leading: true,
      title: _title,
      slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(
            horizontal: AppTheme.space4,
          ),
          sliver: SliverToBoxAdapter(
            child: VoucherForm(
              formKey: _formKey,
              initialValue: widget.initialValue | Voucher(),
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
              child: Text(_action),
              onPressed: () {
                if (_formKey.currentState.saveAndValidate()) {
                  final voucher =
                      Voucher.fromFormValue(_formKey.currentState.value);
                  Navigator.pop(context, voucher);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
