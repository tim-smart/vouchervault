import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/vouchers/vouchers.dart' as V;
import 'package:vouchervault/vouchers/vouchers.dart' show Voucher;
import 'package:vouchervault/shared/voucher_details/voucher_details.dart';

part 'voucher_item.g.dart';

const kVoucherItemBorderRadius = 15.0;

@swidget
Widget voucherItem(
  BuildContext context, {
  required V.Voucher voucher,
  required VoidCallback onPressed,
  double bottomPadding = 0,
}) {
  final color = V.color(voucher.color);
  final textColor =
      color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  final theme = Theme.of(context);

  return Stack(
    clipBehavior: Clip.none,
    children: [
      Positioned(
        bottom: -bottomPadding,
        left: 0,
        right: 0,
        top: 0,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kVoucherItemBorderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(150),
                offset: const Offset(0, 7),
                blurRadius: 20,
              ),
            ],
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: bottomPadding == 0
                    ? BorderRadius.circular(kVoucherItemBorderRadius)
                    : const BorderRadius.vertical(
                        top: Radius.circular(kVoucherItemBorderRadius),
                      ),
              ),
              primary: color,
              onPrimary: textColor,
            ).copyWith(
              elevation: MaterialStateProperty.all(0),
            ),
            onPressed: onPressed,
            child: Container(),
          ),
        ),
      ),
      IgnorePointer(
        child: Padding(
          padding: EdgeInsets.only(
            left: AppTheme.space4,
            right: AppTheme.space4,
            top: AppTheme.space4,
            bottom: AppTheme.space4,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                voucher.description,
                style: theme.textTheme.headline3!.copyWith(
                  color: textColor,
                ),
              ),
              if (voucher.hasDetails) ...[
                SizedBox(height: AppTheme.space2),
                ...buildVoucherDetails(
                  context,
                  voucher,
                  textColor: Color.alphaBlend(color.withAlpha(30), textColor),
                ),
              ]
            ],
          ),
        ),
      ),
    ],
  );
}
