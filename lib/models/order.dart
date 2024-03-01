class SessionModel {
  SessionModel({
    required this.Name,
    required this.id,
    required this.OrderId,
    required this.User_Pic,
    required this.User_Name,
    required this.User_Phone,
    required this.User_Time,
    required this.U1,
    required this.U2,
    required this.U3,
    required this.F1,
    required this.F2,
    required this.progress,
    required this.F3,
    required this.A1,
    required this.A2,
    required this.A3,
    required this.B1,
    required this.B2,
    required this.B3,
    required this.C1,
    required this.C2,
    required this.C3,
    required this.D1,
    required this.D2,
    required this.D3,
    required this.Last_Update,
    required this.Update_Status,
    required this.Update,
    required this.Email ,
    required this.st ,
  });

  late final String Name;
  late final String id;
  late final String OrderId;
  late final String User_Pic;
  late final String User_Name;
  late final String User_Phone;
  late final String User_Time;
  late final String U1;
  late final String U2;
  late final String U3;
  late final String F1;
  late final String F2;
  late final String F3;
  late final String A1;
  late final String A2;
  late final String A3;
  late final String B1;
  late final String B2;
  late final String B3;
  late final String C1;
  late final String C2;
  late final String C3;
  late final String D1;
  late final String D2;
  late final String D3;
  late final String Last_Update;
  late final String Update_Status;
  late final String Update;
  late final double progress ;
  late final String Email ;
  late final int st ;

  SessionModel.fromJson(Map<String, dynamic> json) {
    progress = json['progress'] ?? 30.0 ;
    Email = json['Email'] ?? "ghari@g.com" ;
    st = json['s'] ?? 0 ;
    Name = json['Name'] ?? 'samai';
    id = json['id'] ?? 'Xhqo6S2946pNlw8sRSKd';
    OrderId = json['OrderId'] ?? '';
    User_Pic = json['User_Pic'] ?? '';
    User_Name = json['User_Name'] ?? '';
    User_Phone = json['User_Phone'] ?? '';
    User_Time = json['User_Time'] ?? '';
    U1 = json['U1'] ?? '';
    U2 = json['U2'] ?? '';
    U3 = json['U3'] ?? '';
    F1 = json['F1'] ?? '';
    F2 = json['F2'] ?? '';
    F3 = json['F3'] ?? '';
    A1 = json['A1'] ?? '';
    A2 = json['A2'] ?? '';
    A3 = json['A3'] ?? '';
    B1 = json['B1'] ?? '';
    B2 = json['B2'] ?? '';
    B3 = json['B3'] ?? '';
    C1 = json['C1'] ?? '';
    C2 = json['C2'] ?? '';
    C3 = json['C3'] ?? '';
    D1 = json['D1'] ?? '';
    D2 = json['D2'] ?? '';
    D3 = json['D3'] ?? '';
    Last_Update = json['Last_Update'] ?? '';
    Update_Status = json['Update_Status'] ?? '';
    Update = json['Update'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['s'] = st;
    data['Email'] = Email ;
    data['progress'] = progress ;
    data['Name'] = Name;
    data['id'] = id;
    data['OrderId'] = OrderId;
    data['User_Pic'] = User_Pic;
    data['User_Name'] = User_Name;
    data['User_Phone'] = User_Phone;
    data['User_Time'] = User_Time;
    data['U1'] = U1;
    data['U2'] = U2;
    data['U3'] = U3;
    data['F1'] = F1;
    data['F2'] = F2;
    data['F3'] = F3;
    data['A1'] = A1;
    data['A2'] = A2;
    data['A3'] = A3;
    data['B1'] = B1;
    data['B2'] = B2;
    data['B3'] = B3;
    data['C1'] = C1;
    data['C2'] = C2;
    data['C3'] = C3;
    data['D1'] = D1;
    data['D2'] = D2;
    data['D3'] = D3;
    data['Last_Update'] = Last_Update;
    data['Update_Status'] = Update_Status;
    data['Update'] = Update;
    return data;
  }
}
