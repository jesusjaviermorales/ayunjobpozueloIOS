//
//  LoginController.swift
//  ayunjobpozuelo
//
//  Created by avansis on 15/01/16.
//  Copyright (c) 2016 avansis. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UITextFieldDelegate {

    @IBOutlet var nombreUsuario: UITextField!

    @IBOutlet var contrasena: UITextField!
    
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBarHidden = true
        
        nombreUsuario.delegate = self
        contrasena.delegate = self
        
    }
    
    @IBAction func Close(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    @IBAction func Acceder(sender: AnyObject) {
        
        if(nombreUsuario.text.isEmpty || contrasena.text.isEmpty) {
            
            let alertController = UIAlertController(title: "Información", message:
                "Introduzca el usuario y contraseña", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            
        }
        else{
            
        
        DataManager.generateLoginString(nombreUsuario.text, pass1: contrasena.text)
        
        DataManager.getLoginWithSuccess { (iTunesData) -> Void in
            let json: JSON = JSON(data: iTunesData)
            /*   if let appName = json[0]["titulo"].string {
            println("NSURLSession: \(appName)")
            }
            */
            
           // json.isEmpty
            let appArray = json.array
            
            if(!json.isEmpty) {
                
                for (key: String, subJson: JSON) in json {
                    
                    var id: String = subJson["id"].stringValue
                    var usuario: String = subJson["usuario"].stringValue
                    var pass: String = subJson["contrasena"].stringValue
                    
                    NSUserDefaults.standardUserDefaults().setObject(usuario, forKey: "username")
                    NSUserDefaults.standardUserDefaults().setObject(usuario, forKey: "idUser")
                    
                    break;
                    
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    if let nc = self.navigationController {
                        nc.popViewControllerAnimated(true)
                    }
                }

            } else{
                
               
                
                
                dispatch_async(dispatch_get_main_queue()) {
                   
                    let alertController = UIAlertController(title: "Información", message:
                        "El usuario es incorrecto", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                    
                }
                
                
                
                
                
                
            }
            
        }
            
             }
       
        
        
            
        
       urlLogin = "http://www.ayunjob.com/myphp/rest/mobile/getuser.php?filterbyfield1=usuario&filterbyfield2=contrasena&value1=username&value2=pass"
            
            
        
        
      
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var segueID = segue.identifier
        
        if(segueID! == "iraweb"){
            
            var yourVC:WebViewController = segue.destinationViewController as WebViewController
            
            yourVC.urlToOpen = "http://www.ayunjob.com/registro/";
            
            segue.destinationViewController
            
        }
    }

    
   /* func textFieldShouldReturn(textField: UITextField) -> Bool {
        println("TextField should return method called")
        contrasena.resignFirstResponder();
        return true;
    }*/
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField === nombreUsuario) {
            contrasena.becomeFirstResponder()
        } else if (textField === contrasena) {
            contrasena.resignFirstResponder()
        } else {
            // etc
        }
        
        return true
    }
    
    
    
    
    

}