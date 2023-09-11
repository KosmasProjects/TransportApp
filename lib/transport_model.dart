import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum TransportType { land, water, air }

class Transfer extends Equatable {
  final int id;
  final TransportType transportType;
  final String headOutDestination;
  final String arivalDestination;
  final DateTime headOutDate;
  final DateTime arivalDate;

  const Transfer({
    required this.id,
    required this.headOutDate,
    required this.arivalDate,
    required this.transportType,
    required this.headOutDestination,
    required this.arivalDestination,
  });

  @override
  List<Object?> get props => [
        id,
        transportType,
        headOutDestination,
        arivalDestination,
        headOutDate,
        arivalDate
      ];

  static List<Transfer> transfersList = [
    Transfer(
      id: 1,
      headOutDate: DateTime(2023, 23, 8),
      arivalDate: DateTime(2023, 25, 8),
      transportType: TransportType.land,
      headOutDestination: 'Frankfurt',
      arivalDestination: 'Biadulice',
    ),
    Transfer(
      id: 2,
      headOutDate: DateTime(2023, 30, 8),
      arivalDate: DateTime(2023, 31, 8),
      transportType: TransportType.land,
      headOutDestination: 'Warszawa',
      arivalDestination: 'Poznan',
    ),
    Transfer(
      id: 3,
      headOutDate: DateTime(2023, 01, 9),
      arivalDate: DateTime(2023, 03, 9),
      transportType: TransportType.air,
      headOutDestination: 'Frankfurt',
      arivalDestination: 'Chicago',
    ),
    Transfer(
      id: 4,
      headOutDate: DateTime(2023, 03, 9),
      arivalDate: DateTime(2023, 06, 9),
      transportType: TransportType.water,
      headOutDestination: 'Gdansk',
      arivalDestination: 'Oslo',
    ),
    Transfer(
      id: 5,
      headOutDate: DateTime(2023, 23, 8),
      arivalDate: DateTime(2023, 25, 8),
      transportType: TransportType.land,
      headOutDestination: 'Berlin',
      arivalDestination: 'Warszawa',
    ),
  ];
}
