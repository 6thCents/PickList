//
//  NoteTableViewController.swift
//  PickList
//
//  Created by David Rollins on 11/28/15.
//  Copyright © 2015 David Rollins. All rights reserved.
//

import UIKit

class NoteTableViewController: UITableViewController, UITextViewDelegate {
    
    var textViewBottomMarginValue:CGFloat = -1.0
    
    var isSensitive:Bool? {
        didSet{
            if let val = isSensitive {
                if val == true {
                    cmdSensitiveButton.tintColor = UIColor(netHex:0xd42b2b)
                    lblSensitive.textColor = UIColor.blackColor()
                }
                else{
                    cmdSensitiveButton.tintColor = UIColor.lightGrayColor()
                    lblSensitive.textColor = UIColor.lightGrayColor()
                }
            }
            else{
                cmdSensitiveButton.tintColor = UIColor.lightGrayColor()
                lblSensitive.textColor = UIColor.lightGrayColor()
            }
        }
    }
    var isDCC:Bool? {
        didSet{
            if let val = isDCC {
                if val == true {
                    cmdDCCButton.tintColor = UIColor(netHex:0xd42b2b)
                    lblDCC.textColor = UIColor.blackColor()
                }
                else {
                    cmdDCCButton.tintColor = UIColor.lightGrayColor()
                    lblDCC.textColor = UIColor.lightGrayColor()
                }
            }
            else{
                cmdDCCButton.tintColor = UIColor.lightGrayColor()
                lblDCC.textColor = UIColor.lightGrayColor()
            }
        }
    }
    
    var isPriority:Bool? {
        didSet{
            if let val = isPriority {
                if val == true{
                    cmdPriorityButton.tintColor = UIColor(netHex:0xd42b2b)
                    lblPriority.textColor = UIColor.blackColor()
                }
                else{
                    cmdPriorityButton.tintColor = UIColor.lightGrayColor()
                    lblPriority.textColor = UIColor.lightGrayColor()
                }
                
            }
            else {
                cmdPriorityButton.tintColor = UIColor.lightGrayColor()
                lblPriority.textColor = UIColor.lightGrayColor()

            }
           
        }
    }
    
    @IBOutlet weak var lblPriority: UILabel!
    @IBOutlet weak var lblDCC: UILabel!
    @IBOutlet weak var lblSensitive: UILabel!
    @IBOutlet weak var cmdSensitiveButton: UIButton!
    @IBOutlet weak var cmdDCCButton: UIButton!
    @IBOutlet weak var cmdPriorityButton: UIButton!
    
    @IBAction func cmdSensitive(sender: AnyObject) {
        if let val = isSensitive{
            isSensitive = val == true ? false : true
        }
        else{
            isSensitive = true;
        }
    }
    
    @IBAction func cmdDCC(sender: AnyObject) {
        if let val = isDCC {
            isDCC = val == true ? false : true
        }
        else{
            isDCC = true
        }
        
    }
    
    @IBAction func cmdPriority(sender: AnyObject) {
        
        if let val = isPriority {
            isPriority = val == true ? false : true
        }
        else{
            isPriority = true
        }
        
    }
    
    @IBOutlet weak var noteBottomMargin: NSLayoutConstraint!
    
    @IBOutlet weak var lblTopic: UILabel!
    @IBOutlet weak var lblSubject: UILabel!
    
    @IBOutlet weak var subjectTableCell: UITableViewCell!
    @IBOutlet weak var lblSubjectPrompt: UILabel!
    
    var TopicItems:PickItem = PickItem()
    var SubjectItems:PickItem = PickItem()
    
    let tap = UITapGestureRecognizer()
    
    @IBOutlet weak var txtNoteBody: UITextView!
    
    var currentTopic: String = ""
    
    var topicItem:String = "" {
        didSet {
            lblTopic.text = topicItem
            if topicItem != currentTopic {
                //clear subject
                subjectItem = "Choose"
            }
            currentTopic = topicItem
        }
    }

    var subjectItem:String = "" {
        didSet {
            lblSubject.text = subjectItem
        }
    }
    
    @IBAction func unwindWithSelectedNoteItem(segue:UIStoryboardSegue) {
        
        if let controller = segue.sourceViewController as? PickerTableViewController{
            
            if controller.items.title == "Note Topics" {
                topicItem = controller.items.selectedVal
                ToggleSubjectCell(true)
            }
            else{
                if controller.items.title == "Note Subjects" {
                    subjectItem = controller.items.selectedVal
                }
            }
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TopicItems.title = "Note Topics"
        TopicItems.selectedVal = "";
        TopicItems.items = ["Topic1","Topic2","Topic3","Topic4"]

        SubjectItems.title = "Note Subjects"
        SubjectItems.selectedVal = ""
        SubjectItems.items = ["Subject1", "Subject2", "Subject3", "Subject4"]
        
        ToggleSubjectCell(false)

        txtNoteBody.layer.cornerRadius = 5
        txtNoteBody.layer.borderColor = UIColor.grayColor().colorWithAlphaComponent(0.5).CGColor
        txtNoteBody.layer.borderWidth = 0.5
        txtNoteBody.clipsToBounds = true
        
        let tnb = txtNoteBody as! NoteTextView
        tnb.EditEvent.addHandler(ResizeNoteBody)
        
    }
    
    func ResizeNoteBody(msg:String){
        
        switch(msg){
            case "BeginEditing":
                textViewBottomMarginValue = 56.0
                view.layoutIfNeeded()
                break;
            case "EndEditing":
                textViewBottomMarginValue = -0.0
                view.layoutIfNeeded()
                break;
            default:
                textViewBottomMarginValue = -0.0
            break
        }
        
        if textViewBottomMarginValue != -1.0 {
            self.view.layoutIfNeeded()
            UIView.animateWithDuration(0.5, animations: {
                self.noteBottomMargin.constant = self.textViewBottomMarginValue
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func ToggleSubjectCell(enabled:Bool){

        subjectTableCell.userInteractionEnabled = enabled
        lblSubjectPrompt.textColor = enabled == true ? UIColor.blackColor() : UIColor.lightGrayColor()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let controller = segue.destinationViewController as? PickerTableViewController{
            switch(segue.identifier!){
                case "Topic":
                    controller.items = TopicItems;
                    controller.items.selectedVal = self.lblTopic.text!
                    break
                case "Subject":
                    controller.items = SubjectItems;
                    controller.items.selectedVal = self.lblSubject.text!

                    break
                default:
                    break
            }
        }
        
    }

}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}
