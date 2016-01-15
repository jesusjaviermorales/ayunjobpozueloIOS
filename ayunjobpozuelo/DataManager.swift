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


class DataManager {
    
    
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