import UIKit

enum Styles {
    // Constants
    enum Constants {
        static let bgColor = UIColor.systemBackground
        static let bgColorFaded = UIColor.systemBackground.withAlphaComponent(0.97)
        static let spacing = 16.0
    }

    // View Controllers
    enum ListVC {
        static let cellSpacing = Constants.spacing / 4
        static let bgColor = Constants.bgColorFaded
        static let navBarTitle = "Заметки"
        static let navBarEditBtnTitle = "Выбрать"
        static let navBarEditBtnTitleEditing = "Готово"
    }

    enum NoteVC {
        static let navBarEditBtnTitle = "Изменить"
        static let navBarEditBtnTitleEditing = "Готово"

        static let backBtnImg = UIImage(named: "backButton")
    }

    // Views
    enum NotesTableView {
        static let color = UIColor.clear
        static let rowHeight = 90.0

        static let leadingConstraint = Constants.spacing
        static let trailingConstraint = -leadingConstraint
    }

    enum NoteCell {
        static let bgColor = Constants.bgColor

        static let headerFont = UIFont.systemFont(ofSize: Constants.spacing - 1)
        static let bodyFont = UIFont.systemFont(ofSize: Constants.spacing / 1.6)
        static let dateFont = bodyFont
        static let bodyFontColor = UIColor.systemGray
        static let dateFontColor = bodyFontColor

        static let bodySpacing = Constants.spacing / 4
        static let dateSpacing = Constants.spacing * 1.25

        static let cornerRadius = Constants.spacing * 0.875

        static let leadingConstraint = Constants.spacing
        static let trailingConstraint = -leadingConstraint
        static let topConstraint = Constants.spacing / 1.6
        static let bottomConstraint = -topConstraint

        static let iconTrailingConstraint = -Constants.spacing
        static let iconBottomConstraint = -Constants.spacing / 1.6

        static let iconHeight = Constants.spacing * 1.5
        static let iconWidth = iconHeight
    }

    enum NoteView {
        static let bgColor = Constants.bgColor

        static let dateFont = UIFont.systemFont(ofSize: Constants.spacing - 1)
        static let headerFont = UIFont.systemFont(ofSize: Constants.spacing * 1.5, weight: .bold)
        static let bodyFont = UIFont.systemFont(ofSize: Constants.spacing)

        static let dateFontColor = UIColor.systemGray

        static let placeholder = "Введите название"
    }

    enum NoteStackView {
        static let spacing = Constants.spacing / 2

        static let leadingConstraint = Constants.spacing
        static let trailingConstraint = -leadingConstraint
        static let topConstraint = Constants.spacing / 2
        static let bottomConstraint = -Constants.spacing
    }

    // Components
    enum FloatingBtn {
        static let img = UIImage(named: "buttonPlus")
        static let imgEditing = UIImage(named: "buttonTrash")

        static let font = UIFont.systemFont(ofSize: Constants.spacing * 2)

        static let height = Constants.spacing * 3
        static let width = height
        static let cornerRadius = width / 2

        static let trailingConstraint = -Constants.spacing * 1.25
        static let bottomConstraint = trailingConstraint
    }

    enum AlertNoSelectionForDeleteNotes {
        static let title = "Вы не выбрали ни одной заметки"
        static let message = ""
        static let actionTitle = "Ok"
    }

    enum AlertEmptyNoteHeaderOrBody {
        static let title = "Поля не заполнены"
        static let message = "Не могу сохранить пустую заметку"
        static let actionTitle = "Редактировать"
    }

    // Utilities
    enum DateFormat {
        static let inCell = "dd MM yyyy"
        static let inView = "dd.MM.yyyy EEEE HH:mm"
    }
}
