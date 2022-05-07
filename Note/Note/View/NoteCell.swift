import UIKit

class NoteCell: UITableViewCell, ConfigurableCell {
    typealias ConfigurationModel = Note
    static var identifier = String(describing: NoteCell.self)

    private let noteHeaderLabel = UILabel()
    private let noteBodyLabel = UILabel()
    private let noteDateLabel = UILabel()
    private let selectorImageView = UIImageView()

    private var isEditingMode = false

    func configure(with model: ConfigurationModel) {
        noteHeaderLabel.text = model.header
        noteBodyLabel.text = model.body
        noteDateLabel.text = model.date.getFormattedDate(format: "dd.MM.yyyy")

        setupHeaderLabel()
        setupBodyLabel()
        setupDateLabel()

        selectionStyle = .none
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.masksToBounds = true
        layer.cornerRadius = 14
    }

    private func setupSelectorImageView() {
        let origin = CGPoint(x: 24, y: 37)
        let size = CGSize(width: 16, height: 16)
        selectorImageView.frame = CGRect(origin: origin, size: size)
        selectorImageView.image = UIImage(named: "checkmarkEmpty")
    }

    private func setupHeaderLabel() {
        noteHeaderLabel.font = .systemFont(ofSize: 16, weight: .regular)
        contentView.addSubview(noteHeaderLabel)

        noteHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        noteHeaderLabel.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: 10
        ).isActive = true
        noteHeaderLabel.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor,
            constant: 16
        ).isActive = true
        noteHeaderLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -16
        ).isActive = true
    }

    private func setupBodyLabel() {
        noteBodyLabel.font = .systemFont(ofSize: 10, weight: .regular)
        noteBodyLabel.textColor = .systemGray
        contentView.addSubview(noteBodyLabel)

        noteBodyLabel.translatesAutoresizingMaskIntoConstraints = false
        noteBodyLabel.topAnchor.constraint(
            equalTo: noteHeaderLabel.bottomAnchor,
            constant: 4
        ).isActive = true
        noteBodyLabel.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor,
            constant: 16
        ).isActive = true
        noteBodyLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -16
        ).isActive = true
    }

    private func setupDateLabel() {
        noteDateLabel.font = .systemFont(ofSize: 10, weight: .regular)
        noteDateLabel.textColor = .systemGray
        contentView.addSubview(noteDateLabel)

        noteDateLabel.translatesAutoresizingMaskIntoConstraints = false
        noteDateLabel.topAnchor.constraint(
            equalTo: noteBodyLabel.bottomAnchor,
            constant: 24
        ).isActive = true
        noteDateLabel.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor,
            constant: 16
        ).isActive = true
        noteDateLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
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
