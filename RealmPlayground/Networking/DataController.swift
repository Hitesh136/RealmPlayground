
import Foundation
import RealmSwift

class DataController {
  
  private let api: ChatterAPI
  
  init(api: ChatterAPI) {
    self.api = api
  }
  
  private var timer: Timer?
  
  // MARK: - fetch new messages
  
  func startFetchingMessages() {
    timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(fetch), userInfo: nil, repeats: true)
    timer!.fire()
  }
  
  func stopFetchingMessages() {
    timer?.invalidate()
  }
  
  @objc fileprivate func fetch() {
    api.getMessages { jsonObjects in
      let messages = jsonObjects.map{ Message(value: $0)}
      
      let realm = try! Realm()
      let meUser = User.defaultUser(realm: realm)
      try! realm.write {
        for message in messages {
          meUser.messages.insert(message, at: 0)
        }
      }
    }
  }
  
  // MARK: - post new message
  
  func postMessage(_ message: String) {
    
    let realm = try! Realm()
    let user = User.defaultUser(realm: realm)
    
    let new = Message(user: user, message: message)
    try! realm.write {
      User.defaultUser(realm: realm).outgoing.append(new)
    }
    
    let newId = new.id
    api.postMessage(new, completion: {[weak self] _ in
      self?.didSentMessage(id: newId)
    })
  }
  
  private func didSentMessage(id: String) {
    let realm = try! Realm()
    let defaultUser = User.defaultUser(realm: realm)
    
    if let sendedMessage = realm.object(ofType: Message.self, forPrimaryKey: id),
      let index = defaultUser.outgoing.index(of: sendedMessage) {
      
      try! realm.write {
        defaultUser.outgoing.remove(at: index)
        defaultUser.messages.insert(sendedMessage, at: 0)
        defaultUser.sent += 1
      }
    }
  }
}


