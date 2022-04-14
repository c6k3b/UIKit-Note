import UIKit

class ListViewController: UIViewController, NoteDelegate {
    private let noteVC = NoteViewController()
    private var data = SampleData().notes
    private let button = UIButton()
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Заметки"
        view.backgroundColor = .systemBackground
        noteVC.delegate = self

        setupScrollView()
        setupStackView()
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
        setupNoteList()

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

    private func setupNoteList() {
        for note in data {
            let newNote = createNewNote(note: note)

            newNote.backgroundColor = .systemBackground
            newNote.layer.cornerRadius = 14
            newNote.layer.shadowColor = UIColor.systemGray.cgColor
            newNote.layer.shadowOffset = CGSize(width: 3, height: 3)
            newNote.layer.shadowOpacity = 0.1
            newNote.layer.shadowRadius = 4.0

            let gesture = UITapGestureRecognizer(
                target: self,
                action: #selector(showNoteVC)
            )

            newNote.addGestureRecognizer(gesture)

            stackView.addArrangedSubview(newNote)

            newNote.translatesAutoresizingMaskIntoConstraints = false
            newNote.heightAnchor.constraint(equalToConstant: 90).isActive = true
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

    func passData(data: Note) {
        noteVC.note = data
        navigationController?.pushViewController(noteVC, animated: true)
    }

    func createNewNote(note: Note) -> NoteView {
        let noteView = NoteView()
        noteView.note = note
        return noteView
    }

    @objc private func showNoteVC() {
        noteVC.delegate?.passData(data: data[1])
    }

    @objc private func didButtonTapped() {
        navigationController?.pushViewController(NoteViewController(), animated: true)
    }
}
