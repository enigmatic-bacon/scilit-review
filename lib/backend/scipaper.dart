import 'paperTitles.dart';

class SciPaper {
  SciPaper(this.title, this.abstract);
  factory SciPaper.fromJson(Map<String, dynamic> json) {
    return SciPaper(json['title'], json['abstract']);
  }

  final String title;
  final String abstract;
}

List<SciPaper> generateSciPapers() {
  List<SciPaper> result = List(paperTitles.length);
  for (int i = 0; i < paperTitles.length; ++i) {
    result[i] = SciPaper(paperTitles[i], 'ABSTRACT 0');
  }

  return result;
}
