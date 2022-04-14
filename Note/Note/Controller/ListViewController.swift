import UIKit

class ListViewController: UIViewController {
    var notes: [Note] = SampleData().data
    private let noteView = NoteView()
    private let button = UIButton()
    private let stackView = UIStackView()
    private let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Заметки"
        view.backgroundColor = .systemBackground

        scrollView.addSubview(stackView)
        view.addSubview(scrollView)

        setupStackView()
        setupButton()
    }

    private func setupStackView() {
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 4

        view.addSubview(stackView)

        for note in notes {
            noteView.note = note
            stackView.addArrangedSubview(noteView)
        }

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    private func setupNoteView(_ note: Note) {
//        noteView.note = note
//        stackView.addArrangedSubview(noteView)
//        dump(note)

//        noteView.translatesAutoresizingMaskIntoConstraints = false
//        noteView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        //    let gesture = UITapGestureRecognizer(target: self, action: #selector(showDatePickerAlert))
        //    noteDateLabel.addGestureRecognizer(gesture)
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
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }

    @objc private func didButtonTapped() {
        navigationController?.pushViewController(NoteViewController(), animated: true)
    }
}
