
import Foundation
import RealmSwift

class Message: Object {

  // MARK: - Init
  convenience init(user: User, message: String) {
    self.init()
    self.name = user.name
    self.message = message
  }

  // MARK: - Persisted Properties
  @objc dynamic var id = UUID().uuidString
  @objc dynamic var message = ""
  @objc dynamic var name = ""
  @objc dynamic var isFavorite = false
  @objc dynamic var timestamp = Date().timeIntervalSinceReferenceDate

  // MARK: - Dynamic properties
  var photoURL: URL {
    return imageUrlForName(self.name)
  }
  
  // MARK: - Meta
  override class func primaryKey() -> String? {
    return "id"
  }
  
  override class func indexedProperties() -> [String] {
    return ["isFavorite"]
  }
  
  // MARK: - Etc
  func toggleFavorite() {
    try? realm?.write {
      isFavorite.toggle()
    }
  }

}
