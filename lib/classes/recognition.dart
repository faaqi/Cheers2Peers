class Recognition {
  Recognition({
    this.fromEmail,
    this.toEmail,
    this.fromName,
    this.toName,
    this.points,
    this.postTitle,
    this.time,
    this.likes = 0,
    this.fromImgAddress,
    this.fromJob,
  });

  String fromJob;
  String fromImgAddress;
  int likes;
  String time;
  String fromEmail;
  String toEmail;
  String postTitle;
  String fromName;
  String toName;
  int points;
}
