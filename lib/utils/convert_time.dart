String convertTime(String sentDateString) {
  final sentDate = DateTime.parse(sentDateString);

  final now = DateTime.now();
  final difference = now.difference(sentDate);

  if (difference.inDays == 1) {
    return 'Há ${difference.inDays} dia atrás';
  } else if (difference.inDays > 1) {
    return 'Há ${difference.inDays} dias atrás';
  } else if (difference.inHours == 1) {
    return 'Há ${difference.inHours} hora atrás';
  } else if (difference.inHours > 1) {
    return 'Há ${difference.inHours} horas atrás';
  } else if (difference.inMinutes == 1) {
    return 'Há ${difference.inMinutes} minuto atrás';
  } else if (difference.inMinutes > 1) {
    return 'Há ${difference.inMinutes} minutos atrás';
  } else {
    return 'Há menos de um minuto';
  }
}
