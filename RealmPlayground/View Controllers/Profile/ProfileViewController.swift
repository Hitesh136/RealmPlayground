
import UIKit
import RealmSwift
import SDWebImage

class ProfileViewController: UIViewController {

  @IBOutlet weak var statsLabel: UILabel!
  @IBOutlet weak var photo: UIImageView!
  var messages: Results<Message>!
  var token: NotificationToken?
  override func viewDidLoad() {
    super.viewDidLoad()

    let realm = try! Realm()
    let defaultUser = User.defaultUser(realm: realm)
    updateUI(messageCount: defaultUser.sent)
    token = defaultUser.observe { [weak self] change in
      switch change {
        
      case .error(let error):
        fatalError("Error: \(error)")
      case .change(let properties):
        print(properties)
      case .deleted:
        break
      @unknown default:
        break
      }
    }
    photo.sd_setImage(with: imageUrlForName("me"))
  }
  
  private func updateUI(messageCount: Int) {
    statsLabel.text = "\(messageCount) sent messages"
  }
}
