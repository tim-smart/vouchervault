import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/lib/lib.dart';
import 'package:vouchervault/models/voucher.dart';

class VoucherItem extends StatelessWidget {
  final Voucher voucher;
  final VoidCallback onPressed;

  const VoucherItem({
    Key key,
    @required this.voucher,
    @required this.onPressed,
  }) : super(key: key);

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
              ...buildVoucherDetails(
                context,
                voucher,
                textColor: textColor,
                space: some(AppTheme.space2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
