import UIKit

class NotesTableView: UITableView {
    // MARK: - Initializers
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        createUI()
        register(NoteCell.self, forCellReuseIdentifier: NoteCell.identifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToSuperview() {
        activateTableViewConstraints()
    }

    // MARK: - Methods
    private func createUI() {
        showsVerticalScrollIndicator = false
        allowsMultipleSelectionDuringEditing = true
//        allowsSelectionDuringEditing = true
        backgroundColor = .clear
        separatorStyle = .none
        estimatedRowHeight = 90
    }
}

// MARK: - Constraints
extension NotesTableView {
    private func activateTableViewConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            leadingAnchor.constraint(
                equalTo: superview.leadingAnchor, constant: 16
            ).isActive = true
            trailingAnchor.constraint(
                equalTo: superview.trailingAnchor, constant: -16
            ).isActive = true
            topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        }
    }
}
