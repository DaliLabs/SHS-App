//
//  MMSampleTableViewController.swift
//  MMGooglePlayNewsStand
//
//  Created by mukesh mandora on 25/08/15.
//  Copyright (c) 2015 madapps. All rights reserved.
//

import UIKit

@objc protocol scrolldelegateForYAxis{
    
    @objc optional func scrollYAxis(offset:CGFloat , translation:CGPoint)              // If the skipRequest(sender:) action is connected to a button, this function is called when that button is pressed.
    
    @objc optional func getframeindexpathOfController()->CGRect
}

func uniq<S : SequenceType, T : Hashable where S.Generator.Element == T>(source: S) -> [T] {
    var buffer = [T]()
    var added = Set<T>()
    for elem in source {
        if !added.contains(elem) {
            buffer.append(elem)
            added.insert(elem)
        }
    }
    return buffer
}

var bodyToPass : String = ""
var imageToPass : String = ""
var titleToPass : String = ""
var spotlight_array : [Article] = []
var news_array : [Article] = []
var sports_array : [Article] = []
var opinion_array : [Article] = []
var columns_array : [Article] = []
var features_array : [Article] = []
var imageArr : [AnyObject] = []

var loadImages : Bool = true

class MMSampleTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,MMPlayPageScroll ,UIScrollViewDelegate, MMPlayPageControllerDelegate{
    
    @IBOutlet weak var moreStoriesButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    let header: UIView!
    let headerImage: UIImageView!
    var trans:CGPoint
    var imageArr1:[UIImage]!
    var transitionManager : TransitionModel!
    var preventAnimation = Set<NSIndexPath>()
    var spotlightClicked = 0
    var newsClicked = 0
    var sportsClicked = 0
    var opinionClicked = 0
    var columnsClicked = 0
    var featuresClicked = 0
    
    //     weak var scrolldelegate:scrolldelegateForYAxis?
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var tag = 0 as Int
    
    override func viewDidAppear(animated: Bool) {
        SwiftSpinner.hide()
    }
    
    override func viewDidLoad() {
        imageArr = [UIImage(named: "defaultImage.png")!]
        transitionManager = TransitionModel()
        super.viewDidLoad()
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        self.tableView.decelerationRate=UIScrollViewDecelerationRateFast
        header.frame=CGRectMake(0, 0, self.view.frame.width, 200);
        headerImage.frame=CGRectMake(header.center.x-30, header.center.y-30, 60, 60)
        headerImage.layer.cornerRadius=headerImage.frame.width/2

       
        headerImage.tintColor=UIColor.whiteColor()
        
        
        header.backgroundColor=UIColor.clearColor()
        
        //        header.addSubview(headerImage)
        initHeadr()
        self.view.addSubview(headerImage)
        self.tableView.tableHeaderView=header;
        // Do any additional setup after loading the view.
        self.setNeedsStatusBarAppearanceUpdate()
        
        imageArr1.append(UIImage(named: "ironman.jpg")!)
        imageArr1.append(UIImage(named: "worldbg.jpg")!)
        imageArr1.append(UIImage(named: "sportsbg.jpg")!)
        imageArr1.append(UIImage(named: "applebg.png")!)
        imageArr1.append(UIImage(named: "businessbg.jpg")!)

    }
    
