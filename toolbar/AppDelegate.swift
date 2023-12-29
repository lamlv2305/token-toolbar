//
//  AppDelegate.swift
//  toolbar
//
//  Created by lam luong van on 29/12/2023.
//

import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {
  
  //  @IBOutlet var window: NSWindow!
  
  
  private var popover: NSPopover!
  private var statusBarItem: NSStatusItem!
  
  func applicationDidFinishLaunching(_ aNotification: Notification) {
    setupUI()
  }
  
  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }
  
  func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }
  
  // create the bar UI
  private func setupUI() {
    // use NSHostingView to pass a SwiftUI view
    let iconView = NSHostingView(rootView: ToolbarItem())
    
    // size must be defined
    iconView.frame = NSRect(x: 0, y: 0, width: 70, height: 22)
    
    statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
    
    // add a right click action
    statusBarItem.button?.action = #selector(toggleMenu(_:))
    statusBarItem.button?.sendAction(on: [.rightMouseDown])
    
    statusBarItem.button?.addSubview(iconView)
    statusBarItem.button?.frame = iconView.frame
  }
  
  // the right-click action
  @objc func toggleMenu(_ sender: Any?) {
    let event = NSApp.currentEvent!
    if event.type == .rightMouseDown {
      statusBarItem.menu = constructMenu()
      
      let pos = NSPoint(x: statusBarItem.button!.bounds.origin.x, y: statusBarItem.button!.bounds.origin.y + statusBarItem.button!.bounds.size.height + 5)
      statusBarItem.menu!.popUp(positioning: nil, at: pos, in: statusBarItem.button)
    }
    
    statusBarItem.menu = nil
    statusBarItem.button!.action = #selector(toggleMenu(_:))
  }
  
  // create your right-click menu
  func constructMenu() -> NSMenu {
    let menu = NSMenu()
    menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
    return menu
  }
}

