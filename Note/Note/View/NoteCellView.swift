import UIKit

class NoteCellView: UIView {
    private let noteHeaderLabel = UILabel()
    private let noteBodyLabel = UILabel()
    private let noteDateLabel = UILabel()

    init(model: Model, frame: CGRect) {
        super.init(frame: frame)
        self.applyViewModel(model)
        setupHeaderLabel()
        setupBodyLabel()
        setupDateLabel()
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

    func applyViewModel(_ viewModel: NoteCellView.Model) {
        noteHeaderLabel.text = viewModel.header
        noteBodyLabel.text = viewModel.body
        noteDateLabel.text = viewModel.date
    }
}

extension NoteCellView {
    struct Model {
        let header: String
        let body: String
        let date: String
    }
}
