class Request {
  String endpoint;
  Map<String, dynamic> data;

  Request(this.endpoint, this.data);
}

class Response {
  int statusCode;
  dynamic data;

  Response(this.statusCode, this.data);
}

class Node {
  dynamic data;
  Node? next;

  Node(this.data);
}

class LinkedList {
  Node? head;
  Node? tail;

  void enqueue(dynamic data) {
    Node newNode = Node(data);
    if (head == null) {
      head = newNode;
      tail = newNode;
    } else {
      tail!.next = newNode;
      tail = newNode;
    }
  }

  dynamic dequeue() {
    if (head == null) {
      return null;
    }
    dynamic data = head!.data;
    head = head!.next;
    return data;
  }

  bool isEmpty() {
    return head == null;
  }
}
