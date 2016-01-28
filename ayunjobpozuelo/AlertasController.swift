//
//  AlertasController.swift
//  ayunjobpozuelo
//
//  Created by avansis on 19/01/16.
//  Copyright (c) 2016 avansis. All rights reserved.
//


import UIKit


class AlertasController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var myMutableString = NSMutableAttributedString()
    
     var myString = "Introduzca las palabras clave separadas por espacios (solo se puede dar de alta un máximo de 3 alertas)"

    @IBOutlet var labelHtml: UILabel!
    
    
    @IBOutlet var tableView: UITableView!
    
    var players: [Alerta] = alertas
    
    @IBOutlet weak var textoAlerta: UITextField!
    
    var boxView = UIView()
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBarHidden = false
        
        textoAlerta.delegate = self
        
        
        myMutableString = NSMutableAttributedString(
            string: myString
            )
        
        
        myMutableString.addAttribute(NSForegroundColorAttributeName,
            value: UIColor.redColor(),
            range: NSRange(
                location:53,
                length:50))
        
        labelHtml.attributedText = myMutableString
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showIndicator()
        
         var urlSetAlertas = "http://www.ayunjob.com/myphp/rest/mobile/setAlertas.php?filterbyfield1=usuario&filterbyfield2=alertas&value1=username&value2=namealerta"
        
        getAlertas()
        
       
    
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alertas.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("AlertaCell", forIndexPath: indexPath)
            as AlertaCell
        
        let player = alertas[indexPath.row] as Alerta
        cell.labelAlerta.text = player.alerta
        cell.id = player.id
       
        return cell
    }
    
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
        })
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        println(alertas[row])
        
        seleccionOferta = row
        
        let selectedProgram = alertas[indexPath.row]
        
         //Create an instance of PlayerTableViewController and pass the variable
  //             let destinationVC = OfertasByAlertController()
  //             destinationVC.alertaLocal = selectedProgram
        
        
         // performSegueWithIdentifier("listaOfertasByAlert", sender: self)
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
               let mainViewController:OfertasByAlertController =  storyBoard.instantiateViewControllerWithIdentifier("alertasbyalert") as OfertasByAlertController
               mainViewController.alertaLocal = selectedProgram
              self.navigationController?.pushViewController(mainViewController as UIViewController, animated: true)

     //   self.presentViewController(mainViewController, animated: true, completion: nil)
        
        
  //      let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//        let mainViewController:WebViewController =  storyBoard.instantiateViewControllerWithIdentifier("myview") as WebViewController
 //       mainViewController.urlToOpen = selectedProgram.url_detalle_oferta
  //      self.navigationController?.pushViewController(mainViewController as UIViewController, animated: true)
        
       
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == .Delete
        {
            
            var data: NSMutableData = NSMutableData()
            let urlPath: String = "http://www.ayunjob.com/myphp/rest/mobile/deleteAlertas.php?filterbyfield1=id&value1=" + alertas[indexPath.row].id

            var url: NSURL = NSURL(string: urlPath)!
            var request: NSURLRequest = NSURLRequest(URL: url)
            var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)!
            connection.start()
            
            
            
            alertas.removeAtIndex(indexPath.row)
            self.tableView.reloadData()
        }
    }

    
    @IBAction func addAlert(sender: AnyObject) {
        
        var num = tableView.numberOfRowsInSection(0)
        
        if(textoAlerta.text.isEmpty || tableView.numberOfRowsInSection(0) >= 3  ){
            
            let alert = UIAlertController(title: "", message: "Debe introducir el nombre de la alerta o ha superado el máximo de alertas configurables (Max. 3)", preferredStyle: UIAlertControllerStyle.Alert)
            
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default)
                { action -> Void in
                    
                             })
            self.presentViewController(alert, animated: true, completion: nil)
            
        
        } else{
               
        
        let userName = NSUserDefaults.standardUserDefaults().stringForKey("username")!
            
        showIndicator()
        
        DataManager.generateUrltoAddAlert(userName, alertaText: textoAlerta.text)
        
        DataManager.setAlertasWithSuccess { (iTunesData) -> Void in
            let json = JSON(data: iTunesData)
            
            self.getAlertas()
            
        }
            
            
            let alert = UIAlertController(title: "", message: "Tu alerta ha sido creada, recibiras un email cada vez que tengamos una oferta que coincida con tu alerta.", preferredStyle: UIAlertControllerStyle.Alert)
            
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default)
                { action -> Void in
                    self.textoAlerta.text = ""
                })
            self.presentViewController(alert, animated: true, completion: nil)
            
            
            
        }
        
        
        var urlSetAlertas = "http://www.ayunjob.com/myphp/rest/mobile/setAlertas.php?filterbyfield1=usuario&filterbyfield2=alertas&value1=username&value2=namealerta"

    
    }
    
    
    func getAlertas(){
        
        let userName = NSUserDefaults.standardUserDefaults().stringForKey("username")!
        
        DataManager.generateURLAlertasString(userName)
        
        DataManager.getAlertasWithSuccess { (iTunesData) -> Void in
            let json = JSON(data: iTunesData)
            /*   if let appName = json[0]["titulo"].string {
            println("NSURLSession: \(appName)")
            }
            */
            alertas.removeAll(keepCapacity: false)
            alertas = [Alerta]()
            
            let appArray = json.array
            
            for (key: String, subJson: JSON) in json {
                
                var id: String = subJson["id"].stringValue
                var usuario: String = subJson["usuario"].stringValue
                var alertasString: String = subJson["alertas"].stringValue
                
                
                var alerta = Alerta(id: id, usuario: usuario, alerta: alertasString)
                
                
                alertas.append(alerta)
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    self.tableView.delegate = self
                    self.tableView.dataSource = self
                    self.tableView.reloadData()
                    
                    self.boxView.removeFromSuperview()
                }
                
                
            }
        }
        
        urlAlertas = "http://www.ayunjob.com/myphp/rest/mobile/getAlertas.php?filterbyfield1=alertas&value1=username"
        
        urlSetAlertas = "http://www.ayunjob.com/myphp/rest/mobile/setAlertas.php?filterbyfield1=usuario&filterbyfield2=alertas&value1=username&value2=namealerta"
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField === textoAlerta) {
            textoAlerta.resignFirstResponder()
        }
        return true
    }
    
    
    func showIndicator() {
        // You only need to adjust this frame to move it anywhere you want
        boxView = UIView(frame: CGRect(x: view.frame.midX - 90, y: view.frame.midY - 25, width: 180, height: 50))
        boxView.backgroundColor = UIColor.grayColor()
        boxView.alpha = 0.8
        boxView.layer.cornerRadius = 10
        
        //Here the spinnier is initialized
        var activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        activityView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityView.startAnimating()
        
        var textLabel = UILabel(frame: CGRect(x: 60, y: 0, width: 200, height: 50))
        textLabel.textColor = UIColor.whiteColor()
        textLabel.text = "Cargando..."
        
        boxView.addSubview(activityView)
        boxView.addSubview(textLabel)
        
        view.addSubview(boxView)
    }

    
}

