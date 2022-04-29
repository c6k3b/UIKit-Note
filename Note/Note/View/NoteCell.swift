import UIKit

class NoteCell: UITableViewCell, ConfigurableCell {
    typealias ConfigurationModel = Note
    static var identifier = String(describing: NoteCell.self)

    func configure(with model: ConfigurationModel) {
        backgroundView = NoteView(
            model: NoteView.Model(
                header: model.header ?? "N/A",
                body: model.body ?? "N/A",
                date: model.date.getFormattedDate(format: "dd.MM.yyyy")
            ), frame: .infinite
        )
        setAppearance()
    }

//    override func layoutSubviews() {
//        super.layoutSubviews()
//        backgroundView?.frame = (backgroundView?.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)))!
//    }

    private func setAppearance() {
        selectionStyle = .none
        layer.cornerRadius = 14
        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.15
        layer.shadowRadius = 4.0
    }
}
