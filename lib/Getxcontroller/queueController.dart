import 'package:coba_coba/singleton_connection.dart';
import 'package:dart_amqp/dart_amqp.dart';
import 'package:get/get.dart';

class QueueController extends GetxController
    with StateMixin<List<QueueModelController>> {
  RxList<QueueModelController> queueList = <QueueModelController>[].obs;
  @override
  void onInit() {
    super.onInit();
  }

  OnBindQT(String routingKey) {
    RabbitMqConnection.exchangesrealtime('QT.*.*');
  }
}

class QueueModelController {
  final String queueName;
  QueueModelController({required this.queueName});
}
