import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:transportapp/transport_model.dart';
import 'package:equatable/equatable.dart';

part 'transport_event.dart';
part 'transport_state.dart';

class TransportBloc extends Bloc<TransportEvent, TransportState> {
  TransportBloc()
      : super(TransportListInitial(transfers: Transfer.transfersList)) {
    on<LoadTransfers>(_loadTransfers);
    on<AddTransfer>(_addTransfer);
    on<DeleteTransfer>(_deleteTransfer);
    on<UpdateTransfer>(_updateTransfer);
    print('tutaj');
  }

  void _loadTransfers(LoadTransfers event, Emitter<TransportState> emit) async {
    await Future<void>.delayed(const Duration(seconds: 1));

    // state.transfers.add(event.transfer);
    // emit(TransportListInitial(transfers: state.transfers));
    emit(TransportListInitial(transfers: Transfer.transfersList));
  }

  void _addTransfer(AddTransfer event, Emitter<TransportState> emit) {
    // state.transfers.add(event.transfer);
    final state = this.state as TransportListInitial;
    // emit(TransportListInitial(transfers: state.transfers));
    final data = List.of(state.transfers)..remove(event.transfer);
    emit(TransportListInitial(transfers: data));
  }

  void _deleteTransfer(DeleteTransfer event, Emitter<TransportState> emit) {
    // state.transfers.remove(event.transfer);
    final state = this.state as TransportListInitial;
    final data = List.of(state.transfers)..remove(event.transfer);
    emit(TransportListInitial(transfers: data));
    // print(state.transfers);
    // print('usuwam');
  }

  void _updateTransfer(UpdateTransfer event, Emitter<TransportState> emit) {
    // print(state.transfers);
    // for (int i = 0; i < state.transfers.length; i++) {
    //   if (event.transfer.id == state.transfers[i].id) {
    //     state.transfers[i] = event.transfer;
    //   }
    final state = this.state as TransportListInitial;
    // }
    // emit(TransportListInitial(transfers: state.transfers));
    final data = List.of(state.transfers)..remove(event.transfer);
    emit(TransportListInitial(transfers: data));
  }
}
