//
//  DetailViewController.swift
//  PlainNoteTaker
//
//  Created by Scott Kriss on 5/1/17.
//  Copyright © 2017 Scott Kriss. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var bottomSpacingConstraint: NSLayoutConstraint!
    @IBOutlet weak var testView: UITextView!
    var text:String = ""
    var masterView:ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sets the right nav button to Back or in this case Save
        self.navigationItem.hidesBackButton = true
        let newSaveButton = UIBarButtonItem(title: "Save note", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DetailViewController.save(sender:)))
        self.navigationItem.rightBarButtonItem = newSaveButton
        
        // Do any additional setup after loading the view.
        testView.text = text
        testView.becomeFirstResponder()
        testView.isScrollEnabled = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(animateWithKeyboard(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(animateWithKeyboard(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
        
    }
    
    func save(sender: UIBarButtonItem) {
        // Perform your custom actions
        // ...
        // Go back to the previous ViewController
        _ = navigationController?.popViewController(animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setText(t:String){
        text = t
        if isViewLoaded {
            testView.text = t
        }
    }
    
    func animateWithKeyboard(notification: NSNotification) {
        
        // Based on both Apple's docs and personal experience,
        // I assume userInfo and its documented keys are available.
        // If you'd like, you can remove the forced unwrapping and add your own default values.
        
        let userInfo = notification.userInfo!
        let keyboardHeight = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! Double
        let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as! UInt
        let moveUp = (notification.name == NSNotification.Name.UIKeyboardWillShow)
        
        // baseContraint is your Auto Layout constraint that pins the
        // text view to the bottom of the superview.
        
        bottomSpacingConstraint.constant = moveUp ? -keyboardHeight : 0
        
        let options = UIViewAnimationOptions(rawValue: curve << 16)
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: {self.view.layoutIfNeeded()},completion: nil)
        
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
