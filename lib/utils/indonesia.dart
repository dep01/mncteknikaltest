import 'package:intl/intl.dart';

/// Convert value to "Rp XX.XXX.XXX" as [String]
String rupiah(value, {String separator = '.', String trailing = ''}) {
  return "Rp " +
      value.toString().replaceAllMapped(
          new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}${separator}') +
      trailing;
}

/// Convert [DateTime] to Indonesia specific date
String tanggal(DateTime date, {bool shortMonth = false}) {
  if (date != null)
    return "${date.day} ${_convertToLocalMonth(date.month, shortMonth)} ${date.year}";
  return "";
}

String convertUTCtoLocal(String date, {bool humanRead = true}) {
  var strToDateTime = DateTime.parse(date);
  final localTime = strToDateTime.toLocal();
  var newFormat = DateFormat("yyyy-MM-dd");
  String updatedDt = newFormat.format(localTime);
  if (humanRead) {
    return tanggal(DateTime.parse(updatedDt));
  } else {
    return updatedDt;
  }
}

String capitalized(String str) {
  String lowercase = str.substring(1).toLowerCase();
  return "${str[0].toUpperCase() + lowercase}";
}

List _longMonth = [
  'Januari',
  'Februari',
  'Maret',
  'April',
  'Mei',
  'Juni',
  'Juli',
  'Agustus',
  'September',
  'Oktober',
  'November',
  'Desember'
];
List _shortMonth = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'Mei',
  'Jun',
  'Jul',
  'Agu',
  'Sep',
  'Okt',
  'Nov',
  'Des'
];

String _convertToLocalMonth(int month, bool shortMonth) {
  if (shortMonth) return _shortMonth[month - 1];
  return _longMonth[month - 1];
}

/// Get Only Month Name from [DateTime]
String bulan(DateTime date) {
  return _convertToLocalMonth(date.month, false);
}

String formatPhoneNumber(String val) {
  String form;
  if (val != null) {
    String num = val.substring(0, 2);
    if (num == "62") {
      form = "0" + val.substring(2, val.length);
    } else {
      form = val;
    }
  }

  return form;
}
