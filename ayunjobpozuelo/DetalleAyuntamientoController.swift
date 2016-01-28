//
//  OfertasController.swift
//  ayunjobpozuelo
//
//  Created by avansis on 25/02/15.
//  Copyright (c) 2015 avansis. All rights reserved.
//
import UIKit

import MessageUI

class DetalleAyuntamientoController: UIViewController, MFMailComposeViewControllerDelegate {
    
    var seleccionAyuntamiento = Ayuntamiento();
    
    @IBOutlet var telf1: UIButton!
  
    @IBOutlet var telf2: UIButton!
   // @IBOutlet weak var telefono1: UIButton!
    
//    @IBOutlet weak var telefono2: UIButton!
 
    @IBOutlet weak var mail: UIButton!
    
    @IBOutlet weak var texto: UILabel!
    
    
    @IBAction func Close(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        for ayun in ayuntamientos{
            
            if(ayun.id == idAyuntamiento){
                seleccionAyuntamiento = ayun;
                break
            
             }
        }
        
        telf1.setTitle(seleccionAyuntamiento.telefono, forState: UIControlState.Normal)
        telf2.setTitle(seleccionAyuntamiento.telefono_agencia_colocacion, forState: UIControlState.Normal)
        mail.setTitle(seleccionAyuntamiento.correo_electronico, forState: UIControlState.Normal)
        texto.text = seleccionAyuntamiento.descripcion
        
        
        self.navigationController?.navigationItem.backBarButtonItem?.title = "Volver"
    
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func goToWeb(sender: AnyObject) {
        
        UIApplication.sharedApplication().openURL(NSURL(string: seleccionAyuntamiento.web)!)
        
    }
    
    @IBAction func sendEmailButtonTapped(sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients([seleccionAyuntamiento.correo_electronico])
        mailComposerVC.setSubject("Consulta")
        mailComposerVC.setMessageBody("Escriba aquí su consulta", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "No se pudo enviar el email", message: "Tu dispositivo no puede mandar el email.  Por favor, compruebe su configuración.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func makeCall() {
        let sendMailErrorAlert = UIAlertView(title: "No se pudo enviar el email", message: "Tu dispositivo no puede mandar el email.  Por favor, compruebe su configuración.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    @IBAction func makeCallOne(sender: UIButton) {
        
        UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(sender.titleLabel?.text)")!)
        
    }
    
    @IBAction func makeCallTwo(sender: UIButton) {
        
        UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(sender.titleLabel?.text)")!)
        
    }
   
    
}

