import UIKit

extension ListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { notes.count }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 1 }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = notes[indexPath.section]

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NoteCell.identifier,
            for: indexPath
        ) as? ConfigurableCell else {
            return UITableViewCell()
        }

        cell.configure(
            header: note.header,
            body: note.body,
            date: note.date,
            icon: note.icon
        )
        return cell as? UITableViewCell ?? UITableViewCell()
    }
}
