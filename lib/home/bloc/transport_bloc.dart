import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:transportapp/transport_model.dart';

part 'transport_event.dart';
part 'transport_state.dart';

class TransportBloc extends Bloc<TransportEvent, TransportState> {
  TransportBloc()
      : super(TransportListInitial(transfers: Transfer.transfersList)) {
    on<AddTransfer>(_addTransfer);
    on<DeleteTransfer>(_deleteTransfer);
    on<UpdateTransfer>(_updateTransfer);
    print('tutaj');
  }
  void _addTransfer(AddTransfer event, Emitter<TransportState> emit) {
    state.transfers.add(event.transfer);
    emit(TransportListUpdated(transfers: state.transfers));
  }

  void _deleteTransfer(DeleteTransfer event, Emitter<TransportState> emit) {
    state.transfers.remove(event.transfer);
    emit(TransportListUpdated(transfers: state.transfers));
    print(state.transfers);
    print(state);
  }

  void _updateTransfer(UpdateTransfer event, Emitter<TransportState> emit) {
    print(state.transfers);
    for (int i = 0; i < state.transfers.length; i++) {
      if (event.transfer.id == state.transfers[i].id) {
        state.transfers[i] = event.transfer;
      }
    }
    emit(TransportListUpdated(transfers: state.transfers));
  }
}
