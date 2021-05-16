class Advice {
  Slip slip = Slip();

  Advice({required this.slip});

  Advice.fromJson(Map<String, dynamic> json) {
    slip = (json['slip'] != null ? new Slip.fromJson(json['slip']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slip'] = this.slip.toJson();
    return data;
  }
}

class Slip {
  int slipId = 0;
  String advice = "";

  Slip({this.slipId = 0, this.advice = ""});

  Slip.fromJson(Map<String, dynamic> json) {
    slipId = json['id'];
    advice = json['advice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.slipId;
    data['advice'] = this.advice;
    return data;
  }
}
