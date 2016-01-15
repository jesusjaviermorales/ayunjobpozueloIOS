
import UIKit

class TutorialViewController: UIViewController, UIPageViewControllerDataSource
{
  var pageViewController : UIPageViewController?
  //var pageTitles : Array<String> = ["God vs Man", "Cool Breeze", "Fire Sky"]
  var pageImages : Array<String> = ["1_tutorial_encuentra.png", "2_tutorial_busca.png", "3_tutorial_alertas.png",
    "4_tutorial_inscríbete.png",
    "5_tutorial_info.png",
    "6_tutorial_empresas.png",
    ""]
    
  var currentIndex : Int = 0
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    self.navigationController?.navigationBarHidden = true
    
    pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
    pageViewController!.dataSource = self
    
    let startingViewController: InstructionView = viewControllerAtIndex(0)!
    let viewControllers: NSArray = [startingViewController]
    pageViewController!.setViewControllers(viewControllers as [AnyObject], direction: .Forward, animated: false, completion: nil)
    pageViewController!.view.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    
    addChildViewController(pageViewController!)
    view.addSubview(pageViewController!.view)
    pageViewController!.didMoveToParentViewController(self)
    
    let button = UIButton.buttonWithType(UIButtonType.System) as UIButton
    //button.frame = CGRectMake(20, view.frame.height - 110, view.frame.width - 40, 50)
    button.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
    
    
    
    button.frame =  CGRectMake(0, view.frame.height - 40.0, 80, 40)
    
    button.setTitle("Volver", forState: UIControlState.Normal)
    button.addTarget(self, action: "pressBackbutton", forControlEvents: UIControlEvents.TouchUpInside)
    view.addSubview(button)

    
    
  }
        
  
  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
  }
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
  {
    var index = (viewController as InstructionView).pageIndex
    
    if (index == 0) || (index == NSNotFound) {
      return nil
    }
    
    index--
    
    return viewControllerAtIndex(index)
  }
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
  {
    var index = (viewController as InstructionView).pageIndex
    
    if index >= 7
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    index++
    
   // if (index == self.pageImages.count) {
  //    return nil
  //  }
    
    return viewControllerAtIndex(index)
  }
  
  func viewControllerAtIndex(index: Int) -> InstructionView?
  {
    if index >= 7
    {
      self.navigationController?.popViewControllerAnimated(true)
        return nil
   
    }else{
        
        
    
    
    // Create a new view controller and pass suitable data.
    let pageContentViewController = InstructionView()
    pageContentViewController.imageFile = pageImages[index]
//    pageContentViewController.titleText = pageTitles[index]
    pageContentViewController.pageIndex = index
    currentIndex = index
    
        return pageContentViewController
        }
        
    
  }
  
  func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int
  {
    return self.pageImages.count
  }
  
  func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int
  {
    return 0
  }
    
    
    func pressBackbutton()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }

    
   
  
}
