//
//  DetailViewController.swift
//  PlainNoteTaker
//
//  Created by Scott Kriss on 5/1/17.
//  Copyright © 2017 Scott Kriss. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var testView: UITextView!
    var text:String = ""
    var masterView:ViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        testView.text = text
        testView.becomeFirstResponder()
    }
    
    func setText(t:String){
        text = t
        if isViewLoaded {
        testView.text = t
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        masterView.newRowText = testView.text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
