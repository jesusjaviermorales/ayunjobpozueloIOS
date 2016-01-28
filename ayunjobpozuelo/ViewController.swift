//
//  ViewController.swift
//  ayunjobpozuelo
//
//  Created by avansis on 25/02/15.
//  Copyright (c) 2015 avansis. All rights reserved.
//

import UIKit

var ayuntamientos = [Ayuntamiento]()
var ofertas = [Oferta]()
var empresas = [Empresa]()
var alertas = [Alerta]()

var ofertasByAlert = [Oferta]()


class ViewController: UIViewController {
    
    @IBOutlet var fondo: UIImageView!
    
    @IBOutlet var imagen: UIImageView!
    
    @IBOutlet var nombre: UILabel!

    @IBOutlet var btnAcceso: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBarHidden = false

        self.title = "Ayunjob Pozuelo de Alarcón"
    
      //  let userName : NSString = NSUserDefaults.standardUserDefaults().stringForKey("username")
        
        if let userName = NSUserDefaults.standardUserDefaults().stringForKey("username") {
            
            fondo.hidden = false
            imagen.hidden = false
            nombre.hidden = false
            nombre.text = "Bienvenido " + userName
            
            UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: nil, animations: {
                self.fondo.bounds = CGRect(x: self.fondo.bounds.origin.x - 50, y: self.fondo.bounds.origin.y, width: self.fondo.bounds.size.width + 120, height: self.fondo.bounds.size.height)
                //self.fondo.enabled = false
                }, completion: nil)
            
