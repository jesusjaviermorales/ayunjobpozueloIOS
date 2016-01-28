//
//  DataManager.swift
//  TopApps
//
//  Created by Dani Arnaout on 9/2/14.
//  Edited by Eric Cerney on 9/27/14.
//  Copyright (c) 2014 Ray Wenderlich All rights reserved.
//

import Foundation

let idAyuntamiento = "1"

let urlAyuntamientos = "http://www.ayunjob.com/myphp/rest/mobile/getayuntamientos.php"

let TopAppURL = "http://www.ayunjob.com/myphp/rest/mobile/getofertas.php?from=20150112&to20150212&filterbyfield1=ayuntamientos_id&value1=1"

let urlEmpresas = "http://www.ayunjob.com/myphp/rest/mobile/getempresas.php?id_ayuntamiento=1"

var urlLogin = "http://www.ayunjob.com/myphp/rest/mobile/getuser.php?filterbyfield1=usuario&filterbyfield2=contrasena&value1=username&value2=pass"

var urlAlertas = "http://www.ayunjob.com/myphp/rest/mobile/getAlertas.php?filterbyfield1=alertas&value1=username"

var urlOfertasByAlertas = "http://www.ayunjob.com/myphp/rest/mobile/getOfertasByAlertas.php?filterbyfield1=alertas&value1=@"

var urlSetAlertas = "http://www.ayunjob.com/myphp/rest/mobile/setAlertas.php?filterbyfield1=usuario&filterbyfield2=alertas&value1=username&value2=namealerta"

class DataManager {
    
    class func generateLoginString(user1: NSString, pass1: NSString) -> Void {
        
        let replaced = (urlLogin as NSString).stringByReplacingOccurrencesOfString("username", withString: user1)
        
         urlLogin = (replaced as NSString).stringByReplacingOccurrencesOfString("pass", withString: pass1)
        
    }
    
    class func generateURLAlertasString(user1: NSString) -> Void {
        urlAlertas = (urlAlertas as NSString).stringByReplacingOccurrencesOfString("username", withString: user1)
    }
    
    
    class func getAlertasWithSuccess(success: ((iTunesData: NSData!) -> Void)) {
        //1
        loadDataFromURL(NSURL(string: urlAlertas)!, completion:{(data, error) -> Void in
            //2
            if let urlData = data {
                //3
                success(iTunesData: urlData)
            }
        })
    }
    
    class func getLoginWithSuccess(success: ((iTunesData: NSData!) -> Void)) {
        //1
        loadDataFromURL(NSURL(string: urlLogin)!, completion:{(data, error) -> Void in
            //2
            if let urlData = data {
                //3
                success(iTunesData: urlData)
            }
        })
    }
    
    
    class func generateUrltoAddAlert(user1: NSString, alertaText: NSString) -> Void {
        
        let replaced = (urlSetAlertas as NSString).stringByReplacingOccurrencesOfString("username", withString: user1)
        
        urlSetAlertas = (replaced as NSString).stringByReplacingOccurrencesOfString("namealerta", withString: alertaText.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)
        
     //   NSLog(urlSetAlertas)
    }
    
    class func setAlertasWithSuccess(success: ((iTunesData: NSData!) -> Void)) {
        //1
        loadDataFromURL(NSURL(string: urlSetAlertas)!, completion:{(data, error) -> Void in
            //2
            if let urlData = data {
                //3
                success(iTunesData: urlData)
            }
        })
    }


    
    
    class func getEmpresasWithSuccess(success: ((iTunesData: NSData!) -> Void)) {
        //1
        loadDataFromURL(NSURL(string: urlEmpresas)!, completion:{(data, error) -> Void in
            //2
            if let urlData = data {
                //3
                success(iTunesData: urlData)
            }
        })
    }
    
    
    class func getAyuntamietosWithSuccess(success: ((iTunesData: NSData!) -> Void)) {
        //1
        loadDataFromURL(NSURL(string: urlAyuntamientos)!, completion:{(data, error) -> Void in
            //2
            if let urlData = data {
                //3
                success(iTunesData: urlData)
            }
        })
    }
    
    class func generateURLOfertasByAlertasString(filtro: NSString) -> Void {
        urlOfertasByAlertas = (urlOfertasByAlertas as NSString).stringByReplacingOccurrencesOfString("@", withString: filtro.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)
    }
    
    
    class func getOfertasByAlertasWithSuccess(success: ((iTunesData: NSData!) -> Void)) {
        //1
        loadDataFromURL(NSURL(string: urlOfertasByAlertas)!, completion:{(data, error) -> Void in
            //2
            if let urlData = data {
                //3
                success(iTunesData: urlData)
            }
        })
    }


    
  
  class func getTopAppsDataFromItunesWithSuccess(success: ((iTunesData: NSData!) -> Void)) {
    //1
    loadDataFromURL(NSURL(string: TopAppURL)!, completion:{(data, error) -> Void in
        //2
        if let urlData = data {
          //3
          success(iTunesData: urlData)
        }
    })
  }
    
    
  
  class func getTopAppsDataFromFileWithSuccess(success: ((data: NSData) -> Void)) {
    //1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
      //2
      let filePath = NSBundle.mainBundle().pathForResource("TopApps",ofType:"json")
   
      var readError:NSError?
      if let data = NSData(contentsOfFile:filePath!,
        options: NSDataReadingOptions.DataReadingUncached,
        error:&readError) {
        success(data: data)
      }
    })
  }
  
  class func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
    var session = NSURLSession.sharedSession()
    
    // Use NSURLSession to get data from an NSURL
    let loadDataTask = session.dataTaskWithURL(url, completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
      if let responseError = error {
        completion(data: nil, error: responseError)
      } else if let httpResponse = response as? NSHTTPURLResponse {
        if httpResponse.statusCode != 200 {
          var statusError = NSError(domain:"com.raywenderlich", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
          completion(data: nil, error: statusError)
        } else {
          completion(data: data, error: nil)
        }
      }
    })
    
    loadDataTask.resume()
  }
}