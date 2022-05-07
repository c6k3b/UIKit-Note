import UIKit

class NoteCell: UITableViewCell, ConfigurableCell {
    typealias ConfigurationModel = Note
    static var identifier = String(describing: NoteCell.self)

    private let noteHeaderLabel = UILabel()
    private let noteBodyLabel = UILabel()
    private let noteDateLabel = UILabel()
    private let stackView = UIStackView()

    func configure(with model: ConfigurationModel) {
        noteHeaderLabel.text = model.header
        noteBodyLabel.text = model.body
        noteDateLabel.text = model.date.getFormattedDate(format: "dd.MM.yyyy")

        setupView()
    }

    private func setupView() {
        selectionStyle = .none
        contentView.layer.cornerRadius = 14
        contentView.layer.masksToBounds = true
        backgroundColor = .clear
        contentView.backgroundColor = .systemBackground

        contentView.addSubview(stackView)
        setupStackView()
    }

    private func setupStackView() {
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.distribution = .equalCentering

        setupHeaderLabel()
        setupBodyLabel()
        setupDateLabel()

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor,
            constant: 16
        ).isActive = true
        stackView.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -16
        ).isActive = true
        stackView.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: 10
        ).isActive = true
        stackView.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: -10
        ).isActive = true
    }

    private func setupHeaderLabel() {
        noteHeaderLabel.font = .systemFont(ofSize: 16, weight: .regular)
        stackView.addArrangedSubview(noteHeaderLabel)
    }

    private func setupBodyLabel() {
        noteBodyLabel.font = .systemFont(ofSize: 10, weight: .regular)
        noteBodyLabel.textColor = .systemGray
        stackView.addArrangedSubview(noteBodyLabel)

        noteBodyLabel.translatesAutoresizingMaskIntoConstraints = false
        noteBodyLabel.topAnchor.constraint(
            equalTo: noteHeaderLabel.bottomAnchor,
            constant: 4
        ).isActive = true
    }

    private func setupDateLabel() {
        noteDateLabel.font = .systemFont(ofSize: 10, weight: .regular)
        noteDateLabel.textColor = .systemGray
        stackView.addArrangedSubview(noteDateLabel)
    }
}
