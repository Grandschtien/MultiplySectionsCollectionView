//
//  NameViewController.swift
//  MultiplySectionsInCollectionView
//
//  Created by Егор Шкарин on 14.07.2021.
//

import UIKit

class NameViewController: UIViewController {
    var name = ""
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = name
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
