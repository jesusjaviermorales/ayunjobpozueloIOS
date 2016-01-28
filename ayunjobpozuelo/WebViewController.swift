//
//  WebViewcontroller.swift
//  ayunjobpozuelo
//
//  Created by avansis on 13/01/16.
//  Copyright (c) 2016 avansis. All rights reserved.
//
import UIKit

class WebViewController: UIViewController {
    
    
    @IBOutlet weak var web: UIWebView!
    
    var urlToOpen: String!
  
    @IBAction func Close(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
   
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
        
        let nav = self.navigationController?.navigationBar
        //self.title = "Volver"
       // self.navigationController?.navigationItem.backBarButtonItem?.title = "Volver"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url: NSURL? = NSURL (string: urlToOpen);
        let requestObj = NSURLRequest(URL: url!);
        web.loadRequest(requestObj);
        
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

