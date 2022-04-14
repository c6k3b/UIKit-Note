import UIKit

class NoteView: UIView {
    var note = Note()
    private var noteHeaderTextField = UITextField()
    private var noteBodyTextField = UITextField()
    private var noteDateTextField = UITextField()

    private var dateLabelText: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: note.date)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupHeader()
        setupBody()
        setupDate()
    }

    private func setupHeader() {
        noteHeaderTextField.text = note.header
        noteHeaderTextField.font = .systemFont(ofSize: 16, weight: .regular)

        addSubview(noteHeaderTextField)

        noteHeaderTextField.translatesAutoresizingMaskIntoConstraints = false
        noteHeaderTextField.topAnchor.constraint(
            equalTo: safeAreaLayoutGuide.topAnchor,
            constant: 10
        ).isActive = true
        noteHeaderTextField.leadingAnchor.constraint(
            equalTo: safeAreaLayoutGuide.leadingAnchor,
            constant: 16
        ).isActive = true
        noteHeaderTextField.trailingAnchor.constraint(
            equalTo: safeAreaLayoutGuide.trailingAnchor,
            constant: -16
        ).isActive = true
    }

    private func setupBody() {
        noteBodyTextField.text = note.body
        noteBodyTextField.font = .systemFont(ofSize: 10, weight: .regular)
        noteBodyTextField.textColor = .systemGray

        addSubview(noteBodyTextField)

        noteBodyTextField.translatesAutoresizingMaskIntoConstraints = false
        noteBodyTextField.topAnchor.constraint(
            equalTo: noteHeaderTextField.bottomAnchor,
            constant: 4
        ).isActive = true
        noteBodyTextField.leadingAnchor.constraint(
            equalTo: safeAreaLayoutGuide.leadingAnchor,
            constant: 16
        ).isActive = true
        noteBodyTextField.trailingAnchor.constraint(
            equalTo: safeAreaLayoutGuide.trailingAnchor,
            constant: -16
        ).isActive = true
    }

    private func setupDate() {
        noteDateTextField.text = dateLabelText
        noteDateTextField.font = .systemFont(ofSize: 10, weight: .regular)
        noteDateTextField.textColor = .systemGray

        addSubview(noteDateTextField)

        noteDateTextField.translatesAutoresizingMaskIntoConstraints = false
        noteDateTextField.topAnchor.constraint(
            equalTo: noteBodyTextField.bottomAnchor,
            constant: 24
        ).isActive = true
        noteDateTextField.leadingAnchor.constraint(
            equalTo: safeAreaLayoutGuide.leadingAnchor,
            constant: 16
        ).isActive = true
        noteDateTextField.trailingAnchor.constraint(
            equalTo: safeAreaLayoutGuide.trailingAnchor,
            constant: -16
        ).isActive = true
    }
}
