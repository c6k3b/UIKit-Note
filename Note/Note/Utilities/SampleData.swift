import Foundation

class SampleData {
    static var notes: [Note] = {
        [
            Note(
                header: "Вопросы для интервью",
                body: "Как давно ты стал программистом? (задать после небольшо...",
                date: Date(timeIntervalSinceNow: -300_000_000)
            ),
            Note(
                header: "Диплом",
                body: """
            Тема дипломной работы сайт для интерьерной студии, плюс подписать все разделы

            Для защиты диплома нужна будет презентация, в которой должны быть следующие разделы:

            1. Описание аудитории проекта, в том числе пользователей в виде персон.
                Вот хорошая статья про персоны https://blog.sibirix.ru/2013/08/02/metod-person.

            2. Описание проблемы или потребности аудитории, а так же почему вы считаете,
                что у аудитории есть эти проблемы и потребности.
            Для каждой персоны нужно сделать схему JTBD контекст-мотивация-цель
            «Когда (описание ситуации) -> Я хочу (мотивация) -> Чтобы (результат)»
            вот здесь подробно про это написано http://tilda.education/articles-jobs-to-be-done

            Пока на этом остановимся, далее будем детально прорабатывать
            """,
                date: Date(timeIntervalSinceNow: -400_000_000)
            ),
            Note(
                header: "Книги для прочтения",
                body: "Убить пересмешника, 1984, Ответ",
                date: Date(timeIntervalSinceNow: -500_000_000)
            ),
            Note(
                header: "Номера счетов",
                body: "5445674722 - электроэнергия",
                date: Date(timeIntervalSinceNow: -600_000_000)
            ),
            Note(
                header: "Куда сходить в Калининграде",
                body: "Сначала не забыть забронировать стол в Аквамарине, потом...",
                date: Date(timeIntervalSinceNow: -700_000_000)
            ),
            Note(
                header: "Фильмы",
                body: "Скотт Пилигрим против всех, большой Лебовски, типа круты...",
                date: Date(timeIntervalSinceNow: -800_000_000)
            ),
            Note(
                header: "Письмо Олесе",
                body: "Здравствуйте! Меня зовут Евгения, я бы хотела показать вам...",
                date: Date(timeIntervalSinceNow: -800_000_000)
            ),
            Note(
                header: "Карты Тинькофф",
                body: "42001522301200 visa",
                date: Date(timeIntervalSinceNow: -800_000_000)
            )
        ]
    }()
}
