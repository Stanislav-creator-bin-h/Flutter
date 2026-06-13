class AuthErrors {
  static String getErrorMessage(String code) {
    switch (code) {
      case 'weak-password':
        return 'Пароль занадто слабкий. Використовуйте мінімум 6 символів.';
      case 'email-already-in-use':
        return 'Акаунт з таким email вже існує.';
      case 'user-not-found':
        return 'Користувача з таким email не знайдено.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Невірний email або пароль.';
      case 'invalid-email':
        return 'Невірний формат email адреси.';
      case 'user-disabled':
        return 'Цей акаунт було відключено.';
      case 'operation-not-allowed':
        return 'Email/Password автентифікація не увімкнена у Firebase Console.';
      case 'too-many-requests':
        return 'Забагато спроб. Будь ласка, спробуйте пізніше.';
      case 'network-request-failed':
        return 'Помилка мережі. Перевірте підключення до інтернету.';
      default:
        return 'Сталася помилка. Спробуйте ще раз ($code).';
    }
  }
}
