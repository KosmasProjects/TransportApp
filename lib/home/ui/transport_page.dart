import 'package:flutter/material.dart';
import 'package:transportapp/home/bloc/transport_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transportapp/home/ui/widgets/pop_up_topic.dart';
import 'package:transportapp/home/ui/widgets/texf_form_field.dart';
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
    String _formatDateTime(DateTime dateTime) {
      return DateFormat.yMMMMd('en_US').format(dateTime);
    }

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

  Widget buildDialogFullScreen(BuildContext context) {
    TextEditingController headOutDestination = TextEditingController();
    TextEditingController arivalDestination = TextEditingController();
    TextEditingController dateInputHeadOut = TextEditingController();
    TextEditingController dateInputArrival = TextEditingController();
    DateTime headOutDate;
    DateTime arivalDate;
    int indexOfType = 1;

    return Dialog.fullscreen(
      backgroundColor: Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Stack(children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Add next transport',
                  style: TextStyle(fontSize: 26),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                ),
              )
            ]),
            SizedBox(height: 20),
            PopUpTopic(label: 'Head out spot'),

            TextFormForTransfers(
              hint: 'head out spot',
              controller: headOutDestination,
            ),
            PopUpTopic(label: 'Arrival destination'),
            TextFormForTransfers(
              hint: 'arrival destination',
              controller: arivalDestination,
            ),
            PopUpTopic(label: 'Delivery time'),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: TextField(
                              controller: dateInputHeadOut,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.calendar_today,
                                  size: 20,
                                ), //icon of text field
                                labelText: "Head Out Date",
                                //label text of field
                              ),
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2100));

                                if (pickedDate != null) {
                                  //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate =
                                      DateFormat.yMMMMd('en_US')
                                          .format(pickedDate);

                                  headOutDate = pickedDate;
                                  //formatted date output using intl package =>  2021-03-16
                                  setState(() {
                                    dateInputHeadOut.text =
                                        formattedDate; //set output date to TextField value.
                                  });
                                } else {}
                              })),
                    ),
                  ),
                ),
                //arrival calendar
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: TextField(
                              controller: dateInputArrival,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.calendar_today,
                                  size: 20,
                                ), //icon of text field
                                labelText: "Arrival Date",
                                //label text of field
                              ),
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2100));

                                if (pickedDate != null) {
                                  //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate =
                                      DateFormat.yMMMMd('en_US')
                                          .format(pickedDate);

                                  arivalDate = pickedDate;
                                  //formatted date output using intl package =>  2021-03-16
                                  setState(() {
                                    dateInputArrival.text =
                                        formattedDate; //set output date to TextField value.
                                  });
                                } else {}
                              })),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            PopUpTopic(label: 'Type of transport'), SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: indexOfType == 1 ? Colors.green : Colors.grey,
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 8),
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              indexOfType = 1;
                              print(indexOfType);
                            });
                          },
                          icon: Icon(
                            Icons.directions_bus,
                            size: 30,
                            color: Colors.white,
                          )),
                    )),
                Container(
                    decoration: BoxDecoration(
                        color: indexOfType == 2 ? Colors.green : Colors.grey,
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 8),
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              indexOfType = 2;
                              print(indexOfType);
                            });
                          },
                          icon: Icon(
                            Icons.directions_boat,
                            size: 30,
                            color: Colors.white,
                          )),
                    )),
                Container(
                    decoration: BoxDecoration(
                        color: indexOfType == 3 ? Colors.green : Colors.grey,
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 8),
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              indexOfType = 3;
                              print(indexOfType);
                            });
                          },
                          icon: Icon(
                            Icons.airplanemode_active,
                            size: 30,
                            color: Colors.white,
                          )),
                    )),
              ],
            )
            // DatePickerDialog(
            //     initialDate: DateTime(2023),
            //     firstDate: DateTime(2023, 1, 1),
            //     lastDate: DateTime(2023, 12, 12))
          ],
        ),
      ),
    );
  }
}
