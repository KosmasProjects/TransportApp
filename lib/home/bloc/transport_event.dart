part of 'transport_bloc.dart';

@immutable
abstract class TransportEvent extends Equatable {
  TransferEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadTransfers extends TransportEvent {
  @override
  TransferEvent() {
    // TODO: implement TransferEvent
    throw UnimplementedError();
  }
}

class AddTransfer extends TransportEvent {
  final Transfer transfer;

  AddTransfer(this.transfer);

  @override
  TransferEvent() {
    // TODO: implement TransferEvent
    throw UnimplementedError();
  }

  @override
  // TODO: implement props
  List<Object?> get props => [transfer];
}

class DeleteTransfer extends TransportEvent {
  final Transfer transfer;

  DeleteTransfer(this.transfer);

  @override
  TransferEvent() {
    // TODO: implement TransferEvent
    throw UnimplementedError();
  }

  @override
  // TODO: implement props
  List<Object?> get props => [transfer];
}

class UpdateTransfer extends TransportEvent {
  final Transfer transfer;

  UpdateTransfer(this.transfer);

  @override
  // TODO: implement props
  List<Object?> get props => [transfer];

  @override
  TransferEvent() {
    // TODO: implement TransferEvent
    throw UnimplementedError();
  }
}
