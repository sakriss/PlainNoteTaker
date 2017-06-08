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
    var text = NSMutableAttributedString(string: "")
    var masterView:ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sets the right nav button to Back or in this case Save
        //self.navigationItem.hidesBackButton = true
        
        //this is used to set the Save Note on the right side of the UIbar
        //let newSaveButton = UIBarButtonItem(title: "Save note", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DetailViewController.save(sender:)))
        //self.navigationItem.rightBarButtonItem = newSaveButton
        
        // Do any additional setup after loading the view.
        testView.attributedText = text
        testView.becomeFirstResponder()
        testView.isScrollEnabled = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(animateWithKeyboard(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(animateWithKeyboard(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
        
        addCustomMenu()
        
    }
    
    func addCustomMenu() {
        
        let changeTextColorGreen = UIMenuItem(title: "Green", action: #selector(changeColorGreen))
        let changeTextColorRed = UIMenuItem(title: "Red", action: #selector(changeColorRed))
        let changeTextColorBlack = UIMenuItem(title: "Black", action: #selector(changeColorBlack))
        let changeTextStyleBold = UIMenuItem(title: "Bold", action: #selector(changeStyleBold))
        let changeTextStyleItalic = UIMenuItem(title: "Italic", action: #selector(changeStyleItalic))
        let changeTextStylePlain = UIMenuItem(title: "Plain", action: #selector(changeStylePlain))
        let changeTextHighlight = UIMenuItem(title: "Highlight", action: #selector(changeHighlight))
        UIMenuController.shared.menuItems = [changeTextColorGreen,changeTextColorRed,changeTextColorBlack,changeTextStyleBold,changeTextStyleItalic, changeTextStylePlain,changeTextHighlight]
    }
    
    func changeColorGreen() {
        if let range = testView.selectedTextRange {
            
            let string = NSMutableAttributedString(attributedString: testView.attributedText)
            let attributes = [NSForegroundColorAttributeName: UIColor.green]
            string.addAttributes(attributes, range: testView.selectedRange)
            testView.attributedText = string
            testView.selectedTextRange = range

        }
    }
    func changeColorRed() {
        if let range = testView.selectedTextRange {
            
            let string = NSMutableAttributedString(attributedString: testView.attributedText)
            let attributes = [NSForegroundColorAttributeName: UIColor.red]
            string.addAttributes(attributes, range: testView.selectedRange)
            testView.attributedText = string
            testView.selectedTextRange = range
            
        }
    }
    
    func changeColorBlack() {
        if let range = testView.selectedTextRange {
            
            let string = NSMutableAttributedString(attributedString: testView.attributedText)
            let attributes = [NSForegroundColorAttributeName: UIColor.black]
            string.addAttributes(attributes, range: testView.selectedRange)
            testView.attributedText = string
            testView.selectedTextRange = range
            
        }
    }
    
    func changeStyleBold() {
        if let range = testView.selectedTextRange {
            
            let string = NSMutableAttributedString(attributedString: testView.attributedText)
            let attributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15.0)]
            string.addAttributes(attributes, range: testView.selectedRange)
            testView.attributedText = string
            testView.selectedTextRange = range
            
        }
    }
    
    func changeStyleItalic() {
        if let range = testView.selectedTextRange {
            
            let string = NSMutableAttributedString(attributedString: testView.attributedText)
            let attributes = [NSFontAttributeName: UIFont.italicSystemFont(ofSize: 15.0)]
            string.addAttributes(attributes, range: testView.selectedRange)
            testView.attributedText = string
            testView.selectedTextRange = range
            
        }
    }
    
    func changeStylePlain() {
        if let range = testView.selectedTextRange {
            
            let string = NSMutableAttributedString(attributedString: testView.attributedText)
            let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightRegular), NSBackgroundColorAttributeName: UIColor.white]
            string.addAttributes(attributes, range: testView.selectedRange)
            testView.attributedText = string
            testView.selectedTextRange = range
            
        }
    }
    
    func changeHighlight() {
        if let range = testView.selectedTextRange {
            
            let string = NSMutableAttributedString(attributedString: testView.attributedText)
            let attributes = [NSBackgroundColorAttributeName: UIColor.yellow]
            string.addAttributes(attributes, range: testView.selectedRange)
            testView.attributedText = string
            testView.selectedTextRange = range
            
        }
    }
    
    func save(sender: UIBarButtonItem) {
        
        //Go back to the previous ViewController
        _ = navigationController?.popViewController(animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setText(t:NSMutableAttributedString){
        text = t
        if isViewLoaded {
            testView.attributedText = t
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
        masterView.newRowText = NSMutableAttributedString(attributedString: testView.attributedText)
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
