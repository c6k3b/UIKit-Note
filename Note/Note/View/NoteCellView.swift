import UIKit

class NoteCellView: UIView {
    private let noteHeaderLabel = UILabel()
    private let noteBodyLabel = UILabel()
    private let noteDateLabel = UILabel()

    private let labelsStackView = UIStackView()
    private let selectorImageView = UIImageView()

    private var isEditionMode = false

    init(model: Model, frame: CGRect) {
        super.init(frame: frame)
        self.applyViewModel(model)
        setupLabels()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToSuperview() {
        setupView()
    }

    private func setupView() {
        layer.cornerRadius = 14
        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowOpacity = 0.15
        layer.shadowRadius = 4.0
        backgroundColor = .systemBackground

        translatesAutoresizingMaskIntoConstraints = false
        guard let superview = superview else { return }
        topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -4).isActive = true
        leftAnchor.constraint(equalTo: superview.leftAnchor, constant: 16).isActive = true
        rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -16).isActive = true
    }

    private func setupLabels() {
        if !isEditionMode {
            addSubview(labelsStackView)
            setupLabelsStackView()
        } else {
            addSubview(selectorImageView)
            setupSelectorImageView()

            addSubview(labelsStackView)
            setupLabelsStackView()
        }
    }

    private func setupSelectorImageView() {
        let origin = CGPoint(x: 24, y: 37)
        let size = CGSize(width: 16, height: 16)
        selectorImageView.frame = CGRect(origin: origin, size: size)
        selectorImageView.image = UIImage(named: "checkmarkEmpty")
    }

    private func setupLabelsStackView() {
        labelsStackView.alignment = .leading
        labelsStackView.axis = .vertical
        labelsStackView.distribution = .equalCentering

        setupHeaderLabel()
        setupBodyLabel()
        setupDateLabel()

        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        labelsStackView.leadingAnchor.constraint(
            equalTo: leadingAnchor,
            constant: !isEditionMode ? 16 : 60
        ).isActive = true
        labelsStackView.trailingAnchor.constraint(
            equalTo: trailingAnchor,
            constant: -16
        ).isActive = true
        labelsStackView.topAnchor.constraint(
            equalTo: topAnchor,
            constant: 10
        ).isActive = true
        labelsStackView.bottomAnchor.constraint(
            equalTo: bottomAnchor,
            constant: -10
        ).isActive = true
    }

    private func setupHeaderLabel() {
        noteHeaderLabel.font = .systemFont(ofSize: 16, weight: .regular)
        labelsStackView.addArrangedSubview(noteHeaderLabel)
    }

    private func setupBodyLabel() {
        noteBodyLabel.font = .systemFont(ofSize: 10, weight: .regular)
        noteBodyLabel.textColor = .systemGray
        labelsStackView.addArrangedSubview(noteBodyLabel)

        noteBodyLabel.translatesAutoresizingMaskIntoConstraints = false
        noteBodyLabel.topAnchor.constraint(
            equalTo: noteHeaderLabel.bottomAnchor,
            constant: 4
        ).isActive = true
    }

    private func setupDateLabel() {
        noteDateLabel.font = .systemFont(ofSize: 10, weight: .regular)
        noteDateLabel.textColor = .systemGray

        labelsStackView.addArrangedSubview(noteDateLabel)
    }

    func applyViewModel(_ viewModel: NoteCellView.Model) {
        noteHeaderLabel.text = viewModel.header
        noteBodyLabel.text = viewModel.body
        noteDateLabel.text = viewModel.date
        isEditionMode = viewModel.isEditingMode
    }
}

extension NoteCellView {
    struct Model {
        let header: String
        let body: String
        let date: String
        let isEditingMode: Bool
    }
}
