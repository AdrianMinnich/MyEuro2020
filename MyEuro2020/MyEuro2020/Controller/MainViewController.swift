//
//  MainViewController.swift
//  MyEuro2020
//
//  Created by Adrian Minnich on 04/06/2021.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "logo")
        
        navigationController?.edgesForExtendedLayout = []
    }
    
    @IBAction func didTapResultsButton(_ sender: Any) {
        //let vc = storyboard?.instantiateViewController(identifier: ResultsViewController.identifier) as! ResultsViewController
        
        //navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapPredictorButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: PredictorViewController.identifier) as! PredictorViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

