import 'package:flutter/material.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/voucher_form/voucher_form.dart';

class VouchersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: AppTheme.rem(5),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding: EdgeInsetsDirectional.only(
                start: AppTheme.space4,
                bottom: AppTheme.rem(0.5),
              ),
              title: Text(
                'Vouchers',
                style: theme.textTheme.headline2
                    .copyWith(fontSize: AppTheme.rem(1.2)),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: AppTheme.space4),
            sliver: SliverToBoxAdapter(child: VoucherForm()),
          ),
          SliverFillRemaining(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
