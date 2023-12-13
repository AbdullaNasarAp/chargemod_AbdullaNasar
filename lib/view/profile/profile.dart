import 'package:abdulla_nasar/controller/profile_controller.dart';
import 'package:abdulla_nasar/model/profile_tile_model.dart';
import 'package:abdulla_nasar/utils/hex_colors.dart';
import 'package:abdulla_nasar/utils/reusable_widget.dart';
import 'package:abdulla_nasar/view/profile/widget/top_status_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController =
        Provider.of<ProfileController>(context, listen: false);

    profileController.fetchData();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Consumer<ProfileController>(
          builder: (context, pCtrl, child) {
            return Column(
              children: [
                text(
                  giveText: "Hello",
                  fontsize: 12,
                  fontweight: FontWeight.w500,
                ),
                pCtrl.isLoading == true
                    ? const SizedBox()
                    : text(
                        giveText: "${pCtrl.firstName}",
                      ),
              ],
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const TopStatusCard(),
              SizedBox(
                  width: double.infinity,
                  height: 280,
                  child: Card(
                    elevation: 3,
                    color: Colors.white,
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: profileTilesData.length,
                      separatorBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Divider(
                            color: HexColor("666766"),
                          ),
                        );
                      },
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: HexColor("EBEBEB"),
                            child: Image.asset(
                              profileTilesData[index].img,
                            ),
                          ),
                          title: text(giveText: profileTilesData[index].title),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                        );
                      },
                    ),
                  )),
              kHeight(15),
              RawMaterialButton(
                onPressed: () async {},
                child: Container(
                  width: double.infinity,
                  height: 38,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: HexColor("E6740C"),
                  ),
                  child: Center(
                    child: text(
                      giveText: "Buy Machines From chargeMOD",
                      fontsize: 16,
                      textColor: Colors.white,
                    ),
                  ),
                ),
              ),
              kHeight(15),
              SizedBox(
                  width: double.infinity,
                  height: 140,
                  child: Card(
                    elevation: 3,
                    color: Colors.white,
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: profileTilesData1.length,
                      separatorBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Divider(
                            color: HexColor("666766"),
                          ),
                        );
                      },
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: HexColor("EBEBEB"),
                            child: Image.asset(
                              profileTilesData1[index].img,
                            ),
                          ),
                          title: text(giveText: profileTilesData1[index].title),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                        );
                      },
                    ),
                  )),
              kHeight(15),
              SizedBox(
                  width: double.infinity,
                  height: 280,
                  child: Card(
                    elevation: 3,
                    color: Colors.white,
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: profileTilesData2.length,
                      separatorBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Divider(
                            color: HexColor("666766"),
                          ),
                        );
                      },
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: HexColor("EBEBEB"),
                            child: Image.asset(
                              profileTilesData2[index].img,
                            ),
                          ),
                          title: text(giveText: profileTilesData2[index].title),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                        );
                      },
                    ),
                  )),
              kHeight(15),
              Consumer<ProfileController>(
                builder: (context, pCtrl, child) {
                  return RawMaterialButton(
                    onPressed: () async {
                      pCtrl.logout(context);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 38,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: HexColor("E6740C"),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/logout.png"),
                          kWidth(10),
                          text(
                            giveText: "Logout",
                            fontsize: 16,
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              kHeight(30),
              Image.asset(
                "assets/images/end.png",
                height: 30,
                width: 30,
              ),
              kHeight(20),
              text(giveText: 'V 1.0.0 (001)', textColor: HexColor("666766")),
              kHeight(20),
              text(
                  giveText:
                      'Copyright © 2022 BPM Power Pvt Ltd.\n                  All rights reserved.',
                  textColor: HexColor("666766")),
              kHeight(20),
            ],
          ),
        ),
      ),
    );
  }
}

List<ProfileTileModel> profileTilesData = [
  ProfileTileModel(img: "assets/images/payment.png", title: "My Payments"),
  ProfileTileModel(
      img: "assets/images/vehicle.png", title: "My Electric Vehicles"),
  ProfileTileModel(
      img: "assets/images/favorite.png", title: "My Favourite Stations"),
  ProfileTileModel(img: "assets/images/alpha.png", title: "Alpha Membership"),
];
List<ProfileTileModel> profileTilesData1 = [
  ProfileTileModel(img: "assets/images/device.png", title: "My Devices"),
  ProfileTileModel(img: "assets/images/order.png", title: "My Orders"),
];
List<ProfileTileModel> profileTilesData2 = [
  ProfileTileModel(img: "assets/images/help.png", title: "Help"),
  ProfileTileModel(
      img: "assets/images/complaint.png", title: "Raise Complaint"),
  ProfileTileModel(img: "assets/images/about.png", title: "About Us"),
  ProfileTileModel(
      img: "assets/images/privacypolicy.png", title: "Privacy Policy"),
];
