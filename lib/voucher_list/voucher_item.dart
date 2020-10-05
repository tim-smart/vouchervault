import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/models/voucher.dart';

final dateFormat = DateFormat('dd/MM/yyyy');

class VoucherItem extends StatelessWidget {
  final Voucher voucher;
  final VoidCallback onPressed;

  const VoucherItem({
    Key key,
    @required this.voucher,
    @required this.onPressed,
  }) : super(key: key);

  List<Widget> _buildDetailRow(
    BuildContext context,
    Color textColor,
    IconData icon,
    String text,
  ) {
    final theme = Theme.of(context);

    return [
      SizedBox(height: AppTheme.space2),
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
    final color = voucherColor(voucher.color);
    final textColor =
        color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
    final theme = Theme.of(context);

    return RaisedButton(
      padding: EdgeInsets.zero,
      elevation: 10,
      shape: RoundedRectangleBorder(),
      color: color,
      textColor: textColor,
      onPressed: onPressed,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppTheme.space4,
            vertical: AppTheme.space4,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(voucher.description,
                  style: theme.textTheme.headline3.copyWith(
                    color: textColor,
                  )),
              ...voucher.expiresOption.fold(
                  () => [],
                  (dt) => _buildDetailRow(
                        context,
                        textColor,
                        Icons.calendar_today,
                        dateFormat.format(dt),
                      )),
              ...voucher.balanceOption.fold(
                  () => [],
                  (b) => _buildDetailRow(
                        context,
                        textColor,
                        Icons.account_balance,
                        '\$$b',
                      )),
            ],
          ),
        ),
      ),
    );
  }
}
