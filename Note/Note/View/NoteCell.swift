import UIKit

class NoteCell: UITableViewCell, ConfigurableCell {
    typealias ConfigurationModel = Note
    static var identifier = String(describing: NoteCell.self)

    private let noteHeaderLabel = UILabel()
    private let noteBodyLabel = UILabel()
    private let noteDateLabel = UILabel()

    func configure(with model: ConfigurationModel) {
        noteHeaderLabel.text = model.header
        noteBodyLabel.text = model.body
        noteDateLabel.text = model.date.getFormattedDate(format: "dd.MM.yyyy")

        setupView()
        setupHeaderLabel()
        setupBodyLabel()
        setupDateLabel()
    }

    private func setupView() {
        selectionStyle = .none
        contentView.layer.cornerRadius = 14
        contentView.layer.masksToBounds = true
        backgroundColor = .clear
        contentView.backgroundColor = .systemBackground
    }

    private func setupHeaderLabel() {
        noteHeaderLabel.font = .systemFont(ofSize: 16, weight: .regular)
        addSubview(noteHeaderLabel)

        noteHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        noteHeaderLabel.topAnchor.constraint(
            equalTo: topAnchor,
            constant: 10
        ).isActive = true
        noteHeaderLabel.leadingAnchor.constraint(
            equalTo: leadingAnchor,
            constant: 16
        ).isActive = true
        noteHeaderLabel.trailingAnchor.constraint(
            equalTo: trailingAnchor,
            constant: -16
        ).isActive = true
    }

    private func setupBodyLabel() {
        noteBodyLabel.font = .systemFont(ofSize: 10, weight: .regular)
        noteBodyLabel.textColor = .systemGray
        addSubview(noteBodyLabel)

        noteBodyLabel.translatesAutoresizingMaskIntoConstraints = false
        noteBodyLabel.topAnchor.constraint(
            equalTo: noteHeaderLabel.bottomAnchor,
            constant: 4
        ).isActive = true
        noteBodyLabel.leadingAnchor.constraint(
            equalTo: leadingAnchor,
            constant: 16
        ).isActive = true
        noteBodyLabel.trailingAnchor.constraint(
            equalTo: trailingAnchor,
            constant: -16
        ).isActive = true
    }

    private func setupDateLabel() {
        noteDateLabel.font = .systemFont(ofSize: 10, weight: .regular)
        noteDateLabel.textColor = .systemGray
        addSubview(noteDateLabel)

        noteDateLabel.translatesAutoresizingMaskIntoConstraints = false
        noteDateLabel.topAnchor.constraint(
            equalTo: noteBodyLabel.bottomAnchor,
            constant: 24
        ).isActive = true
        noteDateLabel.leadingAnchor.constraint(
            equalTo: leadingAnchor,
            constant: 16
        ).isActive = true
        noteDateLabel.trailingAnchor.constraint(
            equalTo: trailingAnchor,
            constant: -16
        ).isActive = true
    }
}

extension NoteCell {
    struct Model {
        let header: String
        let body: String
        let date: String
    }
}
