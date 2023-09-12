import 'package:flutter/material.dart';
import 'package:transportapp/home/bloc/transport_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transportapp/home/ui/widgets/add_transfer_pop_up.dart';
import 'package:transportapp/home/ui/widgets/pop_up_topic.dart';
import 'package:transportapp/home/ui/widgets/texf_form_field.dart';
import 'package:transportapp/home/ui/widgets/transfer_tile.dart';
import 'package:transportapp/transport_model.dart';
import 'package:intl/intl.dart';

class TransportPage extends StatefulWidget {
  const TransportPage({super.key});

  @override
  State<TransportPage> createState() => _TransportPageState();
}

class _TransportPageState extends State<TransportPage> {
  final TransportBloc transportBloc = TransportBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transport Page'),
      ),
      body: BlocBuilder<TransportBloc, TransportState>(
        builder: (context, state) {
          print('State is updating');
          print(state);
          if (state is TransportListInitial && state.transfers.isNotEmpty) {
            final transfers = state.transfers;

            return ListView.builder(
              itemCount: transfers.length,
              itemBuilder: (context, index) {
                final transfer = transfers[index];
                // print(transfer);
                return buildTransferTile(context, transfer);
              },
            );
          }
          return Center(
            child: SizedBox(
              child: Text('nothing to show'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => buildDialogFullScreen(context));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  Widget buildTransferTile(BuildContext context, transfer) {
    return TransferTile(
      transfer: transfer,
    );
  }

  Widget buildDialogFullScreen(BuildContext context) {
    return AddNewTransferPopUp();
  }
}
