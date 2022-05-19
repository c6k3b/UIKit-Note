import UIKit

class NoteCell: UITableViewCell, ConfigurableCell {
    static var identifier: String { String(describing: NoteCell.self) }

    private let noteHeaderLabel = UILabel()
    private let noteBodyLabel = UILabel()
    private let noteDateLabel = UILabel()
    private let stackView = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setAppearance()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(header: String?, body: String?, date: String) {
        noteHeaderLabel.text = header
        noteBodyLabel.text = body
        noteDateLabel.text = date
    }

    private func setAppearance() {
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
        stackView.distribution = .fill

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

        stackView.setCustomSpacing(4, after: noteHeaderLabel)
        stackView.setCustomSpacing(24, after: noteBodyLabel)
    }

    private func setupHeaderLabel() {
        noteHeaderLabel.font = .systemFont(ofSize: 15)
        stackView.addArrangedSubview(noteHeaderLabel)
    }

    private func setupBodyLabel() {
        noteBodyLabel.font = .systemFont(ofSize: 10)
        noteBodyLabel.textColor = .systemGray
        stackView.addArrangedSubview(noteBodyLabel)
    }

    private func setupDateLabel() {
        noteDateLabel.font = .systemFont(ofSize: 10)
        noteDateLabel.textColor = .systemGray
        stackView.addArrangedSubview(noteDateLabel)
    }
}
