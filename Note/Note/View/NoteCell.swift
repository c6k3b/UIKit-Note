import UIKit

class NoteCell: UITableViewCell, NotesListDisplayLogic {
    // MARK: - Props
    private lazy var stackView: UIStackView = {
        $0.alignment = .leading
        $0.axis = .vertical
        $0.distribution = .fill
        $0.addArrangedSubview(headerLabel)
        $0.addArrangedSubview(bodyLabel)
        $0.addArrangedSubview(dateLabel)
        $0.setCustomSpacing(4, after: headerLabel)
        $0.setCustomSpacing(20, after: bodyLabel)
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

    private let iconView = UIImageView()

    static var identifier: String { String(describing: NoteCell.self) }

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    func congigure(with viewModel: NotesListModels.InitForm.ViewModel) {
//        headerLabel.text = viewModel.header
//        bodyLabel.text = viewModel.body
//        dateLabel.text = viewModel.date
//        iconView.image = viewModel.icon
//    }

    func displayInitForm(_ viewModel: NotesListModels.InitForm.ViewModel) {
        headerLabel.text = viewModel.header
        bodyLabel.text = viewModel.body
        dateLabel.text = viewModel.date
        iconView.image = viewModel.icon
    }

    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 14
    }

    // MARK: - Methods
    private func createUI() {
        contentView.layer.cornerRadius = 14
        contentView.backgroundColor = .systemBackground

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

    private func activateIconViewConstraints() {
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        iconView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 24).isActive = true
    }
}
