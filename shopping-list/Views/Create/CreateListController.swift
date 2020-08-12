//
//  CreateListController.swift
//  shopping-list
//
//  Created by Mason Phillips on 8/12/20.
//

import UIKit
import Reusable
import Eureka

class CreateListController: FormViewController {
    var model: CreateListModel!
    var stepper: AppStepper!
        
    var rightButton: UIBarButtonItem {
        let button = UIBarButtonItem(title: "\u{f0c7}", style: .plain, target: self, action: #selector(saveForm))
        button.setTitleTextAttributes([.font: FAFont.regular.font], for: .normal)
        button.setTitleTextAttributes([.font: FAFont.regular.font], for: .highlighted)
        return button
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = rightButton
        title = "New List"
        
        form
            +++ Section()
                <<< TextRow("list-name") { $0.placeholder = "List Name" }
            
            +++ MultivaluedSection(multivaluedOptions: [.Insert, .Delete], header: nil, footer: nil) {
                $0.tag = "list-items"
                $0.addButtonProvider = { _ in
                    return ButtonRow() { $0.title = "Add New Item" }
                }
                $0.multivaluedRowToInsertAt = { _ in
                    return TextRow() { $0.placeholder = "Milk..." }
                }
                
                $0 <<< TextRow() { $0.placeholder = "Milk..." }
            }
    }
    
    @objc func saveForm() {
        let name = (form.rowBy(tag: "list-name") as? TextRow)?.value ?? "NAMEERR"
        
        let mvs = form.sectionBy(tag: "list-items") as? MultivaluedSection
        var items: [String] = []
        for row in mvs?.allRows ?? [] {
            if let row = row as? TextRow {
                items.append(row.value ?? "ITEMERR")
            }
        }
        
        model.saveList(name: name, items: items)
        stepper.steps.accept(AppStep.done)
    }
}
