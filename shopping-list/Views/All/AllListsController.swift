//
//  AllListsController.swift
//  shopping-list
//
//  Created by Mason Phillips on 8/11/20.
//

import UIKit
import Reusable
import RxCocoa
import RxSwift

class AllListsController: UIViewController, StoryboardBased, BaseControllerType {
    var model: AllListsModel!
    var stepper: AppStepper!
    
    let bag = DisposeBag()
    
    @IBOutlet weak var table: UITableView!
    
    var leftButton: UIBarButtonItem {
        let button = UIBarButtonItem(title: "\u{f067}", style: .plain, target: self, action: #selector(toCreate))
        button.setTitleTextAttributes([.font: FAFont.regular.font], for: .normal)
        button.setTitleTextAttributes([.font: FAFont.regular.font], for: .highlighted)
        return button
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = leftButton
        
        table.rx.setDelegate(self).disposed(by: bag)
        model.listRelay
            .bind(to: table.rx.items(cellIdentifier: "listCell")) { index, item, cell in
                cell.textLabel?.text = item.name
            }.disposed(by: bag)
    }
    
    @objc func toCreate() {
        self.stepper.steps.accept(AppStep.create)
    }
}

extension AllListsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = model.listRelay.value[indexPath.row]
        stepper.steps.accept(AppStep.list(id: item.identifier))
    }
}

