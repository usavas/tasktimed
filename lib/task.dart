class Task {
  String? uid;
  String? title;
  int? minSeconds;
  int? maxSeconds;
  int? elapsedSeconds;

  Task(
      {this.uid,
      this.title,
      this.minSeconds,
      this.maxSeconds,
      this.elapsedSeconds});

  void countDown() {
    // start count down
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'title': title,
        'minSeconds': minSeconds,
        'maxSeconds': maxSeconds,
        'elapsedSeconds': elapsedSeconds
      };

  Task.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        title = json['title'],
        minSeconds = json['minSeconds'],
        maxSeconds = json['maxSeconds'],
        elapsedSeconds = json['elapsedSeconds'];

  Task copyWith({String? title, int? minSeconds, int? maxSeconds}) {
    return Task(
      uid: this.uid,
      title: title ?? this.title,
      minSeconds: minSeconds ?? this.minSeconds,
      maxSeconds: maxSeconds ?? this.maxSeconds,
    );
  }
}
