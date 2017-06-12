//
//  ScottsCoolTextView.swift
//  PlainNoteTaker
//
//  Created by Scott Kriss on 6/8/17.
//  Copyright © 2017 Scott Kriss. All rights reserved.
//

import UIKit

class ScottsCoolTextView: UITextView {
    
    var inCustomMenu = false {
        didSet {
            if inCustomMenu {
                addCustomMenu()
                //this will show my new custom menu once you tap on Markup
                UIMenuController.shared.setMenuVisible(true, animated: true)
            }
            else {
                addCustomButton()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addCustomButton()
    }
    
    func addCustomButton() {
        //this is where we are creating the custom 'Markup' menu button on the default row
        let goToMarkupMenuItem = UIMenuItem(title: "Markup", action: #selector(goToMarkupMenu))
        UIMenuController.shared.menuItems = [goToMarkupMenuItem]
        
    }

    func addCustomMenu() {
        let changeTextColorGreen = UIMenuItem(title: "Green", action: #selector(changeColorGreen))
        let changeTextColorRed = UIMenuItem(title: "Red", action: #selector(changeColorRed))
        let changeTextColorBlack = UIMenuItem(title: "Black", action: #selector(changeColorBlack))
        let changeTextColorOrange = UIMenuItem(title: "Orange", action: #selector(changeColorOrange))
        let changeTextStyleBold = UIMenuItem(title: "Bold", action: #selector(changeStyleBold))
        let changeTextStyleItalic = UIMenuItem(title: "Italic", action: #selector(changeStyleItalic))
        let changeTextStylePlain = UIMenuItem(title: "Undo Style", action: #selector(changeStylePlain))
        let changeTextHighlight = UIMenuItem(title: "Highlight", action: #selector(changeHighlight))
        
        //this is setting up the menu and displaying them in this particular order
        UIMenuController.shared.menuItems = [changeTextColorGreen,changeTextColorRed,changeTextColorOrange,changeTextColorBlack,changeTextStyleBold,changeTextStyleItalic,changeTextHighlight,changeTextStylePlain]
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        switch action {
        case #selector(changeColorGreen),
             #selector(changeColorRed),
             #selector(changeColorOrange),
             #selector(changeColorBlack),
             #selector(changeStyleBold),
             #selector(changeStyleItalic),
             #selector(changeHighlight),
            #selector(changeStylePlain):
            return inCustomMenu
        default:
            if inCustomMenu {
                return false
            }
            return super.canPerformAction(action, withSender: sender)
        }
    }


    func goToMarkupMenu() {
        inCustomMenu = true
    }
    
    func changeColorGreen() {
        inCustomMenu = false
        if let range = self.selectedTextRange {
            
            let string = NSMutableAttributedString(attributedString: self.attributedText)
            let attributes = [NSForegroundColorAttributeName: UIColor.green]
            string.addAttributes(attributes, range: self.selectedRange)
            self.attributedText = string
            self.selectedTextRange = range
            
        }
    }
    
    func changeColorRed() {
        inCustomMenu = false
        if let range = self.selectedTextRange {
            
            let string = NSMutableAttributedString(attributedString: self.attributedText)
            let attributes = [NSForegroundColorAttributeName: UIColor.red]
            string.addAttributes(attributes, range: self.selectedRange)
            self.attributedText = string
            self.selectedTextRange = range
            
        }
    }
    
    func changeColorOrange() {
        inCustomMenu = false
        if let range = self.selectedTextRange {
            
            let string = NSMutableAttributedString(attributedString: self.attributedText)
            let attributes = [NSForegroundColorAttributeName: UIColor.orange]
            string.addAttributes(attributes, range: self.selectedRange)
            self.attributedText = string
            self.selectedTextRange = range
            
        }
    }
    
    func changeColorBlack() {
        inCustomMenu = false
        if let range = self.selectedTextRange {
            
            let string = NSMutableAttributedString(attributedString: self.attributedText)
            let attributes = [NSForegroundColorAttributeName: UIColor.black]
            string.addAttributes(attributes, range: self.selectedRange)
            self.attributedText = string
            self.selectedTextRange = range
            
        }
    }
    
    func changeStyleBold() {
        inCustomMenu = false
        if let range = self.selectedTextRange {
            
            let string = NSMutableAttributedString(attributedString: self.attributedText)
            let attributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15.0)]
            string.addAttributes(attributes, range: self.selectedRange)
            self.attributedText = string
            self.selectedTextRange = range
            
        }
    }
    
    func changeStyleItalic() {
        inCustomMenu = false
        if let range = self.selectedTextRange {
            
            let string = NSMutableAttributedString(attributedString: self.attributedText)
            let attributes = [NSFontAttributeName: UIFont.italicSystemFont(ofSize: 15.0)]
            string.addAttributes(attributes, range: self.selectedRange)
            self.attributedText = string
            self.selectedTextRange = range
            
        }
    }
    
    func changeStylePlain() {
        inCustomMenu = false
        if let range = self.selectedTextRange {
            
            let string = NSMutableAttributedString(attributedString: self.attributedText)
            let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightRegular), NSBackgroundColorAttributeName: UIColor.clear]
            string.addAttributes(attributes, range: self.selectedRange)
            self.attributedText = string
            self.selectedTextRange = range
            
        }
    }
    
    func changeHighlight() {
        inCustomMenu = false
        if let range = self.selectedTextRange {
            
            let string = NSMutableAttributedString(attributedString: self.attributedText)
            let attributes = [NSBackgroundColorAttributeName: UIColor.yellow]
            string.addAttributes(attributes, range: self.selectedRange)
            self.attributedText = string
            self.selectedTextRange = range
            
        }
    }
}
