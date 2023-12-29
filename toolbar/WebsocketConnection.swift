//
//  WebsocketConnection.swift
//  toolbar
//
//  Created by lam luong van on 29/12/2023.
//

import SwiftUI
import Starscream

class WebsocketConnection: ObservableObject {
  @Published var eth = "--"
  @Published var hold = "--"
  
  private var socket: WebSocket?
  private var isConnected = false
  
  init() {
    self.connect()
  }
  
  private func connect() {
    guard let url = URL(string: "wss://token-toolbar.lamlv.com/ws") else { return }
    var request = URLRequest(url: url)
    request.timeoutInterval = 10
    
    socket = WebSocket(request: request)
    socket?.delegate = self
    socket?.connect()
    
  }
}

extension WebsocketConnection: WebSocketDelegate {
  func websocketDidConnect(socket: WebSocketClient) {
    print("websocketDidConnect")
  }
  
  func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocketClient) {
    switch event {
    case .connected(let headers):
      isConnected = true
      print("websocket is connected: \(headers)")
      
    case .disconnected(let reason, let code):
      isConnected = false
      print("websocket is disconnected: \(reason) with code: \(code)")
      connect()
      
    case .text(let text):
      let arr = text.split(separator: "|")
      guard arr.count == 2 else { break }
      
      DispatchQueue.main.async { [weak self] in
        self?.eth = String(arr[0])
        self?.hold = String(arr[1])
      }
    case .binary(let data):
      print("Received data: \(data.count)")
      
    case .ping(_):
      break
    case .pong(_):
      break
    case .viabilityChanged(_):
      break
    case .reconnectSuggested(_):
      break
    case .cancelled:
      isConnected = false
    case .error(let error):
      isConnected = false
      print("Got error: \(String(describing: error))")
      
    case .peerClosed:
      break
    }
  }
}
