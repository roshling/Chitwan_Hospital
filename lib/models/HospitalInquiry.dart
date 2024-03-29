abstract class HospitalInquiryModel {
  String id;
  String userId;
  String hospitalId;
  String inquiry;
  String phone;
  String answer;
}

class HospitalInquiry implements HospitalInquiryModel {
  String id;
  String userId;
  String hospitalId;
  String title;
  String hospitalName;
  String inquiry;
  String phone;
  String answer;

  HospitalInquiry({
    this.phone,
    this.inquiry,
    this.hospitalId,
    this.userId,
    this.id,
    this.answer,
    this.title,
    this.hospitalName,
  });

  Map<String, String> toJson() => {
        'inquiry': inquiry,
        'phone': phone,
        'hospitalId': hospitalId,
        'title': title,
        'hospitalName': hospitalName,
        if (userId != null) 'userId': userId,
        if (id != null) 'id': id,
        if (answer != null) 'answer': answer,
      };

  HospitalInquiry.fromJson(json)
      : inquiry = json['inquiry'],
        phone = json['phone'],
        hospitalId = json['hospitalId'],
        userId = json['userId'],
        id = json['id'],
        answer = json['answer'],
        title = json['title'],
        hospitalName = json['hospitalName'];
}
