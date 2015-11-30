//
//  NoteTextView.swift
//  PickList
//
//  Created by David Rollins on 11/29/15.
//  Copyright © 2015 David Rollins. All rights reserved.
//

import UIKit

class NoteTextView: UITextView, UITextViewDelegate {
    
    let EditEvent:NotificationEvent<String> = NotificationEvent<String>()

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tapGr = UITapGestureRecognizer(target: self, action:"tap")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didBeginEditing", name:UITextFieldTextDidBeginEditingNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didEndEditing", name:UITextFieldTextDidEndEditingNotification, object: nil)
        
        //self.addGestureRecognizer(tapGr)
        
        self.delegate = self
        
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    var tapGr:UITapGestureRecognizer!
    
    func tap(){
        
        if self.isFirstResponder() {
            self.resignFirstResponder()
        }
        
        //self.endEditing(true)
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        EditEvent.raise("BeginEditing")
        self.superview!.addGestureRecognizer(tapGr)
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        EditEvent.raise("EndEditing")
        self.superview!.removeGestureRecognizer(tapGr)
    }
    

//    override func setContentOffset(contentOffset: CGPoint, animated: Bool) {
//        if self.tracking == true || self.decelerating == true {
//            self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        }
//        else {
//            let bottomOffset:CGFloat = (self.contentSize.height - self.frame.size.height + self.contentInset.bottom)
//            if contentOffset.y < bottomOffset && self.scrollEnabled == true {
//                self.contentInset = UIEdgeInsetsMake(0, 0, 8, 0)
//            }
//        }
//    }

}
