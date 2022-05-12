import UIKit

class NoteCell: UITableViewCell, ConfigurableCell {
    static var identifier = String(describing: NoteCell.self)

    private let headerLabel = UILabel()
    private let bodyLabel = UILabel()
    private let dateLabel = UILabel()
    private let stackView = UIStackView()

    private let checkmarkEmpty = UIImageView()
    private let checkmarkFilled = UIImageView()

    func configure(header: String?, body: String?, date: String) {
        headerLabel.text = header
        bodyLabel.text = body
        dateLabel.text = date
        setAppearance()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 14
    }

    private func setAppearance() {
        contentView.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 14

        backgroundView = UIView(frame: bounds)
        selectedBackgroundView = UIView(frame: bounds)

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

        stackView.setCustomSpacing(4, after: headerLabel)
        stackView.setCustomSpacing(24, after: bodyLabel)

        activateStackViewConstraints()
    }

    private func setupHeaderLabel() {
        headerLabel.font = .systemFont(ofSize: 15)
        stackView.addArrangedSubview(headerLabel)
    }

    private func setupBodyLabel() {
        bodyLabel.font = .systemFont(ofSize: 10)
        bodyLabel.textColor = .systemGray
        stackView.addArrangedSubview(bodyLabel)
    }

    private func setupDateLabel() {
        dateLabel.font = .systemFont(ofSize: 10)
        dateLabel.textColor = .systemGray
        stackView.addArrangedSubview(dateLabel)
    }
}

extension NoteCell {
    private func activateStackViewConstraints() {
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
}
