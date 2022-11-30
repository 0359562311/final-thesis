class Certificates {
  String? From;
  String? to;
  String? description;
  String? title;

  Certificates({
    this.From,
    this.to,
    this.description,
    this.title,
  });
  Certificates.fromJson(Map<String, dynamic> json) {
    From = json['_from']?.toString();
    to = json['to']?.toString();
    description = json['description']?.toString();
    title = json['title']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_from'] = From;
    data['to'] = to;
    data['description'] = description;
    data['title'] = title;
    return data;
  }
}

class Experiences {
  String? From;
  String? to;
  String? description;

  Experiences({
    this.From,
    this.to,
    this.description,
  });
  Experiences.fromJson(Map<String, dynamic> json) {
    From = json['_from']?.toString();
    to = json['to']?.toString();
    description = json['description']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_from'] = From;
    data['to'] = to;
    data['description'] = description;
    return data;
  }
}

class Degrees {
  String? title;
  String? organization;
  int? year;

  Degrees({
    this.title,
    this.organization,
    this.year,
  });
  Degrees.fromJson(Map<String, dynamic> json) {
    title = json['title']?.toString();
    organization = json['organization']?.toString();
    year = json['year']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['organization'] = organization;
    data['year'] = year;
    return data;
  }
}

class ProfileResponse {
  int? id;
  String? name;
  String? dob;
  String? avatar;
  String? cover;
  String? gender;
  String? phoneNumber;
  String? createAt;
  String? updateAt;
  String? email;
  int? loyaltyPoint;
  String? bankAccount;
  List<Degrees?>? degrees;
  List<Experiences?>? experiences;
  List<Certificates?>? certificates;

  ProfileResponse({
    this.id,
    this.name,
    this.dob,
    this.avatar,
    this.cover,
    this.gender,
    this.phoneNumber,
    this.createAt,
    this.updateAt,
    this.email,
    this.loyaltyPoint,
    this.bankAccount,
    this.degrees,
    this.experiences,
    this.certificates,
  });
  ProfileResponse.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    name = json['name']?.toString();
    dob = json['dob']?.toString();
    avatar = json['avatar']?.toString();
    cover = json['cover']?.toString();
    gender = json['gender']?.toString();
    phoneNumber = json['phoneNumber']?.toString();
    createAt = json['createAt']?.toString();
    updateAt = json['updateAt']?.toString();
    email = json['email']?.toString();
    loyaltyPoint = json['loyaltyPoint']?.toInt();
    bankAccount = json['bankAccount']?.toString();
    if (json['degrees'] != null) {
      final v = json['degrees'];
      final arr0 = <Degrees>[];
      v.forEach((v) {
        arr0.add(Degrees.fromJson(v));
      });
      degrees = arr0;
    }
    if (json['experiences'] != null) {
      final v = json['experiences'];
      final arr0 = <Experiences>[];
      v.forEach((v) {
        arr0.add(Experiences.fromJson(v));
      });
      experiences = arr0;
    }
    if (json['certificates'] != null) {
      final v = json['certificates'];
      final arr0 = <Certificates>[];
      v.forEach((v) {
        arr0.add(Certificates.fromJson(v));
      });
      certificates = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['dob'] = dob;
    data['avatar'] = avatar;
    data['cover'] = cover;
    data['gender'] = gender;
    data['phoneNumber'] = phoneNumber;
    data['createAt'] = createAt;
    data['updateAt'] = updateAt;
    data['email'] = email;
    data['loyaltyPoint'] = loyaltyPoint;
    data['bankAccount'] = bankAccount;
    if (degrees != null) {
      final v = degrees;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['degrees'] = arr0;
    }
    if (experiences != null) {
      final v = experiences;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['experiences'] = arr0;
    }
    if (certificates != null) {
      final v = certificates;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['certificates'] = arr0;
    }
    return data;
  }
}
