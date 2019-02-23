//
//  projectsViewController.swift
//  Rotaract Mobile
//
//  Created by Jonathan Gurusinghe on 6/21/18.
//  Copyright © 2018 Jonathan Gurusinghe. All rights reserved.
//

import UIKit
import Firebase
import MessageUI


class projectsViewController: UIViewController, UITextFieldDelegate, MFMailComposeViewControllerDelegate{
   
    @IBOutlet weak var proTitle: UITextField!
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var Date: UITextField!
    
    @IBOutlet weak var location: UITextField!
    
    @IBOutlet weak var contact: UITextField!
    
    @IBOutlet weak var descript: UITextField!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        proTitle.delegate = self
        name.delegate = self
        Date.delegate = self
        location.delegate = self
        contact.delegate = self
        descript.delegate = self
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func send(_ sender: AnyObject)
    {
        
        let user = [
            "Project Title": proTitle.text!,
            "Name": name.text!,
            "Date": Date.text!,
            "Location": location.text!,
            "Contact": contact.text!,
            "Description": descript.text!
            
        ]
        self.ref.child("Rotaract Member").child("details").setValue(user)
        
        
        let toRecepients = ["vimukthi.2016374@iit.ac.lk"]
        
        let mc: MFMailComposeViewController = MFMailComposeViewController()
        
        mc.mailComposeDelegate = self
        
        mc.setToRecipients(toRecepients)
        mc.setSubject("Send project Details")
        
        mc.setMessageBody("Project Title: \(proTitle.text!) \n\nName: \(name.text!) \n\nDate: \(Date.text!) \n\nLocation: \(location.text!) \n\nContact: \(contact.text!) \n\nProject Description: \(descript.text!) \n\nProject Details in Full:    \nPlease Attach the Poster!", isHTML: false)
        
        self.present(mc, animated: true, completion: nil)
        
        let alert = UIAlertController(title: "Alert", message: "Thank you for the information, please await until the president confirms", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        self.present(alert, animated: true, completion: nil)
        
        
        
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue:
            print("Cancelled")
            
        case MFMailComposeResult.failed.rawValue:
            print("Failed")
            
        case MFMailComposeResult.saved.rawValue:
            print("Saved")
            
        case MFMailComposeResult.sent.rawValue:
            print("Sent")
            
        default:
            break
        }
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    //dismissing the keyboard
    override func touchesBegan(_: Set<UITouch>, with: UIEvent?) {
        proTitle.resignFirstResponder()
        name.resignFirstResponder()
        Date.resignFirstResponder()
        location.resignFirstResponder()
        contact.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        proTitle.resignFirstResponder()
        name.resignFirstResponder()
        Date.resignFirstResponder()
        location.resignFirstResponder()
        contact.resignFirstResponder()
        return true
    }
    
}



