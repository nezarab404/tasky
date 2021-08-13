class Data {
  int _id;
  String _title;
  int _proirty;
  int _date;
  int _isDone;
  String _category;

  Data(this._title, this._proirty, this._date, this._isDone,this._category);
  Data.withID(this._id, this._title, this._proirty, this._date,this._isDone,this._category);

  int get id => _id;
  String get title => _title;
  int get proirty => _proirty;
  int get date => _date;
  int get isDone => _isDone;

  set title(String value) {
    if (value.length <= 255) _title = value;
  }

  set date(int value) => _date = value;

  set proirty(int value) {
    if (value >= 1 && value <= 3) _proirty = value;
  }

  set(int value) => _isDone = value;

  Map<String, dynamic> tomap() {
    var map = Map<String, dynamic>();

    map["id"] = this._id;
    map["title"] = this._title;
    map["proirty"] = this._proirty;
    map["date"] = this._date;
    map["isDone"] = this._isDone;
    map["category"] = this._category;    
    return map;
  }

  Data.fromMap(Map<String, dynamic> map) {
    this._id = map["id"];
    this._title = map["title"];
    this._proirty = map["proirty"];
    this._date = map["date"];
    this._isDone = map["isDone"];
    this._category = map["category"];
  }

}
