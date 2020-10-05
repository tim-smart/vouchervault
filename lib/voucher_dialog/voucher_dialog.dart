import 'package:barcode_widget/barcode_widget.dart';
import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:screen/screen.dart';

import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/models/models.dart';
import 'package:vouchervault/voucher_list/voucher_item.dart';

class VoucherDialog extends StatefulWidget {
  final Voucher voucher;
  final void Function(Voucher) onEdit;
  final VoidCallback onClose;
  final void Function(Voucher) onRemove;

  const VoucherDialog({
    Key key,
    @required this.voucher,
    @required this.onEdit,
    @required this.onClose,
    @required this.onRemove,
  }) : super(key: key);

  @override
  _VoucherDialogState createState() => _VoucherDialogState();
}

class _VoucherDialogState extends State<VoucherDialog> {
  Option<double> _initialBrightness = const None();

  @override
  void initState() {
    super.initState();
    Screen.brightness.then((b) {
      _initialBrightness = some(b);
      Screen.setBrightness(1);
    });
  }

  @override
  void dispose() {
    _initialBrightness.map((b) => Screen.setBrightness(b));
    super.dispose();
  }

  List<Widget> _buildDetailRow(
    BuildContext context,
    Color textColor,
    IconData icon,
    String text, {
    Option<double> space = const None(),
  }) {
    final theme = Theme.of(context);

    return [
      SizedBox(height: space | AppTheme.space3),
      Row(children: [
        Icon(icon, size: AppTheme.rem(1), color: textColor),
        SizedBox(width: AppTheme.space2),
        Text(
          text,
          style: theme.textTheme.bodyText1.copyWith(
            color: textColor,
          ),
        ),
      ]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final color = voucherColor(widget.voucher.color);
    final textColor =
        color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
    var theme = Theme.of(context);
    theme = theme.copyWith(
      textTheme: theme.textTheme.apply(
        bodyColor: textColor,
        displayColor: textColor,
      ),
    );

    return Theme(
      data: theme,
      child: Padding(
        padding: EdgeInsets.all(AppTheme.space4),
        child: SizedBox(
          width: double.infinity,
          child: Material(
            elevation: 20,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTheme.rem(1)),
            ),
            color: color,
            child: Padding(
              padding: EdgeInsets.all(AppTheme.space4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.voucher.description,
                    style: theme.textTheme.headline3,
                  ),
                  ...widget.voucher.codeOption.fold(
                    () => [],
                    (data) => [
                      SizedBox(height: AppTheme.space3),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            AppTheme.rem(0.5),
                          ),
                          color: Colors.white,
                        ),
                        height: AppTheme.rem(7),
                        child: Padding(
                          padding: EdgeInsets.all(AppTheme.space4),
                          child: BarcodeWidget(
                            data: data,
                            style: theme.textTheme.bodyText2.copyWith(
                              color: Colors.black,
                            ),
                            barcode: Barcode.code128(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...widget.voucher.expiresOption.fold(
                    () => [],
                    (dt) => _buildDetailRow(
                      context,
                      textColor,
                      Icons.calendar_today,
                      dateFormat.format(dt),
                    ),
                  ),
                  ...widget.voucher.balanceOption.fold(
                      () => [],
                      (b) => _buildDetailRow(
                            context,
                            textColor,
                            Icons.account_balance,
                            '\$$b',
                          )),
                  SizedBox(height: AppTheme.space4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        color: textColor,
                        icon: Icon(Icons.delete),
                        onPressed: () => widget.onRemove(widget.voucher),
                      ),
                      SizedBox(width: AppTheme.space3),
                      RaisedButton(
                        color: theme.accentColor,
                        onPressed: () => widget.onEdit(widget.voucher),
                        child: Text('Edit'),
                      ),
                      SizedBox(width: AppTheme.space3),
                      RaisedButton(
                        color: Colors.white,
                        onPressed: widget.onClose,
                        child: Text('Close'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
