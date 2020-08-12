class SciPaper {
  SciPaper(this.title, this.abstract);
  factory SciPaper.fromJson(Map<String, dynamic> json) {
    return SciPaper(json['title'], json['abstract']);
  }

  final String title;
  final String abstract;
}
