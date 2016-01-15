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


class ViewController: UIViewController {
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBarHidden = false
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
                
                
                var ofer = Oferta(ayuntamientos_id: ayuntamientos_id, categoriadeofertas_id_categoria: categoriadeofertas_id_categoria, categoria_generica: categoria_generica, descripcion: descripcion, descripcion_oferta: descripcion_oferta, fecha_publicacion_oferta: fecha_publicacion_oferta, id: id, IdEmpresascolaboradoras: IdEmpresascolaboradoras, idEmpresas_colaboradoras: idEmpresas_colaboradoras, id_categoria: id_categoria, informacion_de_contacto: informacion_de_contacto, localidad: localidad, nombre_empresa: nombre_empresa, numero_referencia: numero_referencia, ofrece: ofrece, requisitos_minimos: requisitos_minimos, titulo: titulo, URL_imagen_empresa: URL_imagen_empresa, URL_icono: URL_icono, url_pdf_convocatoria: url_pdf_convocatoria, url_portal_web: url_portal_web)
                
                ofertas.append(ofer)
                
            }
            
        }
        
        
        
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
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}

