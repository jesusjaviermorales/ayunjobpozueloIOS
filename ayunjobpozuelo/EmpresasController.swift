//
//  OfertasController.swift
//  ayunjobpozuelo
//
//  Created by avansis on 25/02/15.
//  Copyright (c) 2015 avansis. All rights reserved.
//
import UIKit

let empresaSegueIdentifier = "detalleofertasegue"


class EmpresasController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var btnFilter: UIButton!
    
    var players: [Empresa] = empresas

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
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
        
        let player = players[indexPath.row] as Empresa
        cell.titulo.text = player.nombre_empresa
        cell.descripcion.text = player.descripcion
        //cell.salario.text = player.ofrece
        //cell.municipio.text = player.localidad
        //cell.fecha.text = player.fecha_publicacion_oferta
        
        ImageLoader.sharedLoader.imageForUrl(player.URL_imagen_empresa, completionHandler:{(image: UIImage?, url: String) in
            cell.imagen.image = image
        })
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
        })
    }
    
    
    
}

