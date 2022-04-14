import UIKit

@objc class NoteView: UIView {
    var note: Note!
    var showingDelegate: ShowingNoteDelegate!
    private var noteHeaderLabel = UILabel()
    private var noteBodyLabel = UILabel()
    private var noteDateLabel = UILabel()

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
        noteHeaderLabel.text = note.header
        noteHeaderLabel.font = .systemFont(ofSize: 16, weight: .regular)

        addSubview(noteHeaderLabel)

        noteHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        noteHeaderLabel.topAnchor.constraint(
            equalTo: safeAreaLayoutGuide.topAnchor,
            constant: 10
        ).isActive = true
        noteHeaderLabel.leadingAnchor.constraint(
            equalTo: safeAreaLayoutGuide.leadingAnchor,
            constant: 16
        ).isActive = true
        noteHeaderLabel.trailingAnchor.constraint(
            equalTo: safeAreaLayoutGuide.trailingAnchor,
            constant: -16
        ).isActive = true
    }

    private func setupBody() {
        noteBodyLabel.text = note.body
        noteBodyLabel.font = .systemFont(ofSize: 10, weight: .regular)
        noteBodyLabel.textColor = .systemGray

        addSubview(noteBodyLabel)

        noteBodyLabel.translatesAutoresizingMaskIntoConstraints = false
        noteBodyLabel.topAnchor.constraint(
            equalTo: noteHeaderLabel.bottomAnchor,
            constant: 4
        ).isActive = true
        noteBodyLabel.leadingAnchor.constraint(
            equalTo: safeAreaLayoutGuide.leadingAnchor,
            constant: 16
        ).isActive = true
        noteBodyLabel.trailingAnchor.constraint(
            equalTo: safeAreaLayoutGuide.trailingAnchor,
            constant: -16
        ).isActive = true
    }

    private func setupDate() {
        noteDateLabel.text = dateLabelText
        noteDateLabel.font = .systemFont(ofSize: 10, weight: .regular)
        noteDateLabel.textColor = .systemGray

        addSubview(noteDateLabel)

        noteDateLabel.translatesAutoresizingMaskIntoConstraints = false
        noteDateLabel.topAnchor.constraint(
            equalTo: noteBodyLabel.bottomAnchor,
            constant: 24
        ).isActive = true
        noteDateLabel.leadingAnchor.constraint(
            equalTo: safeAreaLayoutGuide.leadingAnchor,
            constant: 16
        ).isActive = true
        noteDateLabel.trailingAnchor.constraint(
            equalTo: safeAreaLayoutGuide.trailingAnchor,
            constant: -16
        ).isActive = true
    }

    @objc func editNote() {
        showingDelegate.showNoteVC(for: self)
    }
}
