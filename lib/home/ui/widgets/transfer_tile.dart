import 'package:flutter/material.dart';
import 'package:transportapp/transport_model.dart';
import 'package:intl/intl.dart';
import 'package:transportapp/home/bloc/transport_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransferTile extends StatelessWidget {
  final transfer;
  Map mapOfIcons = {
    TransportType.land: Icon(Icons.directions_bus),
    TransportType.water: Icon(Icons.directions_boat),
    TransportType.air: Icon(Icons.airplanemode_active),
  };
  Map mapOfColors = {
    TransportType.land: Colors.orange,
    TransportType.water: Colors.blue,
    TransportType.air: Colors.white,
  };
  String _formatDateTime(DateTime dateTime) {
    return DateFormat.yMMMMd('en_US').format(dateTime);
  }

  TransferTile({super.key, this.transfer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Container(
        color: Colors.grey.withOpacity(.2),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 20,
                  height: 100,
                  color: mapOfColors[transfer.transportType],
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
                            Text(
                              _formatDateTime(transfer.arivalDate),
                              style: TextStyle(fontSize: 10),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Container(
                    color: mapOfColors[transfer.transportType],
                    width: 30,
                    height: 100,
                    child: Center(child: mapOfIcons[transfer.transportType]
                        //     Icon(
                        //   Icons.directions_bus,
                        //   color: Colors.black,
                        // )
                        )),
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
                          context
                              .read<TransportBloc>()
                              .add(DeleteTransfer(transfer));

                          // setState(() {});
                        },
                        icon: Icon(Icons.delete))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
