import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TransactionDetail extends StatefulWidget {
  final int transactionId;
  const TransactionDetail({Key? key, required this.transactionId})
      : super(key: key);

  @override
  State<TransactionDetail> createState() => _TransactionDetailState();
}

class _TransactionDetailState extends State<TransactionDetail> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
