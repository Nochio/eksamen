//
//  DataService.swift
//  Faktor 5
//
//  Created by Thomas Hinrichs on 28/07/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
  static let instance = DataService()
    
  private var _REF_BASE = DB_BASE
  private var _REF_USERS = DB_BASE.child("medlemmer")
  private var _REF_GROUPS = DB_BASE.child("grupper")
  private var _REF_FEED = DB_BASE.child("feed")
  private var _REF_CHAT = DB_BASE.child("chat")
  private var _REF_TEXT = DB_BASE.child("text")
  private var _REF_NAVN = DB_BASE.child("Navn")
  
  var REF_BASE: DatabaseReference {
      return _REF_BASE
  }
  
  var REF_USERS: DatabaseReference {
      return _REF_USERS
  }
  
  var REF_GROUPS: DatabaseReference {
      return _REF_GROUPS
  }
  
  var REF_FEED: DatabaseReference {
      return _REF_FEED
  }

  var REF_CHAT: DatabaseReference {
    return _REF_CHAT
  }
  
  var REF_TEXT: DatabaseReference {
    return _REF_TEXT
  }
  
  var REF_NAVN: DatabaseReference {
    return _REF_NAVN
  }
  
  func createDBUser(uid: String, userData: Dictionary<String, Any>) {
      REF_USERS.child(uid).updateChildValues(userData)
  }
  
  func getUsername(forUID uid: String, handler: @escaping (_ username: String) -> ()) {
      REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
          guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
          for user in userSnapshot {
              if user.key == uid {
                  handler(user.childSnapshot(forPath: "Navn").value as! String)
              }
          }
      }
  }
  
  func uploadPost(withMessage message: String, forUID uid: String, withGroupKey groupKey: String?, sendComplete: @escaping (_ status: Bool) -> ()) {
      if groupKey != nil {
          REF_GROUPS.child(groupKey!).child("messages").childByAutoId().updateChildValues(["content": message, "senderId": uid])
          sendComplete(true)
      } else {
          REF_FEED.childByAutoId().updateChildValues(["content": message, "senderId": uid])
          sendComplete(true)
      }
  }
  
  func uploadNavn(withNavn navn: String, withNavneKey navneKey: String?, sendComplete: @escaping (_ status: Bool) -> ()) {
    if navneKey != nil {
      REF_NAVN.child(navneKey!).child("navn").childByAutoId().updateChildValues(["navn": navn])
      sendComplete(true)
    } else {
      REF_NAVN.childByAutoId().updateChildValues(["navn": navn])
      sendComplete(true)
    }
  }

  func uploadDagbog(withHeadline headline: String, withText text: String, withDagbogKey dagbogKey: String?, sendComplete: @escaping (_ status: Bool) -> ()) {
    if dagbogKey != nil {
      REF_TEXT.child(dagbogKey!).child("text").childByAutoId().updateChildValues(["overskrift": headline, "text": text])
      sendComplete(true)
    } else {
      REF_TEXT.childByAutoId().updateChildValues(["overskrift": headline, "text": text])
      sendComplete(true)
    }
    
  }

  func uploadChat(withChat chat: String, forUID uid: String, withChatKey chatKey: String? ,sendComplete: @escaping (_ status: Bool) -> ()) {
    if chatKey != nil {
    REF_CHAT.child(chatKey!).child("chats").childByAutoId().updateChildValues(["content": chat, "senderId": uid])
    sendComplete(true)
    } else {
      REF_CHAT.childByAutoId().updateChildValues(["content": chat, "senderId": uid])
      sendComplete(true)
    }
  }

  
  
  func getAllFeedMessages(handler: @escaping (_ messages: [Message]) -> ()) {
      var messageArray = [Message]()
      REF_FEED.observeSingleEvent(of: .value) { (feedMessageSnapshot) in
          guard let feedMessageSnapshot = feedMessageSnapshot.children.allObjects as? [DataSnapshot] else { return }
          
          for message in feedMessageSnapshot {
              let content = message.childSnapshot(forPath: "content").value as! String
              let senderId = message.childSnapshot(forPath: "senderId").value as! String
              let message = Message(content: content, senderId: senderId)
              messageArray.append(message)
          }
          
          handler(messageArray)
      }
  }

  func getAllChatMessages(desiredChatGroup: ChatGruppe, handler: @escaping (_ messages: [Message]) -> ()) {
    var chatArray = [Message]()
    REF_CHAT.child(desiredChatGroup.key).child("chats").observeSingleEvent(of: .value) { (groupChatMessageSnapshot) in
      guard let groupChatMessageSnapshot = groupChatMessageSnapshot.children.allObjects as? [DataSnapshot] else { return }
      for groupChatMessage in groupChatMessageSnapshot {
        let content = groupChatMessage.childSnapshot(forPath: "content").value as! String
        let senderId = groupChatMessage.childSnapshot(forPath: "senderId").value as! String
        let groupChatMessage = Message(content: content, senderId: senderId)
        chatArray.append(groupChatMessage)
      }
      handler(chatArray)
    }
  }
  
  func getAllMessagesFor(desiredGroup: Grupper, handler: @escaping (_ messagesArray: [Message]) -> ()) {
      var groupMessageArray = [Message]()
      REF_GROUPS.child(desiredGroup.key).child("messages").observeSingleEvent(of: .value) { (groupMessageSnapshot) in
          guard let groupMessageSnapshot = groupMessageSnapshot.children.allObjects as? [DataSnapshot] else { return }
          for groupMessage in groupMessageSnapshot {
              let content = groupMessage.childSnapshot(forPath: "content").value as! String
              let senderId = groupMessage.childSnapshot(forPath: "senderId").value as! String
              let groupMessage = Message(content: content, senderId: senderId)
              groupMessageArray.append(groupMessage)
          }
          handler(groupMessageArray)
      }
  }
  
  func getEmail(forSearchQuery query: String, handler: @escaping (_ emailArray: [String]) -> ()) {
      var emailArray = [String]()
      REF_USERS.observe(.value) { (userSnapshot) in
          guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
          for user in userSnapshot {
              let email = user.childSnapshot(forPath: "email").value as! String
              
              if email.contains(query) == true && email != Auth.auth().currentUser?.email {
                  emailArray.append(email)
              }
          }
          handler(emailArray)
      }
  }
  
  func getIds(forUsernames usernames: [String], handler: @escaping (_ uidArray: [String]) -> ()) {
      REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
          var idArray = [String]()
          guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
          for user in userSnapshot {
              let email = user.childSnapshot(forPath: "email").value as! String
              
              if usernames.contains(email) {
                  idArray.append(user.key)
              }
          }
          handler(idArray)
      }
  }
  
  func getEmailsFor(gruppe: Grupper, handler: @escaping (_ emailArray: [String]) -> ()) {
      var emailArray = [String]()
      REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
          guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
          for user in userSnapshot {
              if gruppe.medlemmer.contains(user.key) {
                  let email = user.childSnapshot(forPath: "email").value as! String
                  emailArray.append(email)
              }
          }
          handler(emailArray)
      }
  }

  func getChatEmailsFor(gruppe: ChatGruppe, handler: @escaping (_ emailArray: [String]) -> ()) {
    var emailArray = [String]()
    REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
      guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
      for user in userSnapshot {
        if gruppe.medlemmer.contains(user.key) {
          let email = user.childSnapshot(forPath: "email").value as! String
          emailArray.append(email)
        }
      }
      handler(emailArray)
    }
  }
  
  func createGroup(holdnavn: String, ejernavn: String, forUserIds ids: [String], handler: @escaping (_ groupCreated: Bool) -> ()) {
      REF_GROUPS.childByAutoId().updateChildValues(["holdnavn": holdnavn, "ejernavn": ejernavn, "medlemmer": ids])
      handler(true)
  }

  func createChatGroup(forUserIds ids: [String], handler: @escaping (_ groupCreated: Bool) -> ()) {
    REF_CHAT.childByAutoId().updateChildValues(["medlemmer": ids])
    handler(true)
  }
  

  func getAllChatGroups(handler: @escaping (_ groupsArray: [ChatGruppe]) -> ()) {
    var groupsArray = [ChatGruppe]()
    REF_CHAT.observeSingleEvent(of: .value) { (groupSnapshot) in
      guard let groupSnapshot = groupSnapshot.children.allObjects as? [DataSnapshot] else { return }
      for group in groupSnapshot {
        let memberArray = group.childSnapshot(forPath: "medlemmer").value as! [String]
        if memberArray.contains((Auth.auth().currentUser?.uid)!) {
          let group = ChatGruppe(key: group.key, medlemmer: memberArray)
          groupsArray.append(group)
        }
      }
      handler(groupsArray)
    }
  }
  
  func getAllGroups(handler: @escaping (_ groupsArray: [Grupper]) -> ()) {
      var groupsArray = [Grupper]()
      REF_GROUPS.observeSingleEvent(of: .value) { (groupSnapshot) in
          guard let groupSnapshot = groupSnapshot.children.allObjects as? [DataSnapshot] else { return }
          for group in groupSnapshot {
              let memberArray = group.childSnapshot(forPath: "medlemmer").value as! [String]
              if memberArray.contains((Auth.auth().currentUser?.uid)!) {
                  let holdnavn = group.childSnapshot(forPath: "holdnavn").value as! String
                  let ejernavn = group.childSnapshot(forPath: "ejernavn").value as! String
                let group = Grupper(holdNavn: holdnavn, ejerNavn: ejernavn, key: group.key, medlemmer: memberArray, antalMedlemmer: memberArray.count)
                  groupsArray.append(group)
              }
          }
          handler(groupsArray)
        }
    }
  
  func getAllDagbog(handler: @escaping (_ texts: [Dagbog]) -> ()) {
    var textArray = [Dagbog]()
    REF_TEXT.observeSingleEvent(of: .value) { (textSnapshot) in
      guard let textSnapshot = textSnapshot.children.allObjects as? [DataSnapshot] else { return }
        for text in textSnapshot {
          let overskrift = text.childSnapshot(forPath: "overskrift").value as! String
          let texts = text.childSnapshot(forPath: "text").value as! String
          let text = Dagbog(overskrift: overskrift, text: texts)
          textArray.append(text)
        }
        handler(textArray)
    }
  }
}


















