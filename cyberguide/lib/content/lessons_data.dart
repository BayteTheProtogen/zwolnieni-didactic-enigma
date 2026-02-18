import '../models/lesson.dart';

final List<Lesson> lessonsData = [
  Lesson(
    id: 'l1',
    category: 'Bezpieczne Hasła',
    title: 'Dlaczego hasło jest ważne?',
    questions: [
      Question(
        id: 'q1',
        text: 'Które z tych haseł jest najsilniejsze?',
        options: ['123456', 'haslo123', 'M0je!B3zpieczneHaslo', 'admin'],
        correctIndex: 2,
        explanation: 'Silne hasło powinno mieć duże i małe litery, cyfry oraz znaki specjalne.',
      ),
      Question(
        id: 'q2',
        text: 'Czy powinieneś używać tego samego hasła do wszystkich kont?',
        options: ['Tak, łatwiej zapamiętać', 'Nie, to niebezpieczne'],
        correctIndex: 1,
        explanation: 'Jeśli jedno konto zostanie zhakowane, pozostałe będą bezpieczne dzięki różnym hasłom.',
      ),
    ],
  ),
  Lesson(
    id: 'l2',
    category: 'Uwaga na Oszustów',
    title: 'Fałszywe Wiadomości SMS',
    questions: [
      Question(
        id: 'q3',
        text: 'Dostajesz SMS: "Twoja paczka została wstrzymana, dopłać 1.50 zł pod linkiem...". Co robisz?',
        options: ['Klikam i płacę', 'Ignoruję i usuwam wiadomość', 'Dzwonię pod numer z SMSa'],
        correctIndex: 1,
        explanation: 'To popularne oszustwo na "dopłatę do paczki". Banki i firmy kurierskie nie wysyłają takich próśb.',
        type: QuestionType.scamOrNot,
      ),
      Question(
        id: 'q4',
        text: 'Ktoś dzwoni i podaje się za wnuczka, prosząc o pieniądze na kaucję. Co robisz?',
        options: ['Od razu przelewam pieniądze', 'Rozłączam się i dzwonię do wnuczka na jego znany mi numer', 'Podaję adres zamieszkania'],
        correctIndex: 1,
        explanation: 'To metoda "na wnuczka". Zawsze weryfikuj tożsamość dzwoniącego, kontaktując się z nim bezpośrednio.',
      ),
    ],
  ),
  Lesson(
    id: 'l3',
    category: 'Bezpieczne Hasła',
    title: 'Wieloskładnikowe Logowanie',
    questions: [
      Question(
        id: 'q5',
        text: 'Co to jest dwuetapowa weryfikacja (2FA)?',
        options: ['Wpisywanie hasła dwa razy', 'Dodatkowy kod wysłany np. SMS-em po wpisaniu hasła', 'Logowanie się z dwóch różnych urządzeń'],
        correctIndex: 1,
        explanation: '2FA to dodatkowa warstwa ochrony, która wymaga czegoś, co wiesz (hasło) i czegoś, co masz (telefon).',
      ),
    ],
  ),
  Lesson(
    id: 'l4',
    category: 'Uwaga na Oszustów',
    title: 'Podejrzane linki',
    questions: [
      Question(
        id: 'q6',
        text: 'Dostajesz e-mail od "Banku" z prośbą o pilne zalogowanie się przez link, bo Twoje konto zostanie zablokowane. Co robisz?',
        options: ['Klikam szybko w link', 'Wchodzę na stronę banku wpisując adres ręcznie w przeglądarce', 'Odpisuję na e-mail z pytaniem dlaczego'],
        correctIndex: 1,
        explanation: 'Nigdy nie klikaj w linki do bankowości z e-maili. Zawsze wpisuj adres banku samodzielnie.',
      ),
    ],
  ),
];
