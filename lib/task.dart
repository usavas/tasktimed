class Task {
  String? uid;
  String? title;
  int? minSeconds;
  int? maxSeconds;

  Task({
    this.uid,
    this.title,
    this.minSeconds,
    this.maxSeconds,
  });

  void countDown() {
    // start count down
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'title': title,
        'minSeconds': minSeconds,
        'maxSeconds': maxSeconds,
      };

  Task.fromJson(Map<String, dynamic> json)
      : uid = json['uid'] as String,
        title = json['title'] as String,
        minSeconds = json['minSeconds'] as int,
        maxSeconds = json['maxSeconds'] as int;

  Task copyWith({String? title, int? minSeconds, int? maxSeconds}) {
    return Task(
      uid: this.uid,
      title: title ?? this.title,
      minSeconds: minSeconds ?? this.minSeconds,
      maxSeconds: maxSeconds ?? this.maxSeconds,
    );
  }
}
