class MessageItem {
  MessageItem(this.cid, this.data, this.pending);
  // message cid
  final String cid;
  // create time
  final DateTime addTime = DateTime.now();
  // status, true: should wait
  final bool pending;
  final dynamic data;
}
