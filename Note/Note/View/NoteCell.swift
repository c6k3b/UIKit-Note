import UIKit

class NoteCell: UITableViewCell, ConfigurableCell {
    // MARK: - Props
    private lazy var stackView: UIStackView = {
        $0.alignment = .leading
        $0.axis = .vertical
        $0.distribution = .fill
        $0.addArrangedSubview(headerLabel)
        $0.setCustomSpacing(4, after: headerLabel)
        $0.addArrangedSubview(bodyLabel)
        $0.setCustomSpacing(24, after: bodyLabel)
        $0.addArrangedSubview(dateLabel)
        return $0
    }(UIStackView())

    private let headerLabel: UILabel = {
        $0.font = .systemFont(ofSize: 15)
        return $0
    }(UILabel())

    private let bodyLabel: UILabel = {
        $0.font = .systemFont(ofSize: 10)
        $0.textColor = .systemGray
        return $0
    }(UILabel())

    private let dateLabel: UILabel = {
        $0.font = .systemFont(ofSize: 10)
        $0.textColor = .systemGray
        return $0
    }(UILabel())

    static var identifier: String { String(describing: NoteCell.self) }

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(header: String?, body: String?, date: String) {
        headerLabel.text = header
        bodyLabel.text = body
        dateLabel.text = date
    }

    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 14
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
        if isEditing { shake() }
    }

    // MARK: - Methods
    private func createUI() {
        contentView.layer.cornerRadius = 14
        contentView.backgroundColor = .systemBackground

        backgroundView = createBackground(withImage: "checkmarkEmpty")
        selectedBackgroundView = createBackground(withImage: "checkmarkFilled")

        contentView.addSubview(stackView)
        activateStackViewConstraints()
    }

    private func createBackground(withImage: String) -> UIView {
        let view = UIView()
        view.frame = bounds
        view.bounds = CGRect(
            origin: CGPoint(
                x: bounds.origin.x - 20,
                y: bounds.origin.y - 37
            ), size: .zero
        )
        view.addSubview(UIImageView(image: UIImage(named: withImage)))
        return view
    }
}

// MARK: - Constraints
extension NoteCell {
    private func activateStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor, constant: 16
        ).isActive = true
        stackView.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor, constant: -16
        ).isActive = true
        stackView.topAnchor.constraint(
            equalTo: contentView.topAnchor, constant: 10
        ).isActive = true
        stackView.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor, constant: -10
        ).isActive = true
    }
}
