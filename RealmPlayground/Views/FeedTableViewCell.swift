
import UIKit
import RealmSwift
import SDWebImage


class FeedTableViewCell: UITableViewCell {

  static let reuseIdentifier = "FeedTableViewCell"

  @IBOutlet weak var photoView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var messageLabel: UILabel!
  @IBOutlet weak var likeButton: UIButton!

  private var message: Message?

  override func prepareForReuse() {
    photoView.image = nil
  }

  func configureWithMessage(_ message: Message) {
    self.message = message

    nameLabel.text = message.name
    messageLabel.text = message.message
    likeButton.isSelected = message.isFavorite
    photoView.sd_setImage(with: message.photoURL)
    
  }

  @IBAction func toggleLike(_ sender: AnyObject) {
    message?.toggleFavorite()
    likeButton.isSelected = message?.isFavorite ?? false
  }
}
