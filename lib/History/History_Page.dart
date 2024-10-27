import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wikusamacafe/History/Succes.dart';
import 'package:wikusamacafe/MANAGER/History_manager/success_man.dart';

class TransactionHistoryPage extends StatelessWidget {
  const TransactionHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF016042),
          title: const Center(
            child: Text(
              "Transaction History",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                child: Text(
                  'Success',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
              Tab(
                child: Text(
                  'Failed',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            SuccessManager(),
            FailedTransactions(),
          ],
        ),
      ),
    );
  }
}

class FailedTransactions extends StatelessWidget {
  const FailedTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: const Text('No failed transactions available.'),
    );
  }
}