    required init?(coder aDecoder: NSCoder) {
        header=UIView()
        headerImage=UIImageView()
        headerImage.backgroundColor=UIColor(hexString: "109B96")
        headerImage.contentMode=UIViewContentMode.Center
        headerImage.clipsToBounds=true
        trans=CGPointMake(0, 0)
        imageArr1 = Array()
        super.init(coder: aDecoder)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func initHeadr(){
        //header Color
  
        switch ( tag){
        case 1:
             headerImage.backgroundColor=UIColor(hexString: "9c27b0")
            headerImage.image=UIImage(named: "highlights")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            break
            
        case 2:
             headerImage.backgroundColor=UIColor(hexString: "009688")
              headerImage.image=UIImage(named: "sports")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            break
            
        case 3:
             headerImage.backgroundColor=UIColor(hexString: "673ab7")
              headerImage.image=UIImage(named: "movie")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            break
            
        case 4:
             headerImage.backgroundColor=UIColor(hexString: "ff9800")
              headerImage.image=UIImage(named: "tech")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            break
            
        case 5:
             headerImage.backgroundColor=UIColor(hexString: "03a9f4")
              headerImage.image=UIImage(named: "business")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            break
            
        default:
             headerImage.backgroundColor=UIColor(hexString: "4caf50")
              headerImage.image=UIImage(named: "world")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            break
        }
    }
    
    
    @IBAction func moreStoriesClicked(sender: AnyObject) {
        if(Reachability.isConnectedToNetwork())
        {
            SwiftSpinner.show("Loading...")
            switch(self.tag) {
            case 1:
                spotlightClicked+=5
                spotlight_array = []
                getStoryNids("spotlight", count: "\(spotlightClicked)") { nids in
                    dispatch_async(dispatch_get_main_queue()) {
                        for(var i = 0; i < nids.count; i++)
                        {
                            getArticleForNid(nids[i] as! String) { article in
                                dispatch_async(dispatch_get_main_queue()) {
                                    spotlight_array.append(article!)
                                    if(loadImages == true) {
                                        getImage(article!.photoURL) { image in
                                            imageArr.append(image!)
                                            print("go here")
                                        }
                                    }
                                    if(spotlight_array.count == nids.count)
                                    {
                                        self.tableView.reloadData()
                                        loadImages = false
                                        SwiftSpinner.hide()
                                    }
                                }
                            }
                        }
                    }
                }
            case 2:
                newsClicked+=10
                news_array = []
                getStoryNids("news", count: "\(newsClicked)") { nids in
                    dispatch_async(dispatch_get_main_queue()) {
                        for(var i = 0; i < nids.count; i++)
                        {
                            getArticleForNid(nids[i] as! String) { article in
                                dispatch_async(dispatch_get_main_queue()) {
                                    news_array.append(article!)
                                    if(news_array.count == nids.count)
                                    {
                                        self.tableView.reloadData()
                                        SwiftSpinner.hide()
                                    }
                                }
                            }
                        }
                    }
                }
            case 3:
                sportsClicked+=10
                sports_array = []
                getStoryNids("sports", count: "\(sportsClicked)") { nids in
                    dispatch_async(dispatch_get_main_queue()) {
                        for(var i = 0; i < nids.count; i++)
                        {
                            getArticleForNid(nids[i] as! String) { article in
                                dispatch_async(dispatch_get_main_queue()) {
                                    sports_array.append(article!)
                                    if(sports_array.count == nids.count)
                                    {
                                        self.tableView.reloadData()
                                        SwiftSpinner.hide()
                                    }
                                }
                            }
                        }
                    }
                }
            case 4:
                opinionClicked+=10
                opinion_array = []
                getStoryNids("opinion", count: "\(opinionClicked)") { nids in
                    dispatch_async(dispatch_get_main_queue()) {
                        for(var i = 0; i < nids.count; i++)
                        {
                            getArticleForNid(nids[i] as! String) { article in
                                dispatch_async(dispatch_get_main_queue()) {
                                    opinion_array.append(article!)
                                    if(opinion_array.count == nids.count)
                                    {
                                        self.tableView.reloadData()
                                        SwiftSpinner.hide()
                                    }
                                }
                            }
                        }
                    }
                }
            case 5:
                columnsClicked+=10
                columns_array = []
                getStoryNids("opinion", count: "\(columnsClicked)") { nids in
                    dispatch_async(dispatch_get_main_queue()) {
                        for(var i = 0; i < nids.count; i++)
                        {
                            getArticleForNid(nids[i] as! String) { article in
                                dispatch_async(dispatch_get_main_queue()) {
                                    columns_array.append(article!)
                                    if(columns_array.count == nids.count)
                                    {
                                        self.tableView.reloadData()
                                        SwiftSpinner.hide()
                                    }
                                }
                            }
                        }
                    }
                }
            case 6:
                featuresClicked+=10
                features_array = []
                getStoryNids("features", count: "\(featuresClicked)") { nids in
                    dispatch_async(dispatch_get_main_queue()) {
                        for(var i = 0; i < nids.count; i++)
                        {
                            getArticleForNid(nids[i] as! String) { article in
                                dispatch_async(dispatch_get_main_queue()) {
                                    features_array.append(article!)
                                    if(features_array.count == nids.count)
                                    {
                                        self.tableView.reloadData()
                                        SwiftSpinner.hide()
                                    }
                                }
                            }
                        }
                    }
                }
            default:
                print("spotlight clicked")
            }
        }
        else
        {
            let alert = UIAlertController(title: "No Internet", message: "We've detected that you aren't connected to the internet. Please close the app and try again. Note that some features will not work without internet access.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
      
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
     func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if !preventAnimation.contains(indexPath) {
            preventAnimation.insert(indexPath)
            TipInCellAnimator.animate(cell)
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(self.tag) {
        case 1:
            if(news_array.count == 0)
            {
                self.moreStoriesButton.setTitle("Load Stories...", forState: UIControlState.Normal)
            }
            else
            {
                self.moreStoriesButton.hidden = true
            }
            return spotlight_array.count
        case 2:
            if(news_array.count == 0)
            {
                self.moreStoriesButton.setTitle("Load Stories...", forState: UIControlState.Normal)
            }
            else
            {
                self.moreStoriesButton.setTitle("Load More Stories...", forState: UIControlState.Normal)
            }
            return news_array.count
        case 3:
            if(sports_array.count == 0)
            {
                self.moreStoriesButton.setTitle("Load Stories...", forState: UIControlState.Normal)
            }
            else
            {
                self.moreStoriesButton.setTitle("Load More Stories...", forState: UIControlState.Normal)
            }
            return sports_array.count
        case 4:
            if(opinion_array.count == 0)
            {
                self.moreStoriesButton.setTitle("Load Stories...", forState: UIControlState.Normal)
            }
            else
            {
                self.moreStoriesButton.setTitle("Load More Stories...", forState: UIControlState.Normal)
            }
            return opinion_array.count
        case 5:
            if(columns_array.count == 0)
            {
                self.moreStoriesButton.setTitle("Load Stories...", forState: UIControlState.Normal)
            }
            else
            {
                self.moreStoriesButton.setTitle("Load More Stories...", forState: UIControlState.Normal)
            }
            return columns_array.count
        case 6:
            if(features_array.count == 0)
            {
                self.moreStoriesButton.setTitle("Load Stories...", forState: UIControlState.Normal)
            }
            else
            {
                self.moreStoriesButton.setTitle("Load More Stories...", forState: UIControlState.Normal)
            }
            return features_array.count
        default:
            return spotlight_array.count
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:NewsCellTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as! NewsCellTableViewCell
        switch (self.tag) {
        case 1:
            self.moreStoriesButton.hidden = true
            cell.titleNews.text = spotlight_array[indexPath.row].title
            cell.descNews.text = spotlight_array[indexPath.row].author
        case 2:
            cell.titleNews.text = news_array[indexPath.row].title
            cell.descNews.text = news_array[indexPath.row].author
        case 3:
            cell.titleNews.text = sports_array[indexPath.row].title
            cell.descNews.text = sports_array[indexPath.row].author
        case 4:
            cell.titleNews.text = opinion_array[indexPath.row].title
            cell.descNews.text = opinion_array[indexPath.row].author
        case 5:
            cell.titleNews.text = columns_array[indexPath.row].title
            cell.descNews.text = columns_array[indexPath.row].author
        case 6:
            cell.titleNews.text = features_array[indexPath.row].title
            cell.descNews.text = features_array[indexPath.row].author
        default:
            cell.titleNews.text = spotlight_array[indexPath.row].title
            cell.descNews.text = spotlight_array[indexPath.row].author
        }
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detail = self.storyboard?.instantiateViewControllerWithIdentifier("detail") as! DetailViewController
        detail.modalPresentationStyle = UIModalPresentationStyle.Custom;
        //detail.transitioningDelegate = transitionManager;
        let normalDetail = self.storyboard?.instantiateViewControllerWithIdentifier("normalDetail") as! NormalDetail
        normalDetail.modalPresentationStyle = UIModalPresentationStyle.Custom;
        SwiftSpinner.show("Loading...")
        //normalDetail.transitioningDelegate = transitionManager;
        switch (self.tag) {
        case 1:
            bodyToPass = spotlight_array[indexPath.row].body
            titleToPass = spotlight_array[indexPath.row].title
            imageToPass = spotlight_array[indexPath.row].photoURL
            appDelegate.walkthrough?.presentViewController(detail, animated: true, completion: nil)
        case 2:
            bodyToPass = news_array[indexPath.row].body
            titleToPass = news_array[indexPath.row].title
        case 3:
            bodyToPass = sports_array[indexPath.row].body
            titleToPass = sports_array[indexPath.row].title
        case 4:
            bodyToPass = opinion_array[indexPath.row].body
            titleToPass = opinion_array[indexPath.row].title
        case 5:
            bodyToPass = columns_array[indexPath.row].body
            titleToPass = columns_array[indexPath.row].title
        case 6:
            bodyToPass = features_array[indexPath.row].body
            titleToPass = features_array[indexPath.row].title
        default:
            bodyToPass = news_array[indexPath.row].body
            titleToPass = news_array[indexPath.row].title
        }
        appDelegate.walkthrough?.presentViewController(normalDetail, animated: true, completion: nil)

    }
    
    //MARK:  - Scroll delegate
    
    func walkthroughDidScroll(position:CGFloat, offset:CGFloat) {

        //        NSLog("In controller%f %f", offset,position)
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        trans = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y);
        appDelegate.walkthrough!.scrollYAxis(scrollView.contentOffset.y, translation: trans)
    }
    
    
    
    
}

