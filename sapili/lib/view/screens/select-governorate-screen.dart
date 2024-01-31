import 'package:get/get.dart';
import 'package:sapili/main.dart';
import '../../constant/colors.dart';
import '../widgets/aladhan-comp.dart';
import 'package:flutter/material.dart';
import '../widgets/last-surah-comp.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sapili/constant/governorates.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../controller/navigationcontroller.dart';
import '../../controller/governoratescontroller.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sapili/controller/aladhancontroller.dart';
// ignore_for_file: prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables, implementation_imports, unnecessary_import, sort_child_properties_last

class SelectGovernorateScreen extends StatelessWidget {
  const SelectGovernorateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GovernorateController>(
      init: GovernorateController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: mainLightColor,
          appBar: AppBar(
            backgroundColor: mainColor,
            title: Text(
              'اختيار محافظتك',
              style: TextStyle(fontFamily: 'ArbFONTS'),
            ),
          ),
          body: ListView.builder(
            itemCount: governoratesList.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 3),
                margin: EdgeInsets.symmetric(vertical: 5),
                color: Colors.white,
                child: ListTile(
                  trailing: sharedPreferences!.getString('selectedGover') ==
                          governoratesList[index]
                      ? Icon(
                          Icons.check_circle,
                          color: mainColor,
                        )
                      : null,
                  onTap: () {
                    sharedPreferences!.setString(
                        'selectedGover', governoratesList[index].toString());
                    print(sharedPreferences!.getString('selectedGover'));
                    controller.updateGoverS();
                    controller.updateGoverS();
                  },
                  subtitle: Text(
                    'اختر المحافظة',
                    style: TextStyle(fontFamily: 'ArbFONTS'),
                  ),
                  leading: Icon(
                    Icons.location_on,
                    color: mainColor,
                  ),
                  title: Text(
                    '${governoratesList[index]}',
                    style: TextStyle(fontFamily: 'ArbFONTS'),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
