import 'package:fakeslink/app/model/entities/job.dart';
import 'package:fakeslink/app/model/entities/user.dart';

class SameJobResponse {
  int? count;
  String? next;
  String? previous;
  List<Job?>? results;

  SameJobResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  SameJobResponse.fromJson(Map<String, dynamic> json) {
    count = json['count']?.toInt();
    next = json['next']?.toString();
    previous = json['previous']?.toString();
    if (json['results'] != null) {
      final v = json['results'];
      final arr0 = <Job>[];
      v.forEach((v) {
        arr0.add(Job.fromJson(v));
      });
      results = arr0;
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      final v = results;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['results'] = arr0;
    }
    return data;
  }
}
