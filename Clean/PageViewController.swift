//
//  PageViewController.swift
//  Clean
//
//  Created by James on 7/11/17.
//  Copyright © 2017 James. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var appearance = UIPageControl()
    
    lazy var Views : [UIViewController]={
        return [self.VCInstance(name: "MasterServicesViewController"),
        self.VCInstance(name: "BasicServiceViewController"),
        self.VCInstance(name: "ThirdViewController"),
        self.VCInstance(name: "FourthViewController")]
            //,self.VCInstance(name: "FifthViewController")
    }()
    
    private func VCInstance(name: String)-> UIViewController{
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier : name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        if let firstVC = Views.first{
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
            
            
        }
        
        self.delegate = self
        setupPageControl()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?{
        guard  let viewControllerIndex = Views.index(of: viewController) else { return nil}
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else { return Views.last}
        
        guard Views.count > previousIndex else {
            return nil
        }
        
        return Views[previousIndex]
    }
    

    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{
        
        guard  let viewControllerIndex = Views.index(of: viewController) else { return nil}
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < Views.count else { return Views.first}
        
        guard Views.count > nextIndex else {
            return nil
        }
        
        return Views[nextIndex]

    }
    
     private func setupPageControl() {
        
         appearance = UIPageControl(frame: CGRect(x: UIScreen.main.bounds.width/3 , y : UIScreen.main.bounds.maxY - 50, width : UIScreen.main.bounds.width/3, height : 50) )
        appearance.numberOfPages = Views.count
        appearance.currentPage = 0
        appearance.tintColor = UIColor.black
        appearance.pageIndicatorTintColor = hexStringToUIColor(hex: "#274f90")
        appearance.currentPageIndicatorTintColor = UIColor.black
        appearance.layer.position.y =  30;

        self.view.addSubview(appearance)
    }
    

    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        setupPageControl()
        return Views.count
    }
    
     public func presentationIndex(for pageViewController: UIPageViewController) -> Int
     {
        guard let firstViewController = viewControllers?.first, let firstViewControllerIndex = Views.index(of: firstViewController) else {return 0}
        
        return firstViewControllerIndex
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        appearance.currentPage = Views.index(of: pageContentViewController)!
    }

}
