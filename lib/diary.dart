class DiaryItem {
  int itemPrice;
  String items;

  DiaryItem(this.items, this.itemPrice);
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'item': items,
      'itemPrice': itemPrice,
    };
    return map;
  }

  DiaryItem.fromMap(Map<String, dynamic> map) {
    items = map['item'];
    itemPrice = map['itemPrice'];
  }
}
