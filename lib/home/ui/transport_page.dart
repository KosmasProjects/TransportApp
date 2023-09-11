import 'package:flutter/material.dart';
import 'package:transportapp/home/bloc/transport_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            print(state.transfers);
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
            } else if (state is TransportListUpdated &&
                state.transfers.isNotEmpty) {
              final transfers = state.transfers;
              return Container();
            }
            return Center(
              child: SizedBox(
                child: Text('nothing to show'),
              ),
            );
          },
        ));
  }

  @override
  Widget buildTransferTile(BuildContext context, transfer) {
    String _formatDateTime(DateTime dateTime) {
      return DateFormat.yMMMMd('en_US').format(dateTime);
    }

    return Container(
      color: Colors.grey.withOpacity(.2),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 20,
                height: 100,
                color: Colors.orange,
                child: Center(child: Text(transfer.id.toString())),
              ),
              SizedBox(width: 10),
              Container(
                width: MediaQuery.of(context).size.width * .5,
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          transfer.headOutDestination,
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          _formatDateTime(transfer.headOutDate),
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .1,
                      child: Icon(
                        Icons.arrow_forward,
                        size: 25,
                      ),
                    ),
                    Flexible(
                      child: Column(
                        children: [
                          Text(transfer.arivalDestination,
                              style: TextStyle(fontSize: 16)),
                          Text(_formatDateTime(transfer.arivalDate),
                              style: TextStyle(fontSize: 10)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Container(
                  color: Colors.orange,
                  width: 30,
                  height: 100,
                  child: Center(
                      child: Icon(
                    Icons.delivery_dining_outlined,
                    color: Colors.black,
                  ))),
              SizedBox(width: 10),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: IconButton.filled(
                      onPressed: () {}, icon: Icon(Icons.edit))),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: IconButton.outlined(
                      color: Colors.red,
                      onPressed: () {
                        transportBloc.add(DeleteTransfer(transfer: transfer));

                        print('Pressed');
                        // setState(() {});
                      },
                      icon: Icon(Icons.delete))),
            ],
          ),
        ],
      ),
    );
  }
}
