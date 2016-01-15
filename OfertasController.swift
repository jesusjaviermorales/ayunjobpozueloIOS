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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       btnFilter.addTarget(self, action: "showfilterPopUp", forControlEvents: .TouchUpInside)
        
     /*   navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .Plain, target: self, action: "showfilterPopUp")*/
        
        // create the alert
       
        showCategoriesPopUp()
        
 //
   //     bar.userInteractionEnabled = true
     //   bar.addGestureRecognizer(recognizer)
        
    }
    
    func showfilterPopUp() { //filtrar y seleccionar por categoria
        // create the alert
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
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
                let mainViewController = storyBoard.instantiateViewControllerWithIdentifier("myview")
                self.navigationController?.pushViewController(mainViewController as UIViewController, animated: true)
                
            })
        
        alert.addAction(UIAlertAction(title: "Empresas", style: UIAlertActionStyle.Default, handler: nil))
        alert.addAction(UIAlertAction(title: "Empleo Público", style: UIAlertActionStyle.Default)
            { action -> Void in
                
                
                let alertController = UIAlertController(title: "", message:
                    "No disponible actualmente, consulte la web del ayuntamiento", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
                
                
            })
        
        alert.addAction(UIAlertAction(title: "Ninguna", style: UIAlertActionStyle.Destructive, handler: nil))
        
        // show the alert
        self.presentViewController(alert, animated: true, completion: nil)
    
    }
    
    func showTextfilter() {
        
        var alert = UIAlertController(title: "Introduzca las palabras clave separadas por espacios", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler(configurationTextField)
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel, handler:nil))
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler:{ (UIAlertAction)in
        //    println("Done !!")
        //    println("Item : \(tField.text)")
        }))
        self.presentViewController(alert, animated: true, completion: {
            println("completion block")
        })
        
    }
    
    func configurationTextField(textField: UITextField!)
    {
        if let aTextField = textField {
            textField.text = "Java Gerente Director"
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
        
        ImageLoader.sharedLoader.imageForUrl(player.URL_icono, completionHandler:{(image: UIImage?, url: String) in
           cell.imagen.image = image
        })
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        println(players[row])
        
        seleccionOferta = row
        
        let selectedProgram = ofertas[indexPath.row]
        
        // Create an instance of PlayerTableViewController and pass the variable
        let destinationVC = DetalleOfertaController()
        destinationVC.oferta = selectedProgram
        
        
        
        performSegueWithIdentifier("detalleofertasegue", sender: self)
        
    }
    
    
    
}

