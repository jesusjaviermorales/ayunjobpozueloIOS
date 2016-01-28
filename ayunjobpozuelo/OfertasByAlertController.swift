
//
import UIKit


class OfertasByAlertController : UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    var alertaLocal:Alerta!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backItem = UIBarButtonItem(title: "Volver", style: .Bordered, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
        
        
        ofertasByAlert.removeAll(keepCapacity: false)
        
        NSLog(alertaLocal.alerta)
        
        DataManager.generateURLOfertasByAlertasString(alertaLocal.alerta)
        
        
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
                
                ofertasByAlert.append(ofer)
                
                dispatch_async(dispatch_get_main_queue()) {
                   self.tableView.reloadData()
                    
                }
                
                
              
                
            }
                         // self.tableView.reloadData()
                
                if(ofertasByAlert.isEmpty){
                    
                    var alertEmpty = UIAlertController(title: "", message: "No exiten ofertas para esta alerta.", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    // add the actions (buttons)
                    alertEmpty.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
                        self.navigationController?.popViewControllerAnimated(true)
                        return
                    }))
                    
                    self.presentViewController(alertEmpty, animated: true, completion: nil)

                    
                }
                
                
         
            
        }
        
        urlOfertasByAlertas = "http://www.ayunjob.com/myphp/rest/mobile/getOfertasByAlertas.php?filterbyfield1=alertas&value1=@"

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ofertasByAlert.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("OfertaByAlertCell", forIndexPath: indexPath)
            as OfertaCell
        
        let player = ofertasByAlert[indexPath.row] as Oferta
        cell.titulo.text = player.titulo
        cell.descripcion.text = player.descripcion_oferta
        cell.salario.text = player.ofrece
        cell.municipio.text = player.localidad
        cell.fecha.text = player.fecha_publicacion_oferta
        
 /*       ImageLoader.sharedLoader.imageForUrl(player.URL_icono, completionHandler:{(image: UIImage?, url: String) in
            cell.imagen.image = image
        })*/
        
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
        println(ofertasByAlert[row])
        
        seleccionOferta = row
        
        let selectedProgram = ofertasByAlert[indexPath.row]
        
        // Create an instance of PlayerTableViewController and pass the variable
        //       let destinationVC = DetalleOfertaController()
        //       destinationVC.oferta = selectedProgram
        
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController:WebViewController =  storyBoard.instantiateViewControllerWithIdentifier("myview") as WebViewController
        mainViewController.urlToOpen = selectedProgram.url_detalle_oferta
        self.navigationController?.pushViewController(mainViewController as UIViewController, animated: true)
        
        
     //   self.presentViewController(mainViewController, animated: true, completion: nil)
        //  performSegueWithIdentifier("detalleofertasegue", sender: self)

        
    }
    
    
    
}

