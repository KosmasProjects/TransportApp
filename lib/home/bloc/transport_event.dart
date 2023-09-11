part of 'transport_bloc.dart';

@immutable
abstract class TransportEvent {}

class AddTransfer extends TransportEvent {
  final Transfer transfer;

  AddTransfer({required this.transfer});
}

class DeleteTransfer extends TransportEvent {
  final Transfer transfer;

  DeleteTransfer({required this.transfer});
}

class UpdateTransfer extends TransportEvent {
  final Transfer transfer;

  UpdateTransfer({required this.transfer});
}
