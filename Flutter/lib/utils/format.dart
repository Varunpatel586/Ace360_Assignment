/// Formats an amount with Indian digit grouping, e.g. 115498 -> ₹1,15,498.
String inr(num value, {bool withSymbol = true}) {
  final int amount = value.round();
  final String digits = amount.abs().toString();
  String tail = digits;
  String head = '';
  if (digits.length > 3) {
    tail = digits.substring(digits.length - 3);
    head = digits.substring(0, digits.length - 3);
  }
  final groups = <String>[];
  while (head.length > 2) {
    groups.insert(0, head.substring(head.length - 2));
    head = head.substring(0, head.length - 2);
  }
  if (head.isNotEmpty) groups.insert(0, head);
  final String body = groups.isEmpty ? tail : '${groups.join(',')},$tail';
  return '${withSymbol ? '₹' : ''}${amount < 0 ? '-' : ''}$body';
}
