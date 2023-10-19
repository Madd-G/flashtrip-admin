import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:untitled/controllers/transaction_controller.dart';
import 'package:untitled/models/transaction_model.dart';
import '../../../constants.dart';
import '../../../controllers/controllers.dart';
import '../../../models/user_model.dart';
import 'package:get/get.dart';

class TransactionInfo extends StatelessWidget {
  const TransactionInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final transactionController = Get.put(TransactionController());
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
                "Transactions",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              GestureDetector(
                onTap: () {
                  controller.currentIndex.value = 2;
                },
                child: Text(
                  'See All',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              )
            ],
          ),
          FutureBuilder<List<TransactionModel>>(
              future: transactionController.getAllTransaction(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      width: double.infinity,
                      height: 300,
                      child: DataTable2(
                        columnSpacing: defaultPadding,
                        minWidth: 600,
                        columns: const [
                          DataColumn(
                            label: Text("Booking Code"),
                          ),
                          DataColumn(
                            label: Text("Name"),
                          ),
                          DataColumn(
                            label: Text("Type"),
                          ),
                          DataColumn(
                            label: Text("Status"),
                          ),
                        ],
                        rows: List.generate(
                          snapshot.data!.length,
                          (index) => transactionDataRow(snapshot.data![index]),
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

DataRow transactionDataRow(userInfo) {
  return DataRow(
    cells: [
      DataCell(
        Text(userInfo.bookingCode),
      ),
      DataCell(Text(userInfo.productName)),
      DataCell(Text(userInfo.category)),
      DataCell(Text(userInfo.status)),
    ],
  );
}
