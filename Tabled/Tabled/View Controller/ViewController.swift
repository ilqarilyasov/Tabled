//
//  ViewController.swift
//  Tabled
//
//  Created by Ilgar Ilyasov on 1/10/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    let itemCont = ItemController()
    var editItemIndex: Int? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func add(_ sender: UIButton) {
        guard let text = textField.text, !text.isEmpty else { return }
//        Model.shared.addItem(text)
        
        if let index = editItemIndex {
//            Model.shared.edit(item: text, at: editItemIndex)
            itemCont.edit(item: text, at: index)
            tableView.reloadData()
        } else {
            itemCont.addItem(text)
            tableView.insertRows(at: [IndexPath(row: Model.shared.itemCount() - 1, section: 0)], with: .automatic)
        }
        textField.text = nil
        addButton.setTitle("Add", for: .normal)
    }
    
    @IBAction func editTable(_ sender: UIBarButtonItem) {
        tableView.setEditing(true, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(stopEditingTable(_sender:)))
    }
    
    @objc func stopEditingTable( _sender: Any) {
        tableView.setEditing(false, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTable(_:)))
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return Model.shared.itemCount()
        return itemCont.itemCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = Model.shared.item(at: indexPath.row)
        cell.textLabel?.text = itemCont.item(at: indexPath.row).title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else { return }
//        Model.shared.removeItem(at: indexPath.row)
        itemCont.removeItem(at: indexPath.row)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        Model.shared.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
        itemCont.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    // MARK: - Stretch Goals 1
    
    @IBAction func shareList(_ sender: Any) {
        let listArray = itemCont.items.map({ $0.title })
        let listString = listArray.joined(separator: "\n")
        let share = UIActivityViewController(activityItems: [listString], applicationActivities: nil)
        share.popoverPresentationController?.sourceView = self.view
        
        present(share, animated: true, completion: nil)
        print(listString)
    }
    
    // MARK: - Stretch Goal 2
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = itemCont.item(at: indexPath.row)
        textField.text = item.title
        addButton.setTitle("Done", for: .normal)
        editItemIndex = indexPath.row
    }
    
    // MARK: - Stretch Goal 3
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            print("Shaked the phone")
        }
    }
    
    // MARK: - Extra
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        add(UIButton())
        return true
    }
}
