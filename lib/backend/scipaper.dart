class SciPaper {
  SciPaper(this.title, this.abstract);
  String title;
  String abstract;
}

List<SciPaper> generateSciPapers() {
  List<SciPaper> result = [];
  result.add(SciPaper('TITLE 0', 'ABSTRACT 0'));
  return result;
}
