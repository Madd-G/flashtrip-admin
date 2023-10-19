import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:untitled/controllers/transaction_controller.dart';
import 'package:untitled/models/transaction_model.dart';
import '../../../constants.dart';
import 'package:get/get.dart';

import '../../../controllers/controllers.dart';

class TransactionListWidget extends StatefulWidget {
  const TransactionListWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TransactionListWidget> createState() => _TransactionListWidgetState();
}

class _TransactionListWidgetState extends State<TransactionListWidget> {
  var items = [
    'Pending',
    'Success',
    'Failed',
  ];

  @override
  Widget build(BuildContext context) {
    final transactionController = Get.put(TransactionController());
    final controller = Get.put(Controllers());

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
            "Transaction List",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          FutureBuilder<List<TransactionModel>>(
              future: transactionController.getAllTransaction(),
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
                            label: Text("Booking Code"),
                          ),
                          DataColumn(
                            label: Text("Email"),
                          ),
                          DataColumn(
                            label: Text("Product Name"),
                          ),
                          DataColumn(
                            label: Text("Type"),
                          ),
                          DataColumn(
                            label: Text("Total Price"),
                          ),
                          DataColumn(
                            label: Text("Payment Method"),
                          ),
                          DataColumn(
                            label: Text("Status"),
                          ),
                        ],
                        rows: List.generate(
                          snapshot.data!.length,
                          (index) {
                            var userInfo = snapshot.data![index];
                            controller.currentStatus.value = userInfo.status;
                            final id = userInfo.id;
                            return DataRow(cells: [
                              DataCell(Text(userInfo.bookingCode)),
                              DataCell(Text(userInfo.email)),
                              DataCell(Text(userInfo.productName)),
                              DataCell(Text(userInfo.category)),
                              DataCell(Text(userInfo.totalPrice.toString())),
                              DataCell(Text(userInfo.paymentMethod)),
                              DataCell(
                                DropdownButton(
                                  value: userInfo.status,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: items.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) async {
                                    controller.currentStatus.value = newValue!;
                                    final transactionData = TransactionModel(
                                      id: id,
                                      userId: userInfo.userId,
                                      email: userInfo.email,
                                      bookingCode: userInfo.bookingCode,
                                      productName: userInfo.productName,
                                      category: userInfo.category,
                                      bookingDate: userInfo.bookingDate,
                                      paymentDeadline: userInfo.paymentDeadline,
                                      paymentMethod: userInfo.paymentMethod,
                                      price: userInfo.price,
                                      amount: userInfo.amount,
                                      totalPrice: userInfo.totalPrice,
                                      // status: newValue,
                                      status: controller.currentStatus.value,
                                    );
                                    await transactionController
                                        .updateRecord(transactionData);
                                    setState(() {});
                                  },
                                ),
                              ),
                            ]);
                          },
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

// DataRow transactionListDataRow(userInfo) {
//   final controller = Get.put(Controllers());
//
//   // controller.transactionStatus = 'pending'.obs;
//   var transactionStatus = ['success', 'failed'];
//
//   return DataRow(
//     cells: [
//       DataCell(Text(userInfo.email)),
//       DataCell(Text(userInfo.productName)),
//       DataCell(Text(userInfo.totalPrice.toString())),
//       DataCell(Text(userInfo.paymentMethod)),
//       DataCell(Text(userInfo.status)),
//       // DataCell(DropdownButton(
//       //   items: transactionStatus.map((String items) {
//       //     return DropdownMenuItem(
//       //       value: items,
//       //       child: Text(items),
//       //     );
//       //   }).toList(),
//       //   onChanged: (value) {
//       //     controller.transactionStatus.value = value!;
//       //   },
//       // )),
//     ],
//   );
// }
