import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../constants.dart';
import '../../../controllers/controllers.dart';
import '../../../controllers/profile_controller.dart';
import '../../../models/user_model.dart';
import 'package:get/get.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());
    final Controllers controller = Get.put<Controllers>(Controllers());

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Users",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              GestureDetector(
                onTap: () {
                  controller.currentIndex.value = 1;
                },
                child: Text(
                  'See All',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              )
            ],
          ),
          FutureBuilder<List<UserModel>>(
              future: profileController.getAllUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      width: double.infinity,
                      height: 300,
                      child: DataTable2(
                        columnSpacing: defaultPadding,
                        minWidth: 1100,
                        columns: const [
                          DataColumn(
                            label: Text("Username"),
                          ),
                          DataColumn(
                            label: Text("Email"),
                          ),  DataColumn(
                            label: Text("Gender"),
                          ),
                          DataColumn(
                            label: Text("Registration Date"),
                          ),
                        ],
                        rows: List.generate(
                          snapshot.data!.length,
                          (index) => userDataRow(snapshot.data![index]),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error.toString()}');
                  } else {
                    return const Text('Error');
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ],
      ),
    );
  }
}

DataRow userDataRow(userInfo) {
  var dateTime = userInfo.timestamp.toDate();
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            SvgPicture.asset(
              'assets/icons/menu_profile.svg',
              height: 30,
              width: 30,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(userInfo.username),
            ),
          ],
        ),
      ),
      DataCell(Text(userInfo.email)),
      DataCell(Text(userInfo.gender)),
      DataCell(Text(
          '${(dateTime.day < 10) ? "0${dateTime.day.toString()}" : dateTime.day.toString()} ${DateFormat('MMMM').format(DateTime(0, dateTime.month))} ${dateTime.year.toString()}')),
    ],
  );
}
