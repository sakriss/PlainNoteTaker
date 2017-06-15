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
    
    var defaultAttributes:[String:Any] {
        if let font = self.font, let color = self.textColor {
            return [NSFontAttributeName: font, NSForegroundColorAttributeName: color]
        }
        return [:]
    }
    
    override func paste(_ sender: Any?) {
        
        if let image = UIPasteboard.general.image {
            
            //resize the image
            let newWidth = self.frame.width * 0.6
            let newSize = CGSize(width: newWidth, height: newWidth * (image.size.height/image.size.width))
            UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
            image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            let textAttachment = NSTextAttachment()
            textAttachment.image = resizedImage
            
            let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)
            var attrs = defaultAttributes
            if mutableAttributedText.length > 0 {
                attrs = mutableAttributedText.attributes(at: mutableAttributedText.length-1, effectiveRange: nil)
            }
            mutableAttributedText.append(NSAttributedString(string: "\n"))
            mutableAttributedText.append(NSAttributedString(attachment: textAttachment))
            mutableAttributedText.append(NSAttributedString(string: "\n"))
            mutableAttributedText.setAttributes(attrs, range: NSMakeRange(mutableAttributedText.length-1, 1))
            
            attributedText = mutableAttributedText
        }
        else {
            super.paste(sender)
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
        let changeTextColorBlue = UIMenuItem(title: "Blue", action: #selector(changeColorBlue))
        let changeTextColorBlack = UIMenuItem(title: "Black", action: #selector(changeColorBlack))
        let changeTextColorOrange = UIMenuItem(title: "Orange", action: #selector(changeColorOrange))
        let changeTextStyleBold = UIMenuItem(title: "Bold", action: #selector(changeStyleBold))
        let changeTextStyleItalic = UIMenuItem(title: "Italic", action: #selector(changeStyleItalic))
        let changeTextStylePlain = UIMenuItem(title: "Undo Style", action: #selector(changeStylePlain))
        let changeTextHighlight = UIMenuItem(title: "Highlight", action: #selector(changeHighlight))
        
        //this is setting up the menu and displaying them in this particular order
        UIMenuController.shared.menuItems = [changeTextColorGreen,changeTextColorRed,changeTextColorBlue,changeTextColorOrange,changeTextColorBlack,changeTextStyleBold,changeTextStyleItalic,changeTextHighlight,changeTextStylePlain]
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        switch action {
        case #selector(changeColorGreen),
             #selector(changeColorRed),
             #selector(changeColorBlue),
             #selector(changeColorOrange),
             #selector(changeColorBlack),
             #selector(changeStyleBold),
             #selector(changeStyleItalic),
             #selector(changeHighlight),
            #selector(changeStylePlain):
            return inCustomMenu
        case #selector(UIResponderStandardEditActions.paste(_:)):
            if inCustomMenu {
                return false
            }
            else {
                return UIPasteboard.general.hasImages || UIPasteboard.general.hasStrings
            }
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
    func changeColorBlue() {
        inCustomMenu = false
        if let range = self.selectedTextRange {
            
            let string = NSMutableAttributedString(attributedString: self.attributedText)
            let attributes = [NSForegroundColorAttributeName: UIColor.blue]
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
