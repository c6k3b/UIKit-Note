import UIKit

class NoteCell: UITableViewCell, ConfigurableCell {
    typealias ConfigurationModel = Note
    static var identifier = String(describing: NoteCell.self)

    func configure(with model: ConfigurationModel) {
        let noteView = NoteCellView(
            model: NoteCellView.Model(
                header: model.header ?? "N/A",
                body: model.body ?? "N/A",
                date: model.date.getFormattedDate(format: "dd.MM.yyyy")
            ), frame: .infinite
        )
        contentView.addSubview(noteView)
        selectionStyle = .none
    }
}
