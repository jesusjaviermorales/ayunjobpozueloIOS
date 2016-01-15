
import UIKit

class InstructionView: UIViewController
{
  
  var pageIndex : Int = 0
  var titleText : String = ""
  var imageFile : String = ""
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
       
    view.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.5)
    
    

   
    
    
    let width = UIScreen.mainScreen().bounds.size.width
    let height = UIScreen.mainScreen().bounds.size.height
    
    let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, width, height))
    imageViewBackground.image = UIImage(named: imageFile)
    
    // you can change the content mode:
    imageViewBackground.contentMode = UIViewContentMode.ScaleAspectFit
    
    self.view.addSubview(imageViewBackground)
    self.view.sendSubviewToBack(imageViewBackground)
 
    
 /*   let label = UILabel(frame: CGRectMake(0, 0, view.frame.width, 200))
    label.textColor = UIColor.whiteColor()
    label.text = titleText
    label.textAlignment = .Center
    view.addSubview(label)*/
    
 /*   let button = UIButton.buttonWithType(UIButtonType.System) as UIButton
    //button.frame = CGRectMake(20, view.frame.height - 110, view.frame.width - 40, 50)
    button.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
    
   
    
    button.frame =  CGRectMake(10.0, 30.0, 60, 30)
    
    button.setTitle("Volver", forState: UIControlState.Normal)
    button.addTarget(self, action: "pressBackbutton", forControlEvents: UIControlEvents.TouchUpInside)
    self.view.addSubview(button)*/

  }
  
  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
  }
    
    
   
    
    
   
  
}
