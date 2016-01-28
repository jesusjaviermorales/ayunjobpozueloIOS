//
//  OfertasController.swift
//  ayunjobpozuelo
//
//  Created by avansis on 25/02/15.
//  Copyright (c) 2015 avansis. All rights reserved.
//
import UIKit

let detalleOfertaSegueIdentifier = "detalleofertasegue"

var seleccionOferta = 0;

class OfertasController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var btnFilter: UIButton!
    
    var players: [Oferta] = ofertas
    
    var boxView = UIView()
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadList:",name:"load", object: nil)
        
       btnFilter.addTarget(self, action: "showfilterPopUp", forControlEvents: .TouchUpInside)
        
     /*   navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .Plain, target: self, action: "showfilterPopUp")*/
        
        // create the alert
        
        self.navigationItem.backBarButtonItem?.title = "Volver"
       
        showCategoriesPopUp()
        
        
                  
        
        
        
    }
    
    func showfilterPopUp() { //filtrar y seleccionar por categoria
        // create the alert
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        
       if let userName = NSUserDefaults.standardUserDefaults().stringForKey("username"){
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Mis Alertas", style: UIAlertActionStyle.Default)
            { action -> Void in
                
                let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("alertas") as UIViewController
                
                self.navigationController?.pushViewController(vc, animated: true)
                
            })

        
        
        }
        
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Filtrar", style: UIAlertActionStyle.Default)
            { action -> Void in
                
                self.showTextfilter()
                
               /* let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let mainViewController = storyBoard.instantiateViewControllerWithIdentifier("myview")
                self.navigationController?.pushViewController(mainViewController as UIViewController, animated: true)*/
                
            })
        
         alert.addAction(UIAlertAction(title: "Seleccionar por categoría", style: UIAlertActionStyle.Default)
            { action -> Void in
                
                self.showCategoriesPopUp()
                
              /*  let alertController = UIAlertController(title: "", message:
                    "No disponible actualmente, consulte la web del ayuntamiento", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)*/
                
                
            })
        alert.addAction(UIAlertAction(title: "Ninguna", style: UIAlertActionStyle.Destructive, handler: nil))
        // show the alert
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func showCategoriesPopUp() {
        
        // create the alert
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Servicio Doméstico", style: UIAlertActionStyle.Default)
            { action -> Void in
                
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let mainViewController: WebViewController = storyBoard.instantiateViewControllerWithIdentifier("myview") as WebViewController
                mainViewController.urlToOpen = "https://pozuelodealarcon.es/sedeelectronica/index.asp?MP=125&MS=0&MN=1&TR=C&IDR=3647&idtramite=174";
                self.navigationController?.pushViewController(mainViewController as UIViewController, animated: true)
                
               // self.presentViewController(mainViewController, animated: true, completion: nil)
                
                
            })
        
      
        
        alert.addAction(UIAlertAction(title: "Empresas", style: UIAlertActionStyle.Default)
            { action -> Void in
            
           
                self.updateOfertas()
            
            })
        
        
        
        
    /*    alert.addAction(UIAlertAction(title: "Empleo Público", style: UIAlertActionStyle.Default)
            { action -> Void in
                
                
                let alertController = UIAlertController(title: "", message:
                    "No disponible actualmente, consulte la web del ayuntamiento", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
                
                
            })*/
        
        alert.addAction(UIAlertAction(title: "Ninguna", style: UIAlertActionStyle.Destructive, handler: nil))
        
        // show the alert
        self.presentViewController(alert, animated: true, completion: nil)
    
    }
    
    func showTextfilter() {
        
        var alertEmpty = UIAlertController(title: "", message: "No exiten ofertas para esta alerta.", preferredStyle: UIAlertControllerStyle.Alert)
        
        // add the actions (buttons)
        alertEmpty.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
      //      self.navigationController?.popViewControllerAnimated(true)
            return
        }))
        
        
        var alert = UIAlertController(title: "Introduzca las palabras clave separadas por espacios", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler(configurationTextField)
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel, handler:nil))
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler:{ (UIAlertAction)in
            
            
            self.showIndicator()
            
        //    ofertas.removeAll(keepCapacity: false)
      
            self.players.removeAll(keepCapacity: false)
            
            var textFilter: String = ((alert.textFields![0] as UITextField).text)
            
            
            if textFilter.isEmpty {
                
                self.players = ofertas
                
                self.tableView.reloadData()
                
                self.boxView.removeFromSuperview()
            
            }
            else{
                
            
            DataManager.generateURLOfertasByAlertasString(textFilter)
            
            
            DataManager.getOfertasByAlertasWithSuccess { (iTunesData) -> Void in
                let json = JSON(data: iTunesData)
                if let appName = json[0]["titulo"].string {
                    println("NSURLSession: \(appName)")
                }
                
                let appArray = json.array
                
                for (key: String, subJson: JSON) in json {
                    
                    var id: String = subJson["id"].stringValue
                    var ayuntamientos_id: String = subJson["ayuntamientos_id"].stringValue
                    var categoriadeofertas_id_categoria: String = subJson["categoriadeofertas_id_categoria"].stringValue
                    
                    var categoria_generica: String = subJson["categoria_generica"].stringValue
                    var descripcion: String = subJson["descripcion"].stringValue
                    var descripcion_oferta: String = subJson["descripcion_oferta"].stringValue
                    var fecha_publicacion_oferta: String = subJson["fecha_publicacion_oferta"].stringValue
                    var informacion_de_contacto: String = subJson["informacion_de_contacto"].stringValue
                    
                    var IdEmpresascolaboradoras: String = subJson["IdEmpresascolaboradoras"].stringValue
                    var idEmpresas_colaboradoras: String = subJson["idEmpresas_colaboradoras"].stringValue
                    var id_categoria: String = subJson["id_categoria"].stringValue
                    var localidad: String = subJson["localidad"].stringValue
                    var nombre_empresa: String = subJson["nombre_empresa"].stringValue
                    
                    var numero_referencia: String = subJson["numero_referencia"].stringValue
                    var requisitos_minimos: String = subJson["requisitos_minimos"].stringValue
                    var ofrece: String = subJson["ofrece"].stringValue
                    var titulo: String = subJson["titulo"].stringValue
                    var URL_imagen_empresa: String = subJson["URL_imagen_empresa"].stringValue
                    var URL_icono: String = subJson["URL_icono"].stringValue
                    var url_pdf_convocatoria: String = subJson["url_pdf_convocatoria"].stringValue
                    var url_portal_web: String = subJson["url_portal_web"].stringValue
                    var url_detalle_oferta: String = subJson["url_detalle_oferta"].stringValue
                    
                    var ofer = Oferta(ayuntamientos_id: ayuntamientos_id, categoriadeofertas_id_categoria: categoriadeofertas_id_categoria, categoria_generica: categoria_generica, descripcion: descripcion, descripcion_oferta: descripcion_oferta, fecha_publicacion_oferta: fecha_publicacion_oferta, id: id, IdEmpresascolaboradoras: IdEmpresascolaboradoras, idEmpresas_colaboradoras: idEmpresas_colaboradoras, id_categoria: id_categoria, informacion_de_contacto: informacion_de_contacto, localidad: localidad, nombre_empresa: nombre_empresa, numero_referencia: numero_referencia, ofrece: ofrece, requisitos_minimos: requisitos_minimos, titulo: titulo, URL_imagen_empresa: URL_imagen_empresa, URL_icono: URL_icono, url_pdf_convocatoria: url_pdf_convocatoria, url_portal_web: url_portal_web,
                        url_detalle_oferta: url_detalle_oferta)
                    
                    self.players.append(ofer)
                    
                   
                    
                    
                    
                    
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    self.boxView.removeFromSuperview()
                    
                    self.tableView.reloadData()
                    
                    
                }
                //
                
                if(self.players.isEmpty){
                    
                    
                    self.presentViewController(alertEmpty, animated: true, completion: nil)
                    
                    
                }
                
                
                
                
            }
                 }
            
            urlOfertasByAlertas = "http://www.ayunjob.com/myphp/rest/mobile/getOfertasByAlertas.php?filterbyfield1=alertas&value1=@"

            
            
        }))
        self.presentViewController(alert, animated: true, completion: {
            println("completion block")
        })
        
    }
    
    
    
    func updateOfertas() {
        
        var alertEmpty = UIAlertController(title: "", message: "No exiten ofertas para esta alerta.", preferredStyle: UIAlertControllerStyle.Alert)
        
        // add the actions (buttons)
        alertEmpty.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
            //      self.navigationController?.popViewControllerAnimated(true)
            return
        }))
        
        
        var alertUpdate = UIAlertController(title: "¿Desea actualizar las ofertas con la última información?", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        alertUpdate.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel, handler:nil))
        alertUpdate.addAction(UIAlertAction(title: "Si", style: UIAlertActionStyle.Default, handler:{ (UIAlertAction)in
            
            
            self.showIndicator()
            
            ofertas.removeAll(keepCapacity: false)
            
            self.players.removeAll(keepCapacity: false)
            
                
                
            DataManager.getTopAppsDataFromItunesWithSuccess { (iTunesData) -> Void in
                let json = JSON(data: iTunesData)
                if let appName = json[0]["titulo"].string {
                    println("NSURLSession: \(appName)")
                }
                
                let appArray = json.array
                
                for (key: String, subJson: JSON) in json {
                    
                    var id: String = subJson["id"].stringValue
                    var ayuntamientos_id: String = subJson["ayuntamientos_id"].stringValue
                    var categoriadeofertas_id_categoria: String = subJson["categoriadeofertas_id_categoria"].stringValue
                    
                    var categoria_generica: String = subJson["categoria_generica"].stringValue
                    var descripcion: String = subJson["descripcion"].stringValue
                    var descripcion_oferta: String = subJson["descripcion_oferta"].stringValue
                    var fecha_publicacion_oferta: String = subJson["fecha_publicacion_oferta"].stringValue
                    var informacion_de_contacto: String = subJson["informacion_de_contacto"].stringValue
                    
                    var IdEmpresascolaboradoras: String = subJson["IdEmpresascolaboradoras"].stringValue
                    var idEmpresas_colaboradoras: String = subJson["idEmpresas_colaboradoras"].stringValue
                    var id_categoria: String = subJson["id_categoria"].stringValue
                    var localidad: String = subJson["localidad"].stringValue
                    var nombre_empresa: String = subJson["nombre_empresa"].stringValue
                    
                    var numero_referencia: String = subJson["numero_referencia"].stringValue
                    var requisitos_minimos: String = subJson["requisitos_minimos"].stringValue
                    var ofrece: String = subJson["ofrece"].stringValue
                    var titulo: String = subJson["titulo"].stringValue
                    var URL_imagen_empresa: String = subJson["URL_imagen_empresa"].stringValue
                    var URL_icono: String = subJson["URL_icono"].stringValue
                    var url_pdf_convocatoria: String = subJson["url_pdf_convocatoria"].stringValue
                    var url_portal_web: String = subJson["url_portal_web"].stringValue
                    var url_detalle_oferta: String = subJson["url_detalle_oferta"].stringValue
                    
                    var ofer = Oferta(ayuntamientos_id: ayuntamientos_id, categoriadeofertas_id_categoria: categoriadeofertas_id_categoria, categoria_generica: categoria_generica, descripcion: descripcion, descripcion_oferta: descripcion_oferta, fecha_publicacion_oferta: fecha_publicacion_oferta, id: id, IdEmpresascolaboradoras: IdEmpresascolaboradoras, idEmpresas_colaboradoras: idEmpresas_colaboradoras, id_categoria: id_categoria, informacion_de_contacto: informacion_de_contacto, localidad: localidad, nombre_empresa: nombre_empresa, numero_referencia: numero_referencia, ofrece: ofrece, requisitos_minimos: requisitos_minimos, titulo: titulo, URL_imagen_empresa: URL_imagen_empresa, URL_icono: URL_icono, url_pdf_convocatoria: url_pdf_convocatoria, url_portal_web: url_portal_web,
                        url_detalle_oferta: url_detalle_oferta)
                    
                    ofertas.append(ofer)
                    
                }
                
                if !ofertas.isEmpty {
                    
                    let defaults = NSUserDefaults.standardUserDefaults()
                    let arrayOfObjectsKey = "ofertas"
                    var ofertasToCache = NSKeyedArchiver.archivedDataWithRootObject(ofertas)
                    
                    defaults.setObject(ofertasToCache, forKey: arrayOfObjectsKey)
                    
                    self.players = ofertas
                    
                     self.tableView.reloadData()
                    
                    
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                        
                    self.boxView.removeFromSuperview()
                    
                   
                        
                        
                }
                    //
                    
                if(self.players.isEmpty){
                        
                        
                        self.presentViewController(alertEmpty, animated: true, completion: nil)
                        
                        
                }
                    
                    
                    
                    
               
            }
            

            
        }))
        self.presentViewController(alertUpdate, animated: true, completion: {
            println("completion block")
        })
        
    }

    
    
    
    
    func configurationTextField(textField: UITextField!)
    {
        if let aTextField = textField {
            textField.placeholder = "Java Gerente Director"
        }
    }
        
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("OfertaCell", forIndexPath: indexPath)
            as OfertaCell
        
        let player = players[indexPath.row] as Oferta
        cell.titulo.text = player.titulo
        cell.descripcion.text = player.descripcion_oferta
        cell.salario.text = player.ofrece
        cell.municipio.text = player.localidad
        cell.fecha.text = player.fecha_publicacion_oferta
        
  /*      ImageLoader.sharedLoader.imageForUrl(player.URL_icono, completionHandler:{(image: UIImage?, url: String) in
           cell.imagen.image = image
        })*/
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        println(players[row])
        
        seleccionOferta = row
        
        let selectedProgram = players[indexPath.row]
        
        // Create an instance of PlayerTableViewController and pass the variable
 //       let destinationVC = DetalleOfertaController()
 //       destinationVC.oferta = selectedProgram
 
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController:WebViewController =  storyBoard.instantiateViewControllerWithIdentifier("myview") as WebViewController
        mainViewController.urlToOpen = selectedProgram.url_detalle_oferta
        self.navigationController?.pushViewController(mainViewController as UIViewController, animated: true)
        
       //self.presentViewController(mainViewController, animated: true, completion: nil)
     //   self.navigationController?.presentViewController(mainViewController, animated: true, completion: nil)
        
      //  performSegueWithIdentifier("detalleofertasegue", sender: self)
        
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
    
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
        })
    }
    
    
    func loadList(notification: NSNotification){
        //load data here
        self.tableView.reloadData()
    }
    
  
    
    
    
}

