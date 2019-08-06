
import Foundation
import RealmSwift

func imageUrlForName(_ name: String) -> URL {
  return URL(string: "https://api.adorable.io/avatars/150/" + name.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)! + ".png")!
}

class User: Object {
  
  // MARK: - Init
  convenience init(name: String) {
    self.init()
    self.name = name
  }
  
  // MARK: - Properties
  @objc dynamic var name = ""
  @objc dynamic var sent = 0
  
  let messages = List<Message>()
  var outgoing = List<Message>()
  var avatarURL: URL {
    return imageUrlForName(self.name)
  }
  
  // MARK: - Meta
  override static func primaryKey() -> String? {
    return "name"
  }
  
  // MARK: - Etc
  private static func createDefaultUser(realm: Realm) -> User {
    let user = User(name: "me")
    try! realm.write {
      realm.add(user)
    }
    return user
  }
  
  @discardableResult
  static func defaultUser(realm: Realm) -> User {
    return realm.object(ofType: User.self, forPrimaryKey: "me") ?? createDefaultUser(realm: realm)
  }
}


