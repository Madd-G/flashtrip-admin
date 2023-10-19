import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../constants.dart';
import '../../../controllers/profile_controller.dart';
import '../../../models/user_model.dart';
import 'package:get/get.dart';

class UserListWidget extends StatelessWidget {
  const UserListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "User List",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          FutureBuilder<List<UserModel>>(
              future: profileController.getAllUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      width: double.infinity,
                      height: 800,
                      child: DataTable2(
                        columnSpacing: defaultPadding,
                        minWidth: 1250,
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
                            label: Text("Phone Number"),
                          ),
                          DataColumn(
                            label: Text("Origin"),
                          ),
                          DataColumn(
                            label: Text("KTP"),
                          ),
                          DataColumn(
                            label: Text("Registration Time"),
                          ),
                        ],
                        rows: List.generate(
                          snapshot.data!.length,
                          (index) => userListDataRow(snapshot.data![index]),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error ya: ${snapshot.error.toString()}');
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

DataRow userListDataRow(userInfo) {
  var dateTime = userInfo.timestamp.toDate();
  return DataRow(
    cells: [
      // DataCell(
      //   Row(
      //     children: [
      //       // SvgPicture.asset(
      //       //   fileInfo.icon!,
      //       //   height: 30,
      //       //   width: 30,
      //       // ),
      //       Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      //         child: Text(userInfo!.username),
      //       ),
      //     ],
      //   ),
      // ),
      DataCell(Text(userInfo.username)),
      DataCell(Text(userInfo.email)),
      DataCell(Text(userInfo.gender)),
      DataCell(Text(userInfo.phoneNumber)),
      DataCell(Text(userInfo.domicile)),
      DataCell(Text(userInfo.ktp)),
      DataCell(Text('${(dateTime.day < 10) ? "0${dateTime.day.toString()}" : dateTime.day.toString()} ${DateFormat('MMMM').format(DateTime(0, dateTime.month))} ${dateTime.year.toString()}')),
    ],
  );
}
