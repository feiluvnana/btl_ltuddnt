bool validateMarkSyntax(String text) {
  if (!text.startsWith("[T]") && !text.startsWith("[F]")) return false;
  if (text.substring(3).isEmpty) return false;
  return true;
}

int getTypeFromMarkSyntax(String text) {
  if (text.startsWith("[T]")) return 1;
  return 0;
}
