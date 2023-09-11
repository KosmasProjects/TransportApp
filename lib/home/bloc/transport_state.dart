part of 'transport_bloc.dart';

@immutable
abstract class TransportState extends Equatable {
  const TransportState();
  // List<Transfer> transfers = [];

  // TransportState({required this.transfers});
  @override
  List<Object> get props => [];
}

class TransportInitial extends TransportState {}

final class TransportListInitial extends TransportState {
  final List<Transfer> transfers;

  TransportListInitial({required this.transfers});
  @override
  List<Object> get props => [transfers];
}

// class TransportListUpdated extends TransportState {
//   TransportListUpdated({required List<Transfer> transfers})
//       : super(transfers: transfers);

//   @override
//   List<Object> get props => [transfers];
// }
