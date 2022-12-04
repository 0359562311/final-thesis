import 'package:fakeslink/app/viewmodel/create_job/create_job_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedAddressPage extends StatefulWidget {
  const SelectedAddressPage({Key? key}) : super(key: key);

  @override
  State<SelectedAddressPage> createState() => _SelectedAddressPageState();
}

class _SelectedAddressPageState extends State<SelectedAddressPage> {
  late CreateJobCubit _cubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubit = CreateJobCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
