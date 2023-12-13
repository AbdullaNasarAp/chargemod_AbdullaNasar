import 'package:abdulla_nasar/utils/hex_colors.dart';
import 'package:abdulla_nasar/utils/reusable_widget.dart';
import 'package:flutter/material.dart';

class TopStatusCard extends StatelessWidget {
  const TopStatusCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            "assets/images/user_card.png",
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text(
                    giveText: "Total Energy Balance ",
                    fontsize: 12,
                    textColor: HexColor("666766")),
                kHeight(5),
                text(
                    giveText: "99999 kWH",
                    fontsize: 20,
                    fontweight: FontWeight.w900,
                    textColor: HexColor("2E2E2D")),
                kHeight(5),
                text(
                    giveText: "Added 100 kWH on 20/11/2022",
                    fontsize: 12,
                    textColor: HexColor("666766")),
                kHeight(20),
                RawMaterialButton(
                  onPressed: () {},
                  child: Container(
                    height: 24,
                    width: 126,
                    decoration: BoxDecoration(
                      color: HexColor("4EAD2B"),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 17,
                        ),
                        kWidth(5),
                        text(
                          giveText: "Add Energy",
                          fontsize: 12,
                          textColor: HexColor("FFFFFF"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            kWidth(10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/badge.png",
                  fit: BoxFit.cover,
                  height: 80,
                ),
                kHeight(15),
                RawMaterialButton(
                  onPressed: () {},
                  child: Container(
                    height: 24,
                    width: 126,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/coin.png"),
                        kWidth(10),
                        text(
                          giveText: "55 Points",
                          fontsize: 12,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
