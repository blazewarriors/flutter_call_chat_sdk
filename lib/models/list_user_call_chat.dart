class ListUserCallChat {
  List<UserCallChat>? onlineUser;

  ListUserCallChat({this.onlineUser});

  ListUserCallChat.fromJson(Map<String, dynamic> json) {
    if (json['onlineUser'] != null) {
      onlineUser = <UserCallChat>[];
      json['onlineUser'].forEach((v) {
        onlineUser!.add(UserCallChat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (onlineUser != null) {
      data['onlineUser'] = onlineUser!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserCallChat {
  String? id;
  String? onlineUserId;
  String? connectionId;
  String? platform;
  String? userKey;
  String? userName;
  String? userEmail;
  String? userPhone;
  String? userAvatar;
  String? tokenFCM;
  String? tokenVoIP;
  String? moreData;
  bool? inCall;
  bool? isOnline;
  String? created;
  String? updated;

  UserCallChat(
      {this.id,
      this.onlineUserId,
      this.connectionId,
      this.platform,
      this.userKey,
      this.userName,
      this.userEmail,
      this.userPhone,
      this.userAvatar,
      this.tokenFCM,
      this.tokenVoIP,
      this.moreData,
      this.inCall,
      this.isOnline,
      this.created,
      this.updated});

  UserCallChat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    onlineUserId = json['onlineUserId'];
    connectionId = json['connectionId'];
    platform = json['platform'];
    userKey = json['userKey'];
    userName = json['userName'];
    userEmail = json['userEmail'];
    userPhone = json['userPhone'];
    userAvatar = json['userAvatar'];
    tokenFCM = json['tokenFCM'];
    tokenVoIP = json['tokenVoIP'];
    moreData = json['moreData'];
    inCall = json['inCall'];
    isOnline = json['isOnline'];
    created = json['created'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['onlineUserId'] = onlineUserId;
    data['connectionId'] = connectionId;
    data['platform'] = platform;
    data['userKey'] = userKey;
    data['userName'] = userName;
    data['userEmail'] = userEmail;
    data['userPhone'] = userPhone;
    data['userAvatar'] = userAvatar;
    data['tokenFCM'] = tokenFCM;
    data['tokenVoIP'] = tokenVoIP;
    data['moreData'] = moreData;
    data['inCall'] = inCall;
    data['isOnline'] = isOnline;
    data['created'] = created;
    data['updated'] = updated;
    return data;
  }
}
