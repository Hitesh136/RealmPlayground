
import UIKit
import RealmSwift

class FavoritesTableViewController: UITableViewController {

  fileprivate var messages: Results<Message>!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let realm = try! Realm()
    messages = User.defaultUser(realm: realm).messages.filter("isFavorite = 1")
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
  }

  // MARK: - table view methods
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.reuseIdentifier,
                                             for: indexPath) as! FeedTableViewCell

    let message = messages[indexPath.row]
    cell.configureWithMessage(message)

    return cell
  }

}
