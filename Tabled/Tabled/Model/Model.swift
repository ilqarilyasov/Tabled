//
//  Model.swift
//  Tabled
//
//  Created by Ilgar Ilyasov on 1/10/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class Model {
    
    static let shared = Model()
    private init() {}
    
    private var items: [String] = []
    
    func addItem(_ item: String) {
        items.append(item)
    }
    
    func removeItem(at index: Int) {
        items.remove(at: index)
    }
    
    func moveItem(from index: Int, to destinationIndex: Int) {
        let item = items[index]
        let itemAtDestination = items[destinationIndex]
        items[index] = itemAtDestination
        items[destinationIndex] = item
    }
    
    func itemCount() -> Int {
        return items.count
    }
    
    func item(at index: Int) -> String {
        return items[index]
    }
    
    func edit(item: String, at index: Int){
        items[index] = item
    }
    
    let fileURL = URL(fileURLWithPath: NSHomeDirectory())
    .appendingPathComponent("Library")
    .appendingPathComponent("ToDo")
    .appendingPathExtension("plist")
    
    func saveData() {
        try! (items as NSArray).write(to: fileURL)
    }
    
    func loadDate() {
        if let items = NSArray(contentsOf: fileURL) as? [String] {
            self.items = items
        }
    }
}
