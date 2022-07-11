import UIKit

class NoteCell: UITableViewCell, ConfigurableCell {
    // MARK: - Props
    private lazy var stackView: UIStackView = {
        $0.alignment = .leading
        $0.axis = .vertical
        $0.distribution = .fill
        $0.addArrangedSubview(headerLabel)
        $0.addArrangedSubview(bodyLabel)
        $0.addArrangedSubview(dateLabel)
        $0.setCustomSpacing(Styles.NoteCell.bodySpacing, after: headerLabel)
        $0.setCustomSpacing(Styles.NoteCell.dateSpacing, after: bodyLabel)
        return $0
    }(UIStackView())

    private let headerLabel: UILabel = {
        $0.font = Styles.NoteCell.headerFont
        return $0
    }(UILabel())

    private let bodyLabel: UILabel = {
        $0.font = Styles.NoteCell.bodyFont
        $0.textColor = Styles.NoteCell.bodyFontColor
        return $0
    }(UILabel())

    private let dateLabel: UILabel = {
        $0.font = Styles.NoteCell.dateFont
        $0.textColor = Styles.NoteCell.dateFontColor
        return $0
    }(UILabel())

    private let iconView = UIImageView()

    static var identifier: String { String(describing: NoteCell.self) }

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) { nil }

    func configure(with model: NoteCell.Model) {
        headerLabel.text = model.header
        bodyLabel.text = model.body
        dateLabel.text = model.date
        iconView.image = model.icon
    }

    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = Styles.NoteCell.cornerRadius
    }

    // MARK: - Methods
    private func setupUI() {
        contentView.layer.cornerRadius = Styles.NoteCell.cornerRadius
        contentView.backgroundColor = Styles.NoteCell.bgColor

        backgroundView = UIView(frame: bounds)
        selectedBackgroundView = UIView(frame: bounds)

        contentView.addSubview(stackView)
        activateStackViewConstraints()

        contentView.insertSubview(iconView, aboveSubview: contentView)
        activateIconViewConstraints()
    }
}

// MARK: - Constraints
extension NoteCell {
    private func activateStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor,
            constant: Styles.NoteCell.leadingConstraint
        ).isActive = true
        stackView.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: Styles.NoteCell.trailingConstraint
        ).isActive = true
        stackView.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: Styles.NoteCell.topConstraint
        ).isActive = true
        stackView.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: Styles.NoteCell.bottomConstraint
        ).isActive = true
    }

    private func activateIconViewConstraints() {
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: Styles.NoteCell.iconTrailingConstraint
        ).isActive = true
        iconView.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: Styles.NoteCell.iconBottomConstraint
        ).isActive = true
        iconView.heightAnchor.constraint(
            equalToConstant: Styles.NoteCell.iconHeight
        ).isActive = true
        iconView.widthAnchor.constraint(
            equalToConstant: Styles.NoteCell.iconWidth
        ).isActive = true
    }
}
