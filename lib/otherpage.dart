import 'package:coba_coba/main.dart';
import 'package:coba_coba/makemessage.dart';
import 'package:coba_coba/queueController/requestQueue.dart';
import 'package:flutter/material.dart';

import 'constant.dart';

class OtherPage extends StatelessWidget {
  const OtherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Center(
              child: IconButton(
                onPressed: () {
                  // queuesRequest.addQueue(makeMassage.makeMassages(
                  //     "Test/001", Constans.PACKAGE_ID_BROKER_LIST));
                  // queuesRequest.addQueue(
                  //     makeMassage2.createIndexMemberListRequesr("TEST123",
                  //         Constans.PACKAGE_ID_MEMBER_OF_INDEX_LIST, "LQ45"));
                },
                icon: const Icon(Icons.add),
              ),
            )
          ],
        ),
      ),
    );
  }
}
