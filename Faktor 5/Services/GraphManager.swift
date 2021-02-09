//
//  GraphManager.swift
//  Faktor 5
//
//  Created by Thomas Hinrichs on 12/01/2021.
//  Copyright © 2021 Thomas Hinrichs. All rights reserved.
//

import Foundation
import MSGraphClientSDK
import MSGraphClientModels

class GraphManager {
  
  static let instance = GraphManager()
  
  private let client: MSHTTPClient?
  
  private init() {
    client = MSClientFactory.createHTTPClient(with: AuthenticationManager.instance)
  }
  
  public func getMe(completion: @escaping(MSGraphUser?, Error?) -> Void) {
    let meRequest = NSMutableURLRequest(url: URL(string: "\(MSGraphBaseURL)/me")!)
    let meDataTask = MSURLSessionDataTask(request: meRequest, client: self.client, completion: {
        (data: Data?, response: URLResponse?, graphError: Error?) in
        guard let meData = data, graphError == nil else {
            completion(nil, graphError)
            return
        }

        do {
            let user = try MSGraphUser(data: meData)
            completion(user, nil)
        } catch {
            completion(nil, error)
        }
    })

    meDataTask?.execute()
  }
  
  public func getEvents(completion: @escaping([MSGraphEvent]?, Error?) -> Void) {
      let select = "$select=subject,organizer,start,end"
      let orderBy = "$orderby=createdDateTime+DESC"
      let eventsRequest = NSMutableURLRequest(url: URL(string: "\(MSGraphBaseURL)/me/events?\(select)&\(orderBy)")!)
      let eventsDataTask = MSURLSessionDataTask(request: eventsRequest, client: self.client, completion: {
          (data: Data?, response: URLResponse?, graphError: Error?) in
          guard let eventsData = data, graphError == nil else {
              completion(nil, graphError)
              return
          }

          do {
              let eventsCollection = try MSCollection(data: eventsData)
              var eventArray: [MSGraphEvent] = []

              eventsCollection.value.forEach({
                  (rawEvent: Any) in
                  guard let eventDict = rawEvent as? [String: Any] else {
                      return
                  }

                  let event = MSGraphEvent(dictionary: eventDict)!
                  eventArray.append(event)
              })

              completion(eventArray, nil)
          } catch {
              completion(nil, error)
          }
      })

      eventsDataTask?.execute()
  }
  
}