            btnAcceso.setTitle("CERRAR SESSION", forState: UIControlState.Normal)
           
        }
        else{
            
            fondo.hidden = true
            imagen.hidden = true
            nombre.hidden = true
            
            btnAcceso.setTitle("ACCESO", forState: UIControlState.Normal)
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        DataManager.getAyuntamietosWithSuccess { (iTunesData) -> Void in
            let json = JSON(data: iTunesData)
            if let appName = json[0]["nombre"].string {
                println("NSURLSession: \(appName)")
            }
            
            let appArray = json.array
            
            for (key: String, subJson: JSON) in json {
               
                var correo_electronico: String = subJson["correo_electronico"].stringValue
                var descripcion: String = subJson["descripcion"].stringValue
                var id: String = subJson["id"].stringValue
                
                var nombre: String = subJson["nombre"].stringValue
                var permite_publicar_empresa: String = subJson["permite_publicar_empresa"].stringValue
                var telefono: String = subJson["telefono"].stringValue
                var telefono_agencia_colocacion: String = subJson["telefono_agencia_colocacion"].stringValue
                var url_darse_de_alta_usuario: String = subJson["url_darse_de_alta_usuario"].stringValue
                
                var url_imagen_escudo_ayuntamiento: String = subJson["url_imagen_escudo_ayuntamiento"].stringValue
                var web: String = subJson["web"].stringValue
                
                
                var ayun = Ayuntamiento(correo_electronico: correo_electronico, descripcion: descripcion, id: id, nombre: nombre, permite_publicar_empresa: permite_publicar_empresa, telefono: telefono, telefono_agencia_colocacion: telefono_agencia_colocacion, url_darse_de_alta_usuario: url_darse_de_alta_usuario, url_imagen_escudo_ayuntamiento: url_imagen_escudo_ayuntamiento, web: web)
                
                ayuntamientos.append(ayun)
                
            }
            
        }

     
    
 
        if (NSUserDefaults.standardUserDefaults().objectForKey("ofertas") != nil) {
            
            var arrayOfObjectsUnarchivedData = NSUserDefaults.standardUserDefaults().dataForKey("ofertas")!
            var ofertasFromCache = NSKeyedUnarchiver.unarchiveObjectWithData(arrayOfObjectsUnarchivedData) as [Oferta]
            
            if !ofertasFromCache.isEmpty {
                
                ofertas = ofertasFromCache
                
            }
            
        }
        else{
            
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
                    
                    NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
                    
                }
                
            }
            
            
            
        }
        
     
        if (NSUserDefaults.standardUserDefaults().objectForKey("empresas") != nil) {
            
            var arrayOfObjectsUnarchivedData = NSUserDefaults.standardUserDefaults().dataForKey("empresas")!
            var empresasFromCache = NSKeyedUnarchiver.unarchiveObjectWithData(arrayOfObjectsUnarchivedData) as [Empresa]
            
            if !empresasFromCache.isEmpty {
                
                empresas = empresasFromCache
                
            }
            
        }
        else{

        
        DataManager.getEmpresasWithSuccess { (iTunesData) -> Void in
            let json = JSON(data: iTunesData)
         /*   if let appName = json[0]["titulo"].string {
                println("NSURLSession: \(appName)")
            }
          */  
            let appArray = json.array
            
            for (key: String, subJson: JSON) in json {
                
                var idEmpresas_colaboradoras: String = subJson["idEmpresas_colaboradoras"].stringValue
                var descripcion: String = subJson["descripcion"].stringValue
                var nombre_empresa: String = subJson["nombre_empresa"].stringValue
                var URL_imagen_empresa: String = subJson["URL imagen_empresa"].stringValue
                
                
                var empresa = Empresa(idEmpresas_colaboradoras: idEmpresas_colaboradoras,
                    descripcion: descripcion,
                    nombre_empresa: nombre_empresa,
                    URL_imagen_empresa: URL_imagen_empresa)
                
                empresas.append(empresa)
            }
            
            if !empresas.isEmpty {
                
                let defaults = NSUserDefaults.standardUserDefaults()
                let arrayOfObjectsKey = "empresas"
                var empresasToCache = NSKeyedArchiver.archivedDataWithRootObject(empresas)
                
                defaults.setObject(empresasToCache, forKey: arrayOfObjectsKey)
                
                //it could be possible to call nsnotification to load tableview
                
            }

            
        }
            
    }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var segueID = segue.identifier
        
        if let identifier = segue.identifier {
            
            if identifier == "login"{
                
                if let userName = NSUserDefaults.standardUserDefaults().stringForKey("username"){
                    
                    fondo.hidden = true
                    imagen.hidden = true
                    nombre.hidden = true
                    
                    btnAcceso.setTitle("ACCESO", forState: UIControlState.Normal)
                    
                } else{
                    
                    segue.destinationViewController

                    
                }
                    
                
                
            }
            //  yourVC.objectOnYourVC = setObjectValueHere!
        }
        
       //segue.destinationViewController
        
        
    }

    
    @IBAction func Acceder(sender: AnyObject) {
        
       
        if let userName = NSUserDefaults.standardUserDefaults().stringForKey("username"){
            
            fondo.hidden = true
            imagen.hidden = true
            nombre.hidden = true
            
            btnAcceso.setTitle("ACCESO", forState: UIControlState.Normal)
            
            NSUserDefaults.standardUserDefaults().removeObjectForKey("username")

            NSUserDefaults.standardUserDefaults().removeObjectForKey("idUser")
            
           // let secondViewController:SecondViewController = SecondViewController()
            
           //self.presentViewController(secondViewController, animated: true, completion: nil)

            
            
        } else{
            
            fondo.hidden = true
            imagen.hidden = true
            nombre.hidden = true
            
            btnAcceso.setTitle("CERRAR SESSION", forState: UIControlState.Normal)
            
            let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("login") as UIViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
          //  self.presentViewController(vc, animated: true, completion: nil)
            
            //self.presentViewController(secondViewController, animated: true, completion: nil)
            
            
        }
        
        
        
     
        
    }
   
    @IBAction func AccederAlertas(sender: AnyObject) {
        
        
        if let userName = NSUserDefaults.standardUserDefaults().stringForKey("username"){
            
            fondo.hidden = true
            imagen.hidden = true
            nombre.hidden = true
            
            btnAcceso.setTitle("ACCESO", forState: UIControlState.Normal)
            
     //       NSUserDefaults.standardUserDefaults().removeObjectForKey("username")
            
            // let secondViewController:SecondViewController = SecondViewController()
            
            //self.presentViewController(secondViewController, animated: true, completion: nil)
           
            let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("alertas") as UIViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        } else{
            
            fondo.hidden = true
            imagen.hidden = true
            nombre.hidden = true
            
     //       btnAcceso.setTitle("CERRAR SESSION", forState: UIControlState.Normal)
            
            let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("login") as UIViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
            //  self.presentViewController(vc, animated: true, completion: nil)
            
            //self.presentViewController(secondViewController, animated: true, completion: nil)
            
            
        }

        
        
    }
}

