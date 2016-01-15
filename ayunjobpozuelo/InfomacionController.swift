//
//  InfomacionController.swift
//  ayunjobpozuelo
//
//  Created by avansis on 14/01/16.
//  Copyright (c) 2016 avansis. All rights reserved.
//

import UIKit


class InformacionController: UIViewController {
    
    
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBarHidden = false
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var segueID = segue.identifier
        
        if(segueID! == "agenciaColocacion"){
            
            var yourVC:WebViewController = segue.destinationViewController as WebViewController
            
            yourVC.urlToOpen = "http://pozuelodealarcon.redagenciadecolocacion.com/";
            
          //  yourVC.objectOnYourVC = setObjectValueHere!
            
        }
        
        if(segueID! == "cursos"){
            
            var yourVC:WebViewController = segue.destinationViewController as WebViewController
            
            yourVC.urlToOpen = "http://www.pozuelodealarcon.org/index.asp?MP=2&MS=2013&MN=3";
            
            //  yourVC.objectOnYourVC = setObjectValueHere!
            
        }
        
        if(segueID! == "eventos"){
            
            var yourVC:WebViewController = segue.destinationViewController as WebViewController
            
            yourVC.urlToOpen = "http://www.pozuelodealarcon.org/index.asp?MP=2&MS=9&MN=2";
            
            //  yourVC.objectOnYourVC = setObjectValueHere!
            
        }
        
        if(segueID! == "noticias"){
            
            var yourVC:WebViewController = segue.destinationViewController as WebViewController
            
            yourVC.urlToOpen = "http://www.pozuelodealarcon.org/index.asp?MP=1&MS=1487&MN=4";
            
            //  yourVC.objectOnYourVC = setObjectValueHere!
            
        }
        
    }
    
    
}

