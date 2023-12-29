//
//  DummyView.swift
//  toolbar
//
//  Created by lam luong van on 29/12/2023.
//

import SwiftUI

struct ToolbarItem: View {
  @ObservedObject var websocket = WebsocketConnection()
  
  var body: some View {
    VStack(alignment: .trailing) {
     
      Text("\(websocket.eth) E").font(.system(size: 10))
      Text("\(websocket.hold) H").font(.system(size: 10))
    }
  }
}
