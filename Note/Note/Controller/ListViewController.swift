import UIKit

class ListViewController: UIViewController {
    private var notes = SampleData().notes

    private let button = UIButton()
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Заметки"
        view.backgroundColor = .systemBackground

        setupScrollView()
        setupStackView()
        setupNoteViews()
        setupButton()
    }

    private func setupScrollView() {
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor
        ).isActive = true
        scrollView.trailingAnchor.constraint(
            equalTo: view.trailingAnchor
        ).isActive = true
        scrollView.topAnchor.constraint(
            equalTo: view.topAnchor
        ).isActive = true
        scrollView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor
        ).isActive = true
    }

    private func setupStackView() {
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true

        scrollView.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(
            equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor
        ).isActive = true
        stackView.trailingAnchor.constraint(
            equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor
        ).isActive = true
        stackView.topAnchor.constraint(
            equalTo: scrollView.topAnchor
        ).isActive = true
        stackView.bottomAnchor.constraint(
            equalTo: scrollView.bottomAnchor
        ).isActive = true
    }

    private func setupNoteViews() {
        for note in notes {
            addNewNoteView(with: note)
        }
    }

    private func addNewNoteView(with note: Note) {
        let noteView = NoteView()

        let noteModel = NoteView.Model(
            header: note.header ?? "N/A",
            body: note.body ?? "N/A",
            date: note.date.getFormattedDate(format: "dd.MM.yyyy")
        )

        noteView.applyViewModel(noteModel)

        noteView.backgroundColor = .systemBackground
        noteView.layer.cornerRadius = 14
        noteView.layer.shadowColor = UIColor.systemGray.cgColor
        noteView.layer.shadowOffset = CGSize(width: 3, height: 3)
        noteView.layer.shadowOpacity = 0.1
        noteView.layer.shadowRadius = 4.0

        stackView.addArrangedSubview(noteView)

        noteView.translatesAutoresizingMaskIntoConstraints = false
        noteView.heightAnchor.constraint(equalToConstant: 90).isActive = true

        noteView.viewDidTapped = { _ in
            let noteVC = NoteViewController(note: note)
            noteVC.noteDelegate = self

            self.navigationController?.pushViewController(noteVC, animated: true)
            noteView.removeFromSuperview()
        }
    }

    private func setupButton() {
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.contentVerticalAlignment = .bottom
        button.titleLabel?.font = .systemFont(ofSize: 36)
        button.setTitle("+", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(didButtonTapped), for: .touchUpInside)

        view.addSubview(button)

        button.translatesAutoresizingMaskIntoConstraints = false
        button.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -20
        ).isActive = true
        button.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: -20
        ).isActive = true
        button.heightAnchor.constraint(
            equalToConstant: 50
        ).isActive = true
        button.widthAnchor.constraint(
            equalToConstant: 50
        ).isActive = true
    }

    @objc private func didButtonTapped() {
        let noteVC = NoteViewController(note: Note())
        noteVC.noteDelegate = self

        navigationController?.pushViewController(noteVC, animated: true)
    }
}

extension ListViewController: NoteDelegate {
    func passDataToView(from note: Note) {
        addNewNoteView(with: note)
    }
}
