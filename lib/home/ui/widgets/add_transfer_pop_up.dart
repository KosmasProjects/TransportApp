import 'package:flutter/material.dart';
import 'package:transportapp/home/bloc/transport_bloc.dart';
import 'package:transportapp/home/ui/widgets/pop_up_topic.dart';
import 'package:transportapp/home/ui/widgets/texf_form_field.dart';
import 'package:transportapp/transport_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewTransferPopUp extends StatefulWidget {
  const AddNewTransferPopUp({super.key});

  @override
  State<AddNewTransferPopUp> createState() => _AddNewTransferPopUpState();
}

class _AddNewTransferPopUpState extends State<AddNewTransferPopUp> {
  TextEditingController headOutDestination = TextEditingController();
  TextEditingController arivalDestination = TextEditingController();
  TextEditingController dateInputHeadOut = TextEditingController();
  TextEditingController dateInputArrival = TextEditingController();
  TextEditingController dateInputID = TextEditingController();
  DateTime? headOutDate;
  DateTime? arivalDate;
  int indexOfType = 1;
  Map mapOfTransportTye = {
    1: TransportType.land,
    2: TransportType.water,
    3: TransportType.air
  };
  final TransportBloc transportBloc = TransportBloc();
  @override
  Widget build(BuildContext context) {
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
            ),
            SizedBox(height: 20),
            PopUpTopic(label: 'Write transfer ID'), SizedBox(height: 10),
            Container(
              width: 50,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: TextFormField(
                controller: dateInputID,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'id',
                  focusedBorder: null,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(8)),
              child: TextButton.icon(
                  style: TextButton.styleFrom(foregroundColor: Colors.white),
                  onPressed: () {
                    print(dateInputID);
                    final newtransfer = Transfer(
                        id: int.parse(dateInputID.text),
                        headOutDate: headOutDate as DateTime,
                        arivalDate: arivalDate as DateTime,
                        transportType: mapOfTransportTye[indexOfType],
                        headOutDestination: headOutDestination.text,
                        arivalDestination: arivalDestination.text);
                    context.read<TransportBloc>().add(AddTransfer(newtransfer));
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.check_circle),
                  label: Text('Save')),
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
