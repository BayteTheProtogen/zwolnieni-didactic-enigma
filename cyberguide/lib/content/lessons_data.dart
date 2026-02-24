import '../models/lesson.dart';

final List<Lesson> lessonsData = [
  Lesson(
    id: 'l1',
    category: 'Bezpieczne Hasła',
    title: 'Dlaczego hasło jest ważne?',
    questions: [
      Question(
        id: 'l1_q1',
        title: 'Twoje Cyfrowe Klucze',
        text: 'Hasło jest jak klucz do Twojego mieszkania. Chroni Twoje prywatne wiadomości, zdjęcia i pieniądze przed obcymi osobami.',
        type: QuestionType.information,
      ),
      Question(
        id: 'l1_q2',
        text: 'Które z tych haseł jest najsilniejsze?',
        options: ['123456', 'haslo123', 'M0je!B3zpieczneHaslo', 'admin'],
        correctIndex: 2,
        explanation: 'Silne hasło powinno mieć duże i małe litery, cyfry oraz znaki specjalne.',
      ),
      Question(
        id: 'l1_q3',
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
        id: 'l2_q1',
        title: 'Czym jest Phishing?',
        text: 'Oszuści często wysyłają wiadomości podszywając się pod banki, kurierów lub Twoich bliskich. Chcą, abyś kliknął w link i podał swoje dane.',
        type: QuestionType.information,
      ),
      Question(
        id: 'l2_q2',
        text: 'Dostajesz SMS: "Twoja paczka została wstrzymana, dopłać 1.50 zł pod linkiem...". Co robisz?',
        options: ['Klikam i płacę', 'Ignoruję i usuwam wiadomość', 'Dzwonię pod numer z SMSa'],
        correctIndex: 1,
        explanation: 'To popularne oszustwo na "dopłatę do paczki". Banki i firmy kurierskie nie wysyłają takich próśb przez SMS.',
        type: QuestionType.scamOrNot,
      ),
    ],
  ),
  Lesson(
    id: 'l3',
    category: 'Bezpieczne Hasła',
    title: 'Wieloskładnikowe Logowanie',
    questions: [
      Question(
        id: 'l3_q1',
        title: 'Podwójna ochrona',
        text: 'Logowanie dwuetapowe to tak, jakbyś oprócz klucza miał w drzwiach dodatkowy zamek, do którego kod dostajesz na telefon.',
        type: QuestionType.information,
      ),
      Question(
        id: 'l3_q2',
        text: 'Co to jest dwuetapowa weryfikacja (2FA)?',
        options: ['Wpisywanie hasła dwa razy', 'Dodatkowy kod wysłany np. SMS-em po wpisaniu hasła', 'Logowanie się z dwóch różnych urządzeń'],
        correctIndex: 1,
        explanation: '2FA to dodatkowa warstwa ochrony, która wymaga czegoś, co wiesz (hasło) i czegoś, co masz (telefon).',
      ),
    ],
  ),
  Lesson(
    id: 'l5',
    category: 'Bezpieczeństwo w sieci',
    title: 'Jak rozpoznać bezpieczną stronę?',
    questions: [
      Question(
        id: 'l5_q1',
        title: 'Symbol Kłódki',
        text: 'Zawsze sprawdzaj, czy przy adresie strony internetowej w przeglądarce widnieje symbol zamkniętej kłódki. Oznacza on, że połączenie jest szyfrowane.',
        type: QuestionType.information,
      ),
      Question(
        id: 'l5_q2',
        title: 'Adres strony',
        text: 'Oszuści tworzą strony bardzo podobne do prawdziwych (np. "bannk.pl" zamiast "bank.pl"). Zawsze dokładnie czytaj adres!',
        type: QuestionType.information,
      ),
      Question(
        id: 'l5_q3',
        text: 'Co oznacza zamknięta kłódka obok adresu strony?',
        options: ['Strona jest zablokowana', 'Połączenie jest bezpieczne i szyfrowane', 'Muszę podać hasło, żeby wejść'],
        correctIndex: 1,
        explanation: 'Kłódka to znak, że Twoje dane przesyłane do strony są chronione.',
      ),
    ],
  ),
  Lesson(
    id: 'l6',
    category: 'Urządzenia Mobilne',
    title: 'Zasady bezpiecznego telefonu',
    questions: [
      Question(
        id: 'l6_q1',
        title: 'Blokada ekranu',
        text: 'Zawsze miej ustawiony kod PIN, wzór lub odcisk palca w swoim telefonie. Jeśli go zgubisz, nikt nie uzyska dostępu do Twoich danych.',
        type: QuestionType.information,
      ),
      Question(
        id: 'l6_q2',
        title: 'Publiczne Wi-Fi',
        text: 'Unikaj logowania się do banku, gdy korzystasz z otwartego Wi-Fi w kawiarni czy na dworcu. Lepiej użyj swojego internetu komórkowego.',
        type: QuestionType.information,
      ),
      Question(
        id: 'l6_q3',
        text: 'Gdzie najbezpieczniej logować się do banku?',
        options: ['Na darmowym Wi-Fi w parku', 'W domu na własnym Wi-Fi lub przez internet komórkowy', 'W kawiarence internetowej'],
        correctIndex: 1,
        explanation: 'Domowa sieć lub internet od operatora są znacznie trudniejsze do podsłuchania przez hakerów.',
      ),
    ],
  ),
  Lesson(
    id: 'l4',
    category: 'Uwaga na Oszustów',
    title: 'Podejrzane linki w mailach',
    questions: [
      Question(
        id: 'l4_q1',
        title: 'Poczta e-mail',
        text: 'E-maile z prośbą o pilne działanie to najczęstsza metoda oszustów. "Twoje konto zostanie usunięte", "Wygrałeś nagrodę" - to znaki ostrzegawcze!',
        type: QuestionType.information,
      ),
      Question(
        id: 'l4_q2',
        text: 'Dostajesz e-mail od "Banku" z prośbą o pilne zalogowanie się przez link. Co robisz?',
        options: ['Klikam szybko w link', 'Wchodzę na stronę banku wpisując adres ręcznie w przeglądarce', 'Odpisuję na e-mail'],
        correctIndex: 1,
        explanation: 'Nigdy nie klikaj w linki do bankowości z e-maili. Zawsze wpisuj adres banku samodzielnie.',
      ),
    ],
  ),
];
