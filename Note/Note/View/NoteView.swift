import UIKit

class NoteView: UIView {
    private let noteHeaderLabel = UILabel()
    private let noteBodyLabel = UILabel()
    private let noteDateLabel = UILabel()

    var viewDidTapped: (Note?) -> Void = { _ in }

    override init(frame: CGRect = CGRect(origin: .zero, size: .zero)) {
        super.init(frame: frame)
        setupHeaderLabel()
        setupBodyLabel()
        setupDateLabel()
        setupGestureRecognizer()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func applyViewModel(_ viewModel: NoteView.Model) {
        noteHeaderLabel.text = viewModel.header
        noteBodyLabel.text = viewModel.body
        noteDateLabel.text = viewModel.date
    }

    private func setupHeaderLabel() {
        noteHeaderLabel.font = .systemFont(ofSize: 16, weight: .regular)
        addSubview(noteHeaderLabel)

        noteHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        noteHeaderLabel.topAnchor.constraint(
            equalTo: safeAreaLayoutGuide.topAnchor,
            constant: 10
        ).isActive = true
        noteHeaderLabel.leadingAnchor.constraint(
            equalTo: safeAreaLayoutGuide.leadingAnchor,
            constant: 16
        ).isActive = true
        noteHeaderLabel.trailingAnchor.constraint(
            equalTo: safeAreaLayoutGuide.trailingAnchor,
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
            equalTo: safeAreaLayoutGuide.leadingAnchor,
            constant: 16
        ).isActive = true
        noteBodyLabel.trailingAnchor.constraint(
            equalTo: safeAreaLayoutGuide.trailingAnchor,
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
            equalTo: safeAreaLayoutGuide.leadingAnchor,
            constant: 16
        ).isActive = true
        noteDateLabel.trailingAnchor.constraint(
            equalTo: safeAreaLayoutGuide.trailingAnchor,
            constant: -16
        ).isActive = true
    }

    private func setupGestureRecognizer() {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(viewTapped))
        addGestureRecognizer(recognizer)
    }

    @objc private func viewTapped() {
        viewDidTapped(nil)
    }
}

extension NoteView {
    struct Model {
        let header: String
        let body: String
        let date: String
    }
}
