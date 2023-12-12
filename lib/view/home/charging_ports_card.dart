import 'package:abdulla_nasar/model/charging_port_model.dart';
import 'package:abdulla_nasar/utils/hex_colors.dart';
import 'package:abdulla_nasar/utils/reusable_widget.dart';
import 'package:flutter/material.dart';

class ChargingPortCard extends StatelessWidget {
  const ChargingPortCard({
    super.key,
    required this.index,
  });
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
          shadowColor: HexColor("000000"),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 6,
          color: Colors.white,
          borderOnForeground: true,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text(
                    giveText: chargingPorts[index].name,
                    fontsize: 12,
                    fontweight: FontWeight.bold),
                text(
                  giveText: chargingPorts[index].location,
                  fontsize: 10,
                ),
              ],
            ),
          )),
    );
  }
}

List<ChargingPortModel> chargingPorts = [
  ChargingPortModel(
      location: "Vellariyil Garden building, Tavarekere, Kaveri Layout, S.G. P",
      name: "AC001 Exicom"),
  ChargingPortModel(
      location: "Vellariyil Garden building, Tavarekere, Kaveri Layout, S.G. P",
      name: "AC001 Exicom"),
  ChargingPortModel(
      location: "Vellariyil Garden building, Tavarekere, Kaveri Layout, S.G. P",
      name: "AC001 Exicom"),
];
