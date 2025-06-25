import 'package:intl/intl.dart';

String formatToLocalDate(String isoUtcDateString, {String locale = 'id_ID'}) {
  try {
    final utcDateTime = DateTime.parse(isoUtcDateString);
    final localDateTime = utcDateTime.toLocal();
    String formattedDate = DateFormat('dd MMM yyyy').format(localDateTime);
    return formattedDate;
  } catch (e) {
    return isoUtcDateString; // return original if parsing fails
  }
}
