part of 'transport_bloc.dart';

@immutable
abstract class TransportState {
  List<Transfer> transfers = [];

  TransportState({required this.transfers});
}

final class TransportListInitial extends TransportState {
  final List<Transfer> transfers;

  TransportListInitial({required this.transfers}) : super(transfers: transfers);
  @override
  List<Object> get props => [transfers];
}

class TransportListUpdated extends TransportState {
  TransportListUpdated({required List<Transfer> transfers})
      : super(transfers: transfers);

  @override
  List<Object> get props => [transfers];
}
