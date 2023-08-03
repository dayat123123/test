import 'package:dart_amqp/dart_amqp.dart';

class RabbitMqConnectionNode {
  Channel connection;
  RabbitMqConnectionNode? next;

  RabbitMqConnectionNode(this.connection);
}

class RabbitMqConnectionLinkedList {
  RabbitMqConnectionNode? head;
  static late Channel channel;

  void addConnection(Channel connection) {
    RabbitMqConnectionNode newNode = RabbitMqConnectionNode(connection);
    if (head == null) {
      head = newNode;
    } else {
      RabbitMqConnectionNode? temp = head;
      while (temp?.next != null) {
        temp = temp?.next;
      }
      temp?.next = newNode;
    }
    channel = connection;
  }

  void removeConnection(Channel connection) {
    if (head == null) return;

    if (head?.connection == connection) {
      head = head?.next;
      connection.close();
    } else {
      RabbitMqConnectionNode? temp = head;
      while (temp?.next != null) {
        if (temp?.next?.connection == connection) {
          temp?.next = temp.next?.next;
          connection.close();
          break;
        }
        temp = temp?.next;
      }
    }
  }

  void closeAllConnections() {
    RabbitMqConnectionNode? temp = head;
    while (temp != null) {
      temp.connection?.close();
      temp = temp.next;
    }
    head = null;
  }

  void addrequest() {}
}
