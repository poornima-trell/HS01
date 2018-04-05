//
//  HS01.m
//  Papyrus
//
//  Created by Arun Benty on 12/2/11.
//  Copyright (c) 2011 Trellisys. All rights reserved.
//



//#import "TSAppDelegate.h"
#import "AppConstants.h"
//#import "UIImage+resize.h"
#define MAIN_SECTION_BUTTON_PREFIX 101
#define MAIN_SECTION_BUTTON_LABEL_PREFIX 201
//#import "InformationViewController.h"
//#import "GlossaryViewController.h"
//#import "MBlurbHomeVC.h"
//#import "Analytics.h"
#import "HS01.h"
//#import "MBlurbViewController.h"
//#import <SDWebImage/UIImageView+WebCache.h>
//#import <SDWebImage/SDImageCache.h>
//#import "CXMLElement.h"

@interface HS01()
-(CGRect)frameForMainButtonWithIndex:(NSUInteger)idx withInterfaceOrientation:(UIInterfaceOrientation)orientation;
-(CGRect)frameForMainButtonCaptionWithIndex:(NSUInteger)idx withInterfaceOrientation:(UIInterfaceOrientation)orientation;
-(CGRect)frameForAppBar;
@end

@implementation HS01

NSInteger  const MainSectionMaxNoOfRowsPerPage = 3;
NSInteger  const MainSectionMaxNoOfColumns = 3;

NSInteger  const AppBarMaxNoOfRowsPerPage = 1;
NSInteger  const AppBarMaxNoOfColumns = 10;

NSInteger const mainSectionWidth = 320;
NSInteger const mainSectionHeight = 350;
NSInteger const mainSectionHeightiPhone5 = 404;


//NSInteger const appBarSectionTopPos = 386;
NSInteger const appBarSectionTopPos = 346;
NSInteger const appBarSectionTopPosiPhone5 = 434;

NSInteger const appBarSectionWidth = 320;
NSInteger const appBarSectionHeight = 90;

//NSString *  const MyFirstConstant= @"FirstConstant"

bool animateHS01 = YES;
//componentNode
@synthesize  ComponentProperties, appRenderer, BackgroundImage,splashTimer;
@synthesize scrollView, pageControl;
@synthesize appBarScrollView, AppBarBackgroundImage;
@synthesize ComponentInstanceID, ComponentName;

-(id)initWithAppRender:(AppRenderer*)_appRenderer 
{
    self = [super initWithNibName:@"HS01" bundle:nil];
    
    if (self) {
        appRenderer = _appRenderer;
    }
    
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle* )nibBundleOrNil {
    
    NSBundle *bdle = [NSBundle bundleForClass:[self class]];
    NSURL *url = [bdle URLForResource:@"HS01" withExtension:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithURL:url];
    self = [super initWithNibName:@"HS01" bundle:resourceBundle];
    return self;
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}
- (void)DisplayHS01
{
    [appRenderer openHSPopUp:ComponentProperties];
    // MAIN SECTION ANIMATION
    for(int x=0; x<[MainSectionButtons count];x++)
    {
        for (int y=0;y<2;y++)
        {
            if (y == 0)
            {
                [(UIButton*)[self.view viewWithTag:MAIN_SECTION_BUTTON_PREFIX + x] setAlpha:0.0];
            }
            else if (y == 1)
            {
                [(UILabel*)[self.view viewWithTag:MAIN_SECTION_BUTTON_LABEL_PREFIX + x] setAlpha:0.0];
            }
            [UIView animateWithDuration:0.8
                                  delay:0.2*x
                                options:UIViewAnimationCurveEaseIn
                             animations:^void() {
                                 if (y == 0)
                                 {
                                     [(UIButton*)[self.view viewWithTag:MAIN_SECTION_BUTTON_PREFIX + x] setFrame:[[buttonFrames objectAtIndex:x] CGRectValue]];
                                     [(UIButton*)[self.view viewWithTag:MAIN_SECTION_BUTTON_PREFIX + x] setAlpha:1.0];
                                     
                                 }
                             }
                             completion:^(BOOL finished) {
                                 if(x == [MainSectionButtons count]-1 || (x+1)%9 == 0)
                                 {
                                     for(int h=0; h<[MainSectionButtons count];h++)
                                     {
                                         [UIView animateWithDuration:0.5
                                                               delay:0.2*x+0.5
                                                             options:UIViewAnimationCurveEaseIn
                                                          animations:^void() {
                                                              [(UILabel*)[self.view viewWithTag:MAIN_SECTION_BUTTON_LABEL_PREFIX + h] setAlpha:1.0];
                                                          }
                                                          completion:^(BOOL finished) {}];
                                     }
                                 }
                             }];
        }
    }
    buttonFrames = nil;
    //ANIMATE APPBAR SECTION
    UIButton *appBarButtonView = nil;
    @autoreleasepool {
        NSArray *subviews = [appBarScrollView subviews];
        int j = 0;
        
        bool animateAppbarScrollview = NO;
        if (appBarScrollView.contentSize.width > appBarScrollView.frame.size.width && ([AppBarSectionButtons count]!=5))
        {
            animateAppbarScrollview = YES;
            [appBarScrollView setContentOffset:CGPointMake(appBarScrollView.contentSize.width-appBarScrollView.frame.size.width, 0) animated:NO];
        }
        for (appBarButtonView in subviews)
        {
            
            
            if ([appBarButtonView isKindOfClass:[UIButton class]] || [appBarButtonView isKindOfClass:[UILabel class]])
            {
                [appBarButtonView setAlpha:0.0];
                [UIView animateWithDuration:0.75
                                      delay:0.15*j
                                    options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                                 animations:^(void){ [appBarButtonView setAlpha:1.0];}
                                 completion:^(BOOL finished)
                 {
                     if(animateAppbarScrollview)
                     {
                         if(j == ([AppBarSectionButtons count]*2)-2)
                             [UIView animateWithDuration:1.0
                                                   delay:0
                                                 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction
                                              animations:^(void){
                                                  [appBarScrollView setContentOffset:CGPointMake(0, 0) animated:YES];}
                                              completion:^(BOOL finished){}];
                     }
                     
                     
                 }];
                j++;
            }
            
        }
    }
    animateHS01 = NO;
    
}

- (void)onSplashScreenExpired:(id)userInfo
{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window)
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    
    if([window viewWithTag:1234])
        [[window viewWithTag:1234] setHidden:NO];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
  [UIView animateWithDuration:0.8
                          delay:0.0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                      //   splashScreen.transform = CGAffineTransformMakeScale(2, 2);
                         
                         [UIView animateWithDuration:1.0 
                                               delay:0.0 
                                             options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              splashScreen.alpha = 0.0;
                                              if (splashScreenView) {
                                                  splashScreenView.alpha = 0.0;
                                              }
                                          } completion:^(BOOL finished) {}];
                     } completion:^(BOOL finished) {
                         if (splashScreenView) {
                             [splashScreenView removeFromSuperview];
                             splashScreenView = nil;
                         }
                         [splashScreen removeFromSuperview];
//                         [self.navigationController.navigationBar setHidden:NO];
                         splashScreen = nil;
                         splashScreenShown = TRUE;
                         self.view.userInteractionEnabled = true;
                         //animateHS01 = YES;
                         [self DisplayHS01];
                         
                                           }];
}

#pragma mark - View lifecycle

- (void)viewDidLoad 
{
//    if(IS_IPHONE5)
//        self.view.frame = CGRectMake(0,0,320,568);
    animateHS01 = YES;
    scrollView.showsHorizontalScrollIndicator =NO;
    scrollView.showsVerticalScrollIndicator =NO;
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    MainSection=nil;
    AppBarSection=nil;
    HSNavigationBar = nil;
    pageControl = nil;
    ComponentInstanceID = nil;
    ComponentName = nil;
    
    [super viewDidUnload];
}

-(void)viewWillAppear:(BOOL)animated
{
//    if (IS_IPAD)
//    {
//        UIInterfaceOrientation toInterfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
//        [self HandleOrientation:toInterfaceOrientation];
//    }
    
    [self setComponentProperties];
 
    
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self setNavigationBar];
    if (self.clearallnavigation && [self.clearallnavigation isEqualToString:@"true"]) {
        [appRenderer onlyCreateLastSeenIfNotExist:@""];
    }else{
        [appRenderer createLastSeenIfNotExist:@""];
    }
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    for (id subview in [self.navigationController.navigationBar subviews]) 
    {
        if ([subview isMemberOfClass:[UIImageView class]]) 
        {
            if ([(UIImageView*)subview tag]==999) 
            {
                [self.navigationController.navigationBar bringSubviewToFront:subview];
            }
            
        }
        if ([subview isMemberOfClass:NSClassFromString(@"UINavigationBarBackground")])
        {
            for (UIImageView* subImageView in [subview subviews]) 
            {
                //[subImageView setHidden:YES];
                [subImageView removeFromSuperview];
            }
            
    
        }
        else if ([subview isMemberOfClass:NSClassFromString(@"UINavigationItemView")])
        {
            for (UILabel* subLabel in [subview subviews]) {
                if ([(UILabel*)subLabel tag]==3000) {
                    NSLog(@"yes label in navigation bar background");
                    [subLabel setHidden:YES];
                    [subLabel removeFromSuperview];
                   
                }
                
            }
        }
    }
    
    if (self.isMovingFromParentViewController || self.isBeingDismissed) {
        // Do your stuff here when the view is nolonger required.. Back button is pressed.
        BackgroundImage.image = nil;
        BackgroundImage = nil;
        MainSectionButtons = nil;
        AppBarSectionButtons=nil;
        [appRenderer removeShadowImage];
    }
    
    [super viewWillDisappear:animated];
}
////////ios 6 orientations ////////////////

-(BOOL)shouldAutorotate
{
//    if (IS_IPAD) {
//        return YES;
//    }
    return NO;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
//    if (IS_IPHONE) {
        return UIInterfaceOrientationMaskPortrait;
//    }
//    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
//    if (IS_IPHONE) {
        return UIInterfaceOrientationMaskPortrait;
//    }
//    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    
//    if (IS_IPAD)
//    {
//        return YES;
//    }
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration 
{
    [self HandleOrientation:toInterfaceOrientation];
    [appRenderer setNavigationHeaderBar:ComponentProperties navController:self.navigationController orientation:toInterfaceOrientation];
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

-(void)HandleOrientation:(UIInterfaceOrientation) toInterfaceOrientation
{
    NSUInteger currentPage = floor(scrollView.contentOffset.x / (scrollView.frame.size.width * 1.0));    
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight || toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) 
    {  
        //Landscape orientation
        AppBarSection.frame = CGRectMake(0, 579, 1024, 145);
        appBarScrollView.frame = CGRectMake(0, 0, 1024, 145);
        MainSection.frame = CGRectMake(0, 0, 1024, 590);
        scrollView.frame = CGRectMake(0, 0, 1024, 590);
        pageControl.frame = CGRectMake(0,550, 1024, 36);
        
        [(UIImageView*)[self.navigationController.navigationBar viewWithTag:1000] setFrame:CGRectMake(0,0, 1024, 44)];
    } 
    
    else if (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) 
    {
        //Portrait orientation
        AppBarSection.frame = CGRectMake(0, 835, 768, 145);
        appBarScrollView.frame = CGRectMake(0, 0, 768, 145);
        scrollView.frame = CGRectMake(0, 0, 768, 835);
        MainSection.frame = CGRectMake(0, 0, 768, 835);
        pageControl.frame = CGRectMake(0,799, 768, 36);
        [(UIImageView*)[self.navigationController.navigationBar viewWithTag:1000] setFrame:CGRectMake(0,0, 768, 44)];
    }
    
    NSUInteger nPages = ceil((double)[MainSectionButtons count] / 9);
    scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * nPages, self.scrollView.frame.size.height);
    scrollView.contentOffset = CGPointMake(scrollView.frame.size.width * currentPage,0.0);
    
    // Rotate the buttons and labels
    //[UIView animateWithDuration:duration animations:^() {
    if(animateHS01)
    {
        [buttonFrames removeAllObjects];
    }
     
    for(NSUInteger i=0,i_l=[MainSectionButtons count];i<i_l;i++)
    {
        UIButton* button = (UIButton*)[self.view viewWithTag:MAIN_SECTION_BUTTON_PREFIX + i];
        if (button)
        {
            button.frame = [self frameForMainButtonWithIndex:i withInterfaceOrientation:toInterfaceOrientation];
        }
        
        if(animateHS01)
        {
            [buttonFrames addObject:[NSValue valueWithCGRect:button.frame]];
        }
        
        
        UILabel* caption = (UILabel*)[self.view viewWithTag:MAIN_SECTION_BUTTON_LABEL_PREFIX + i];
        if (caption)
        {
            caption.frame = [self frameForMainButtonCaptionWithIndex:i withInterfaceOrientation:toInterfaceOrientation];
        }
    }
    //}];
    
 /*   UIImage *footerImage = [UIImage imageWithContentsOfFile:[appRenderer getBookRootPath:[ComponentProperties valueForKey:@"AppbarBackground"]]];
    footerImage = [UIImage AppBarScaletoFill:footerImage toSize:AppBarSection.frame.size];
    AppBarSection.backgroundColor = [UIColor colorWithPatternImage:footerImage];
    
*/
    NSString* appBarBgColor = [ComponentProperties valueForKey:@"AppbarBackground"];
    if (appBarBgColor && [appBarBgColor length] > 0 && [appBarBgColor characterAtIndex:0] == '#'){
//        [AppBarSection setBackgroundColor:[UIColor colorWithHexStr:[ComponentProperties valueForKey:@"AppbarBackground"]]];
    } else {
        //AppBarSection.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[appRenderer getBookRootPath:[ComponentProperties valueForKey:@"AppbarBackground"]]]];
        
        UIImage *footerImage = [UIImage imageWithContentsOfFile:[appRenderer getBookRootPath:[ComponentProperties valueForKey:@"AppbarBackground"]]];
//        footerImage = [UIImage AppBarScaletoFill:footerImage toSize:AppBarSection.frame.size];
        AppBarSection.backgroundColor = [UIColor colorWithPatternImage:footerImage];
    }
    
    if(appBarScrollView.contentSize.width < appBarScrollView.frame.size.width)
    {
        CGRect scrollFrame = appBarScrollView.frame;
        scrollFrame.size = CGSizeMake(appBarScrollView.contentSize.width, appBarScrollView.frame.size.height);
        scrollFrame.origin.x = AppBarSection.center.x - (appBarScrollView.contentSize.width/2);
        appBarScrollView.frame = scrollFrame;
    }

}


// ****************************
//   DEFAULT STARTER METHOD
// ****************************

//-(void)openComponentTemplate:(CXMLElement*) ComponentXML
//{
//    ComponentInstanceID = [[ComponentXML attributeForName:@"instanceId"] stringValue];
//    ComponentName = [[ComponentXML attributeForName:@"name"] stringValue];
//    [self doParseComponentXML:ComponentXML];
//}

#pragma mark - Component XML Parsing

/*-(void)doParseComponentXML:(CXMLElement*) ComponentXML
{
    //Parse xml
    MainSectionButtons = [[NSMutableArray alloc]init];
    AppBarSectionButtons = [[NSMutableArray alloc]init];
    //componentProperties = [[NSMutableArray alloc]init];
    
    AppBarSection = [[UIView alloc]init];
    AppBarSection.frame = [self frameForAppBar];
    AppBarSection.contentMode = UIViewContentModeScaleAspectFill;
    
    for (CXMLElement *element in [ComponentXML children] ) {
        if ([[element name ] isEqualToString:@"sections"]){
            
            NSString* xpath = [NSString stringWithFormat:@"//app/components/component[1]/%@",[element name]];
            NSArray* subElementArray = [element nodesForXPath:xpath error:nil];
            
            if ([subElementArray count]!=0) {
                for (CXMLElement *nextElement in [element children]) {
                    if ([[nextElement name ] isEqualToString:@"section"]){
                        NSString* next_xpath =[xpath stringByAppendingFormat:@"%@", [NSString stringWithFormat:@"/%@",[nextElement name]]];
                        NSArray* sub_ElementArray = [nextElement nodesForXPath:next_xpath error:nil];
                        
                        if ([sub_ElementArray count]!=0) { 
                            if ([[[nextElement attributeForName:@"name"]stringValue ] isEqualToString:@"ComponentProperties"]) {
                                [self setComponentPropertiesSection:nextElement];
                            }else  if ([[[nextElement attributeForName:@"name"]stringValue ] isEqualToString:@"MainSection"]) {
                                [self setMainSection:nextElement];
                            }else  if ([[[nextElement attributeForName:@"name"]stringValue ] isEqualToString:@"AppBar"]) {
                                [self setAppBar:nextElement];
                            }
                        }
                    }
                }
            }
        }
    }

    [self.view addSubview:AppBarSection];
    //[self.view addSubview:MainSection];
}
*/
-(void)addNavigationButtons:(UINavigationItem*)item
{
    if (!item.leftBarButtonItem)
    {
        if(self.navigationController.viewControllers.count == 1) 
        {
            // FIXME: Add an info button here ?
            //return; // This is the top view controller, we don't need a back button
        }else
        {
//            if ([APPDELEGATE isStandalone]==YES) {
//                //dont add main home nav button
//            }else{
                UIImage* backImage = [UIImage imageNamed:[appRenderer getIconName:@"navbutton_back"
                                                    HeaderTextColorWithHexaString:appRenderer.defaultHeaderTextColor == nil? [ComponentProperties objectForKey:@"HeaderTextColor"]:appRenderer.defaultHeaderTextColor]];
            //UIImage* backHoverImage = [UIImage imageNamed:@"main_ho"];
            UIButton* backButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [backButton setImage:backImage forState:UIControlStateNormal];
            //[backButton setImage:backHoverImage forState:UIControlStateSelected];
            backButton.frame = CGRectMake(0, 0, backImage.size.width, backImage.size.height);
            [backButton addTarget:self action:@selector(backTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBarButtonItem* backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
            item.leftBarButtonItem = backButtonItem;
//            }
        }
    }
    
    /*if(!item.rightBarButtonItems) {
        UIImage* infoImage = [UIImage imageWithContentsOfFile:[appRenderer getBookRootPath:[ComponentProperties valueForKey:@"InfoImage"]]];
        UIButton* infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [infoButton setImage:infoImage forState:UIControlStateNormal];
        infoButton.frame = CGRectMake(0, 0, 20, 27);
        [infoButton addTarget:self action:@selector(infoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* infoButtonItem = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
        
        UIImage* searchImage = [UIImage imageNamed:@"search.png"];
        UIButton* searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [searchButton setImage:searchImage forState:UIControlStateNormal];
        searchButton.frame = CGRectMake(0, 0, 20, 27);
        [searchButton addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* searchButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
        
        item.rightBarButtonItems = [NSArray arrayWithObjects:searchButtonItem,infoButtonItem,nil];
    }*/
    
    if(!item.rightBarButtonItems && appRenderer.isEnableMBlurb) {
        NSMutableArray* rightBarButtons = [[NSMutableArray alloc]init];
        
        UIImage* commentsImage = [UIImage imageNamed:[appRenderer getIconName:@"navbutton_papertrell"
                                                                                           HeaderTextColorWithHexaString:appRenderer.defaultHeaderTextColor]];
        //UIImage* commentsHoverImage = [UIImage imageNamed:@"papertrell_ho"];
        UIButton* commentsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [commentsButton setImage:commentsImage forState:UIControlStateNormal];
        //[commentsButton setImage:commentsHoverImage forState:UIControlStateSelected];
        commentsButton.frame = CGRectMake(0, 0, commentsImage.size.width, commentsImage.size.height);
        [commentsButton addTarget:self action:@selector(showComments:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* commentsButtonItem = [[UIBarButtonItem alloc] initWithCustomView:commentsButton];
        
        [rightBarButtons addObject:commentsButtonItem];
        
    /*    if ([[[ComponentProperties valueForKey:@"Info"] lowercaseString] isEqualToString:@"visible"]){
            UIImage* infoImage = [UIImage imageWithContentsOfFile:[appRenderer getBookRootPath:[ComponentProperties valueForKey:@"InfoImage"]]];
            UIButton* infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [infoButton setImage:infoImage forState:UIControlStateNormal];
            infoButton.frame = CGRectMake(0, 0, 20, 30);
            [infoButton addTarget:self action:@selector(infoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem* infoButtonItem = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
            
            [rightBarButtons addObject:infoButtonItem];
        }
        
        if ([[[ComponentProperties valueForKey:@"Search"] lowercaseString] isEqualToString:@"visible"]){
            UIImage* searchImage = [UIImage imageNamed:@"search.png"];
            UIButton* searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [searchButton setImage:searchImage forState:UIControlStateNormal];
            searchButton.frame = CGRectMake(0, 0, 20, 27);
            [searchButton addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem* searchButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
            
            [rightBarButtons addObject:searchButtonItem];
        }*/
        
        if ([rightBarButtons count] > 0){
            item.rightBarButtonItems = rightBarButtons;
        }
    }
}

-(void)showComments:(id)sender 
{
    if(![appRenderer.bookFlurryAPIKey isEqualToString:@""])
    {
        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@"AppHome", @"Clicked Papertrell Icon", nil];
//        [[Analytics sharedAnalytics] loggingAppletLaunch:@"mBlurb" withParameters:parameters];
    }

        
//    MBlurbViewController* MBlurbVC = [[MBlurbViewController alloc] initWithAppRender:appRenderer];
//    MBlurbVC.isFromMBlurbHome = YES;
//    MBlurbVC.isEveryOne=YES;
//    MBlurbVC.ContextKey =@""; //contextKey;
//    MBlurbVC.pageTitle = [appRenderer bookName];
//    MBlurbVC.ShowLikesList=YES;
//    MBlurbVC.showTitleNavbar = YES;
//    //MBlurbVC.strPageTitle=self.pageTitle;
//    [[APPDELEGATE navController] pushViewController:MBlurbVC animated:YES];
//    MBlurbVC = nil;

    
/*    MBlurbHomeVC* mbHomeVC = [[MBlurbHomeVC alloc]initWithAppRender:appRenderer];
    mbHomeVC.showCommentsList = TRUE;
    [[Analytics sharedAnalytics] loggingAppletLaunch:@"Clicked Papertrell Icon AppHome" withParameters :nil];
    [self.navigationController pushViewController:mbHomeVC animated:YES];
    mbHomeVC = nil;*/
}

-(void)searchButtonClick{
//    CXMLElement* element = [appRenderer.AppXMLParser doParseXMLForXPath:@"//app/properties"];
//
//    if (element) {
//        NSDictionary* d =[appRenderer.AppXMLParser doParseProperties:element];
//        GlossaryViewController* gvc = [[GlossaryViewController alloc]initWithAppRender:appRenderer];
//        [gvc getXmlfileFromRootDirectory:[d valueForKey:@"Glossary"]];
//        [gvc parseGlossaryContents:[gvc parseXmlForXpath:@"content/phrases"]];
//        [self.navigationController pushViewController:gvc animated:YES];
//
//        if (ComponentInstanceID && ComponentName){
//            //NSString* paramKey = [NSString stringWithFormat:@"%@-%@-%@",@"HS01", ComponentInstanceID, ComponentName];
//            NSString* paramKey = [NSString stringWithFormat:@"%@-%@",@"HS01", ComponentInstanceID];
//            if (paramKey.length > 250){
//                paramKey = [paramKey substringWithRange:NSMakeRange(0, 250)];
//            }
//
//       //     NSLog(@"Parameter Kery: %@", paramKey);
//        //    NSLog(@"Page Name: %@", @"glossary");
//
//            NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@"glossary", paramKey, nil];
//            [[Analytics sharedAnalytics] loggingAppletLaunch:[NSString stringWithFormat:@"%@-%@",appRenderer.appID,appRenderer.bookVersion] withParameters:parameters];
//        }
//
//        gvc = nil;
//    }
}

-(void)backTapped:(id)sender
{
    [appRenderer deleteLastSeenSettings:@""  forAppWithId:appRenderer.appID];
    [appRenderer loadBackStackAppXML];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)infoButtonClick:(id)sender {
  /*  CXMLElement* element = [appRenderer.AppXMLParser doParseXMLForXPath:@"//app/properties"];
    
    if (element) {
        NSDictionary* d =[appRenderer.AppXMLParser doParseProperties:element];
        CXMLElement* contentElement =  [appRenderer.AppXMLParser doParseXMLForXPath:[d valueForKey:@"info"]];
        InformationViewController* info = [[InformationViewController alloc]initWithAppRender:appRenderer];
        info.BackgroundImageFilepath = [appRenderer getBookRootPath:[ComponentProperties valueForKey:@"BgImage"]];
        [info parseContents:contentElement];
        [self.navigationController pushViewController:info animated:YES];
        
        if (ComponentInstanceID && ComponentName){
            //NSString* paramKey = [NSString stringWithFormat:@"%@-%@-%@",@"HS01", ComponentInstanceID, ComponentName];
            NSString* paramKey = [NSString stringWithFormat:@"%@-%@",@"HS01", ComponentInstanceID];
            if (paramKey.length > 250){
                paramKey = [paramKey substringWithRange:NSMakeRange(0, 250)];
            }
            
          //  NSLog(@"Parameter Kery: %@", paramKey);
          //  NSLog(@"Page Name: %@", @"info");
            
            NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@"info", paramKey, nil]; 
            [[Analytics sharedAnalytics] loggingAppletLaunch:[NSString stringWithFormat:@"%@-%@",appRenderer.appID,appRenderer.bookVersion] withParameters:parameters];
        }
    }
   */
}

-(UINavigationItem*)navigationItem
{
    UINavigationItem* item = [super navigationItem];
    [self addNavigationButtons:item];
    return item;
}


#pragma mark - Setup Component Properties


/*-(void)setComponentPropertiesSection:(CXMLElement *) ComponentPropertiesSectionNode{
    
    // Get the Properties for the Section
    ComponentProperties = [[NSMutableDictionary alloc]init];
    for (CXMLElement* subNode in [ComponentPropertiesSectionNode children]){
        if ([[subNode name] isEqualToString:@"properties"]){
            ComponentProperties = [appRenderer.AppXMLParser doParseProperties:subNode];
        }
    }
}
*/
-(void)setComponentProperties{
    CGFloat scale = [[UIScreen mainScreen] scale];
//    if(IS_IPHONE5)
//    {
//        //BackgroundImage.frame = CGRectMake(BackgroundImage.frame.origin.x,BackgroundImage.frame.origin.y, 320, 524);
//    }
    if ([ComponentProperties valueForKey:@"BgImage"]) {
        if ([ComponentProperties valueForKey:@"BgImage"] && [[ComponentProperties valueForKey:@"BgImage"] length] > 0 && [[ComponentProperties valueForKey:@"BgImage"] characterAtIndex:0] == '#'){
//            [self.view setBackgroundColor:[UIColor colorWithHexStr:[ComponentProperties valueForKey:@"BgImage"]]];
        } else {
            BackgroundImage.image = [UIImage imageWithContentsOfFile:[appRenderer getBookRootPath:[ComponentProperties valueForKey:@"BgImage"]]];
        }
    }
//    else{
//    BackgroundImage.image = [UIImage imageWithContentsOfFile:[appRenderer getBookRootPath:[ComponentProperties valueForKey:@"BgImage"]]];
//    BackgroundImage.backgroundColor = [UIColor grayColor];

    
    NSString *mainSectionBgColor = [ComponentProperties valueForKey:@"BgImage"];
    if (mainSectionBgColor && [mainSectionBgColor length] > 0 && [mainSectionBgColor characterAtIndex:0] == '#'){
//        [MainSection setBackgroundColor:[UIColor colorWithHexStr:mainSectionBgColor]];
    }
    
    NSString* appBarBgColor = [ComponentProperties valueForKey:@"AppbarBackground"];
    if (appBarBgColor && [appBarBgColor length] > 0 && [appBarBgColor characterAtIndex:0] == '#'){
//        [AppBarSection setBackgroundColor:[UIColor colorWithHexStr:[ComponentProperties valueForKey:@"AppbarBackground"]]];
    } else {
        //AppBarSection.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[appRenderer getBookRootPath:[ComponentProperties valueForKey:@"AppbarBackground"]]]];
        
        UIImage *footerImage = [UIImage imageWithContentsOfFile:[appRenderer getBookRootPath:[ComponentProperties valueForKey:@"AppbarBackground"]]];
//        footerImage = [UIImage AppBarScaletoFill:footerImage toSize:AppBarSection.frame.size];
        AppBarSection.backgroundColor = [UIColor colorWithPatternImage:footerImage];
    }
    
    /*NSString* appBarBgColor = [ComponentProperties valueForKey:@"AppbarBackground"];
    if (appBarBgColor && [appBarBgColor length] > 0 && [appBarBgColor characterAtIndex:0] == '#'){
        
        [AppBarSection setBackgroundColor:[UIColor colorWithHexStr:[ComponentProperties valueForKey:@"AppbarBackground"]]];
    } else {
        UIGraphicsBeginImageContext(AppBarSection.frame.size);
        [[UIImage imageWithContentsOfFile:[appRenderer getBookRootPath:[ComponentProperties valueForKey:@"AppbarBackground"]]] drawInRect:AppBarSection.bounds];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        AppBarSection.backgroundColor = [UIColor colorWithPatternImage:image];
    }*/
    
    NSString *splashImageFileName = [ComponentProperties valueForKey:@"SplashImage"];
    NSString *splashImagePath = splashImageFileName && [splashImageFileName length] > 0 ? [appRenderer getBookRootPath:splashImageFileName] : nil;
    doShowSplashScreen = ([[[ComponentProperties valueForKey:@"SplashScreen"] lowercaseString] isEqualToString:@"visible"]);
    
    if (self.clearallnavigation && [self.clearallnavigation isEqualToString:@"true"]) {
        doShowSplashScreen = NO;
    }
    
    NSString* splashScreenMode = @"fill";
    if ([ComponentProperties valueForKey:@"SplashScreenMode"]) {
        splashScreenMode = [ComponentProperties valueForKey:@"SplashScreenMode"];
    }

    if (!splashScreenShown && doShowSplashScreen){
        UIImage *_image = nil;
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:splashImagePath]){
            _image = [UIImage imageWithContentsOfFile:splashImagePath];
        }
        
        if (!splashScreen) {
//            if (IS_IPAD) {
//                if (!_image){
//                    _image = [UIImage imageNamed:@"papertrell_splash_ipad.jpg"];
//                }
//
//                splashScreen = [[UIImageView alloc]init];
//                if ([[splashScreenMode lowercaseString] isEqualToString:@"fit"]) {
//                   splashScreenView = [[UIImageView alloc] init];
//                }
//
//                UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
//                if ((interfaceOrientation==UIInterfaceOrientationPortrait)||(interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)) {
//                      splashScreen.frame = CGRectMake(0, 0, 768, 1024);
//                    if ([[splashScreenMode lowercaseString] isEqualToString:@"fit"]) {
//                      splashScreenView.frame = CGRectMake(0, 0, 768, 1024);
//                    }
//
//                }else if((interfaceOrientation==UIInterfaceOrientationLandscapeLeft)||(interfaceOrientation==UIInterfaceOrientationLandscapeRight)){
//                    splashScreen.frame = CGRectMake(0, 0, 1024, 768);
//                    if ([[splashScreenMode lowercaseString] isEqualToString:@"fit"]) {
//                       splashScreenView.frame = CGRectMake(0, 0, 1024, 768);
//                    }
//                }
//            }else{
//                if (!_image){
//                    _image = [UIImage imageNamed:@"papertrell_splash.jpg"];
//                }
//
//                splashScreen = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, IS_IPHONE5?568:480)];
//                 if ([[splashScreenMode lowercaseString] isEqualToString:@"fit"]) {
//                   splashScreenView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320,IS_IPHONE5?568:480)];
//                 }
//
//            }
        }
        
        if ([[splashScreenMode lowercaseString] isEqualToString:@"fit"]) {
//            [splashScreenView setImage:[UIImage makeBlurImage:[UIImage resizeImage:_image newSize:IS_IPAD?CGSizeMake(768, 300): CGSizeMake(320, 548)] BlurValue:20.0]];
//            UIImage *imgBlurWithOverlay = [UIImage imageViewWithOverlay:splashScreenView.image OverlyColor:[UIColor colorWithHexStr:@"000000"] Alpha:0.60];
//            splashScreenView.image = imgBlurWithOverlay;
            splashScreenView.contentMode = UIViewContentModeScaleAspectFill;
            splashScreenView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            splashScreenView.autoresizesSubviews = YES;
            splashScreenView.contentScaleFactor = scale;
            self.parentViewController.view.contentMode = UIViewContentModeScaleToFill;
            [self.parentViewController.view addSubview:splashScreenView];
            self.view.userInteractionEnabled = FALSE;
            splashScreen.contentMode = UIViewContentModeScaleAspectFit;
            self.parentViewController.view.contentMode = UIViewContentModeScaleAspectFit;

        }else{
            splashScreen.contentMode = UIViewContentModeScaleAspectFill;
            self.parentViewController.view.contentMode = UIViewContentModeScaleToFill;

        }
        
        splashScreen.image = _image;
        splashScreen.contentScaleFactor = scale;
        splashScreen.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        splashScreen.autoresizesSubviews = YES;
        [self.parentViewController.view addSubview:splashScreen];
        self.view.userInteractionEnabled = FALSE;

        [self.navigationController setNavigationBarHidden:YES animated:NO];
        
        [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(onSplashScreenExpired:) userInfo:nil repeats:NO];
    }else{
        if (animateHS01==YES) {
            animateHS01 = YES;
            [self DisplayHS01];
        }
        
    }
}


-(void)setNavigationBar
{
    [appRenderer setNavigationHeaderBar:ComponentProperties navController:self.navigationController orientation:UIInterfaceOrientationPortrait];
    if(!splashScreenShown)
    {
        UIWindow* window = [UIApplication sharedApplication].keyWindow;
        if (!window)
            window = [[UIApplication sharedApplication].windows objectAtIndex:0];
        
        if([window viewWithTag:1234])
            [[window viewWithTag:1234] setHidden:YES];
    }
}


#pragma mark- PageControl Handling

-(void)PageControllerSettings:(NSInteger)numberOfPages
{
    pageControlBeingUsed = YES;
    
    NSUInteger nPages = ceil((double)numberOfPages / 9);
	
    if (nPages>1) 
    {
       
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * nPages, self.scrollView.frame.size.height);
        self.scrollView.pagingEnabled = YES;
        self.pageControl.currentPage = 0;
        self.pageControl.numberOfPages = nPages;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)sender 
{
	if (!pageControlBeingUsed) 
    {
		// Switch the indicator when more than 50% of the previous/next page is visible
		CGFloat pageWidth = self.scrollView.frame.size.width;
		int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
		self.pageControl.currentPage = page;
        
	}
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView 
{
    pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView 
{
    pageControlBeingUsed = NO;
}

- (IBAction)changePage:(id)sender 
{
    
   // UIPageControl* pageControl1 = (UIPageControl*)sender;
   // [pageControl1 updateCurrentPageDisplay];
	// Update the scroll view to the appropriate page
	CGRect frame;
	frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
    //frame.origin.x = self.scrollView.frame.size.width * pageControl.currentPage;
	frame.origin.y = 0;
	frame.size = self.scrollView.frame.size;
	[self.scrollView scrollRectToVisible:frame animated:YES];

	pageControlBeingUsed = YES;
}


#pragma mark - Setup Main Section Properties

/*-(void)setMainSection:(CXMLElement *) MainSectionNode
{
    // ******** Create a AppBarSection View and set background  ************

    MainSection = [[UIView alloc]initWithFrame:(CGRectMake(0,IS_IPHONE5?30:0, (CGFloat)mainSectionWidth, (CGFloat)IS_IPHONE5?mainSectionHeightiPhone5:mainSectionHeight))];
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, (CGFloat)mainSectionWidth, (CGFloat)(CGFloat)IS_IPHONE5?mainSectionHeightiPhone5:mainSectionHeight)];
  //  self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, (CGFloat)mainSectionHeight, (CGFloat)mainSectionWidth, 36)];
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0,IS_IPHONE5?360: 316, (CGFloat)mainSectionWidth, 36)];
    scrollView.delegate = self;
    [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];

    MainSection.userInteractionEnabled = YES; 
    [MainSection addSubview:self.scrollView];
    [MainSection addSubview:self.pageControl];
    [self.view addSubview:MainSection];
    [MainSectionButtons removeAllObjects];
    

    
    // ******** Get Properties and Buttons  ************
    for (CXMLElement* subNode in [MainSectionNode children]){
        if ([(NSString*) [subNode name] isEqualToString:@"properties"]){
            // Get the Properties for the Section  * IF IT EXISTS
            mainSectionProperties = [appRenderer.AppXMLParser doParseProperties:subNode];
        }else if ([(NSString*) [subNode name] isEqualToString:@"objects"]){
            
            for (CXMLElement* objectNode in [subNode children]){
                if([[objectNode name ] isEqualToString:@"object"] ){ 
                    if ([[[objectNode attributeForName:@"type"] stringValue] isEqualToString:@"Button"]){
                        // Get the Properties of the button
                        NSMutableDictionary* buttonPropertiesDictionary = [[NSMutableDictionary alloc]init];
                        for (CXMLElement* objectSubNode in [objectNode children]){
                            if ([(NSString*) [objectSubNode name] isEqualToString:@"properties"]){
                                // Get the Properties for the Button
                                buttonPropertiesDictionary = [appRenderer.AppXMLParser doParseProperties:objectSubNode];
                            }
                        }
                        if ([appRenderer isHSButtonAvailable:buttonPropertiesDictionary currentTitleId:appRenderer.appID]) {
                            [MainSectionButtons addObject:buttonPropertiesDictionary];
                        }
                        buttonPropertiesDictionary = nil;
                    }
                }
            }
            // Now pass the array for buttons to be created;
            [self createMainSectionButtons:MainSectionButtons];

        }
    }
}
*/
-(CGRect)frameForMainButtonWithIndex:(NSUInteger)idx withInterfaceOrientation:(UIInterfaceOrientation)orientation 
{
    NSUInteger startingTop  =  20;
    NSUInteger startingLeft =  20;
    
    NSUInteger columnMargin  =  44;
    NSUInteger rowMargin     = 58;
    const NSUInteger rowCnt    = (idx % 9) / 3;
    const NSUInteger columnCnt = idx % 3 ;
    
    const NSUInteger buttonWidth  = 64;
    const NSUInteger buttonHeight =  64;
    NSUInteger spaceIntervalWidth = 32 ;
    if(UIInterfaceOrientationIsPortrait(orientation))
    {
        AppBarSection.frame = CGRectMake(0, 835, 768, 145);
        appBarScrollView.frame = CGRectMake(0, 0, 768, 145);
        scrollView.frame = CGRectMake(0, 0, 768, 835);
        MainSection.frame = CGRectMake(0, 0, 768, 835);
        pageControl.frame = CGRectMake(0,799, 768, 36);
        [(UIImageView*)[self.navigationController.navigationBar viewWithTag:1000] setFrame:CGRectMake(0,0, 768, 44)];

    }
    if(UIInterfaceOrientationIsLandscape(orientation) )
    {
       /* startingTop  = 20;
        startingLeft = 40;
        rowMargin    = 64;
        columnMargin = 128 + 128;*/
        
        startingTop  = 20;
        startingLeft = 40;
        rowMargin    = 54;
        columnMargin = 128 + 128;
        spaceIntervalWidth = 160;
        //Landscape orientation
        AppBarSection.frame = CGRectMake(0, 579, 1024, 145);
        appBarScrollView.frame = CGRectMake(0, 0, 1024, 145);
        MainSection.frame = CGRectMake(0, 0, 1024, 590);
        scrollView.frame = CGRectMake(0, 0, 1024, 590);
        pageControl.frame = CGRectMake(0,550, 1024, 36);
        
        [(UIImageView*)[self.navigationController.navigationBar viewWithTag:1000] setFrame:CGRectMake(0,0, 1024, 44)];
    }
    
    NSInteger pageOffset = 0;
    if ([MainSectionButtons count] > 9)
    {
        pageOffset = floor(idx/9.0)* scrollView.frame.size.width;
    }
//    NSLog(@" (%u*%u + %u*%u)+%u + %d",columnCnt, buttonWidth,  columnCnt, columnMargin, startingLeft , pageOffset);
    return CGRectMake((columnCnt*buttonWidth + (columnCnt+1)*spaceIntervalWidth)+ pageOffset,
                      (rowCnt*buttonHeight + rowCnt*rowMargin)+startingTop,
                      buttonWidth, buttonHeight);
    
//    return CGRectMake((columnCnt*buttonWidth + columnCnt*columnMargin)+startingLeft + pageOffset,
//                      (rowCnt*buttonHeight + rowCnt*rowMargin)+startingTop,
//                       buttonWidth, buttonHeight);
}

//        MainSectionButtonCaption.frame = CGRectMake(buttonFrame.origin.x-(CaptionWidthExcess/2), buttonFrame.origin.y, CaptionWidth, CaptionHeight);
-(CGRect)frameForMainButtonCaptionWithIndex:(NSUInteger)idx withInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    const CGRect buttonFrame = [self frameForMainButtonWithIndex:idx withInterfaceOrientation:orientation];
    //const NSUInteger captionWidthExcess = IS_IPAD ? 20 : 10;
//    const NSUInteger captionWidthExcess = IS_IPAD ? 60 : 10;
    const CGFloat captionWidth  = buttonFrame.size.width ;//+ captionWidthExcess;
    //const CGFloat captionHeight = 30.0;
    const CGFloat captionHeight =   30;
    return CGRectMake(buttonFrame.origin.x, buttonFrame.origin.y+buttonFrame.size.height, captionWidth, captionHeight);
//    return CGRectMake(buttonFrame.origin.x - captionWidth/2, buttonFrame.origin.y+buttonFrame.size.height, captionWidth, captionHeight);

}

 
-(void) createMainSectionButtons:(NSMutableArray *)ButtonPropertiesArray{
    CGRect frame0;
    if(buttonFrames)
        buttonFrames = nil;
    buttonFrames = [[NSMutableArray alloc] init];
    // *******  Sort Array based on Order attribute  *********
    /*NSSortDescriptor * sortByRank = [[NSSortDescriptor alloc] initWithKey:@"Order" ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:sortByRank];
    ButtonPropertiesArray = [[NSMutableArray alloc]initWithArray:[ButtonPropertiesArray sortedArrayUsingDescriptors:descriptors]];
    MainSectionButtons = [[NSMutableArray alloc]initWithArray:[ButtonPropertiesArray sortedArrayUsingDescriptors:descriptors]];*/
    
    NSUInteger btnCounter= 0;
    const UIInterfaceOrientation orientation = [self interfaceOrientation];
    
    for (NSDictionary* MainSectionButtonProperties in MainSectionButtons)
    {
        //Added by Ramesh -> Setting Auto click.
        [appRenderer setAutoClick:MainSectionButtonProperties];
        
        [self PageControllerSettings:[MainSectionButtons count]];
        UIButton* MainSectionButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect buttonFrame = [self frameForMainButtonWithIndex:btnCounter withInterfaceOrientation:orientation];

        if(animateHS01)
        {
            frame0 = buttonFrame;
            frame0.origin.y -= frame0.size.height;
            MainSectionButton.frame = frame0;
            [buttonFrames addObject:[NSValue valueWithCGRect:buttonFrame]];
        }
        else
        {
            MainSectionButton.frame = buttonFrame;
        }
        
        NSString *ImagePath = [appRenderer getBookRootPath:[MainSectionButtonProperties valueForKey:@"BgImage"]];
        
        // temporary fix by Rohit because there is a problem with the path.
        //ImagePath = [ImagePath stringByReplacingOccurrencesOfString:@"/../Images/" withString:@"/Media/"];
        
        UIImage* unresizedImage = [UIImage imageWithContentsOfFile:ImagePath];
        CGSize newSize = CGSizeMake(buttonFrame.size.width, buttonFrame.size.height);
        //CGSize unresizedImageSize = unresizedImage.size;
        UIImage* resizedImage = nil;
  /****************commented out for 2x image if not exists***********************/
        
////        if ([UIScreen mainScreen].scale == 2) {
////            resizedImage = [UIImage imageWithCGImage:unresizedImage.CGImage scale:2.0 orientation:UIImageOrientationUp];
////        } else {
//        
//        if ([UIScreen mainScreen].scale == 2 )
//        {
//            resizedImage = [UIImage imageWithCGImage:unresizedImage.CGImage scale:2.0 orientation:UIImageOrientationUp];
//            
//        }else{
//            resizedImage = [UIImage scale:unresizedImage toSize:newSize];
//        }
//
        
        NSString* imgPathExtension = [ImagePath pathExtension];
        NSString* imgfilename = [ImagePath stringByDeletingPathExtension];
        //NSString* folderpath = [imgPath stringByDeletingLastPathComponent];
        NSString* retinaImageName =nil;
        NSFileManager* fileManager = [NSFileManager defaultManager];
        
        if ([imgfilename rangeOfString:@"@2x"].location == NSNotFound ){
            retinaImageName = [imgfilename stringByAppendingString:[NSString stringWithFormat:@"@2x.%@",imgPathExtension]];
        }else{
            retinaImageName = ImagePath;
        }
        
        if (![fileManager fileExistsAtPath:retinaImageName]) {
            // if file doesnt have 2x suffixed and no file exists with 2x
//            resizedImage = [UIImage scale:unresizedImage toSize:newSize];
            
        }else  if ([ImagePath isEqualToString:retinaImageName]){
            
            BOOL retinaimgFileExists = [fileManager fileExistsAtPath:ImagePath];
            
            if (retinaimgFileExists) {
                resizedImage = [UIImage imageWithCGImage:unresizedImage.CGImage scale:2.0 orientation:UIImageOrientationUp];
            }else{
//                resizedImage = [UIImage scale:unresizedImage toSize:newSize];
            }
            
        }else if ([fileManager fileExistsAtPath:retinaImageName]) {
            if ([UIScreen mainScreen].scale==2) {
                resizedImage = [UIImage imageWithCGImage:unresizedImage.CGImage scale:2.0 orientation:UIImageOrientationUp];
                
            }
            
        }else{
//            resizedImage = [UIImage scale:unresizedImage toSize:newSize];
        }
        
        if (resizedImage) {
            [MainSectionButton setImage:resizedImage forState:UIControlStateNormal];
            
        }else{
            [MainSectionButton setImage:unresizedImage forState:UIControlStateNormal];
        }
        
        //Handle image overLay -- Added by Ramesh
        if([MainSectionButtonProperties valueForKey:@"Overlay"] &&
           ![[MainSectionButtonProperties valueForKey:@"Overlay"] isEqualToString:@""] &&
           [fileManager fileExistsAtPath:[appRenderer getBookRootPath:[MainSectionButtonProperties valueForKey:@"Overlay"]]])
        {
            NSString *overLayImagePath = [appRenderer getBookRootPath:[MainSectionButtonProperties valueForKey:@"Overlay"]];
            UIImageView* MainSectionButtonFGImage  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MainSectionButton.frame.size.width, MainSectionButton.frame.size.height)];
            MainSectionButtonFGImage.contentMode = UIViewContentModeCenter;

            [MainSectionButtonFGImage setImage:[UIImage imageWithContentsOfFile:overLayImagePath]];
//            CGSize newSize = CGSizeMake(IS_RETINA?200:100, IS_RETINA?200:100);
//            [MainSectionButtonFGImage setImage:[UIImage getRezisedImage:newSize filePath:overLayImagePath]];
            [MainSectionButton addSubview:MainSectionButtonFGImage];
        }
        
        MainSectionButton.contentMode = UIViewContentModeScaleAspectFit;
        [MainSectionButton addTarget:self action:@selector(MainSectionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        MainSectionButton.userInteractionEnabled = YES;
        MainSectionButton.tag = MAIN_SECTION_BUTTON_PREFIX + btnCounter;
        [self.scrollView addSubview:MainSectionButton];
        [self.scrollView bringSubviewToFront:MainSectionButton];
        
        
        
        MainSectionButton = nil;
        // *********  Add the Caption  **********
        UILabel* MainSectionButtonCaption = [[UILabel alloc]init];
        MainSectionButtonCaption.tag = MAIN_SECTION_BUTTON_LABEL_PREFIX + btnCounter;
        MainSectionButtonCaption.frame = [self frameForMainButtonCaptionWithIndex:btnCounter withInterfaceOrientation:orientation];
        
//        if (IS_IPAD) {
//            [MainSectionButtonCaption setFont:[UIFont fontWithName:FONTNAME size:15.0]];
//        }else {
//            [MainSectionButtonCaption setFont:[UIFont fontWithName:FONTNAME size:12.0]];
//        }
        
        [MainSectionButtonCaption setText:[MainSectionButtonProperties objectForKey:@"Caption"]];
        //NSString *captionBgColor = [MainSectionButtonProperties objectForKey:@"CaptionBackground"];

        NSString *captionBgColor = [ComponentProperties objectForKey:@"MainsectionCaptionBackground"];

        NSString* buttonTextColor = [ComponentProperties objectForKey:@"ButtonTextColor"];
        
        if (captionBgColor && [captionBgColor length] > 0 && [captionBgColor characterAtIndex:0] == '#'){
//            [MainSectionButtonCaption setBackgroundColor:[UIColor colorWithHexStr:captionBgColor]];
        } else {
            [MainSectionButtonCaption setBackgroundColor:[UIColor clearColor]];
        }
        
        if (buttonTextColor && [buttonTextColor length] > 0 && [buttonTextColor characterAtIndex:0] == '#') {
//            [MainSectionButtonCaption setTextColor:[UIColor colorWithHexStr:buttonTextColor]];
        } else {
            [MainSectionButtonCaption setTextColor:[UIColor blackColor]];                    
        }
        
        if ([[ComponentProperties valueForKey:@"CaptionVisibility"] isEqualToString:@"visible"]) {
            MainSectionButtonCaption.hidden = NO;
        }else if ([[ComponentProperties valueForKey:@"CaptionVisibility"] isEqualToString:@"hidden"]){
            MainSectionButtonCaption.hidden = YES;
        }
        [MainSectionButtonCaption setTextAlignment:NSTextAlignmentCenter];
        [MainSectionButtonCaption setNumberOfLines:2];
        [MainSectionButtonCaption setOpaque:NO];
        //[MainSectionButtonCaption setBackgroundColor:[UIColor clearColor]];
        //[MainSection addSubview:MainSectionButtonCaption];
        //[MainSection bringSubviewToFront:MainSectionButtonCaption];
        
        [self.scrollView addSubview:MainSectionButtonCaption];
        [self.scrollView bringSubviewToFront:MainSectionButtonCaption];
        MainSectionButtonCaption = nil;
        btnCounter++;
    }
}


-(void)MainSectionButtonAction:(id)sender
{
    if (ComponentInstanceID && ComponentName){
        //NSString* paramKey = [NSString stringWithFormat:@"%@-%@-%@",@"HS01", ComponentInstanceID, ComponentName];
        NSString* paramKey = [NSString stringWithFormat:@"%@-%@",@"HS01", ComponentInstanceID];
        if (paramKey.length > 250){
            paramKey = [paramKey substringWithRange:NSMakeRange(0, 250)];
        }
        
//        NSLog(@"Parameter Kery: %@", paramKey);
//        NSLog(@"Button Caption: %@", [[MainSectionButtons objectAtIndex:[(UIButton*)sender tag]-MAIN_SECTION_BUTTON_PREFIX]objectForKey:@"Caption"]);
        
        NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[[MainSectionButtons objectAtIndex:[(UIButton*)sender tag]-MAIN_SECTION_BUTTON_PREFIX]objectForKey:@"Caption"], paramKey, nil]; 
//        [[Analytics sharedAnalytics] loggingAppletLaunch:[NSString stringWithFormat:@"%@-%@",appRenderer.appID,appRenderer.bookVersion] withParameters:parameters];
    }
    if ([[MainSectionButtons objectAtIndex:[(UIButton*)sender tag]-MAIN_SECTION_BUTTON_PREFIX]objectForKey:@"InternalLink"] &&
        ![[[MainSectionButtons objectAtIndex:[(UIButton*)sender tag]-MAIN_SECTION_BUTTON_PREFIX]objectForKey:@"InternalLink"] isEqualToString:@""]){
        
        NSString *internalLink = [[MainSectionButtons objectAtIndex:[(UIButton*)sender tag]-MAIN_SECTION_BUTTON_PREFIX]objectForKey:@"InternalLink"];
    if (internalLink.length!=0){
        
//        NSString* decodedstr = [[[MainSectionButtons objectAtIndex:[(UIButton*)sender tag]-MAIN_SECTION_BUTTON_PREFIX]objectForKey:@"InternalLink"]stringByReplacingURLEncoding];
//        decodedstr = [decodedstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        decodedstr = [decodedstr stringByAddingURLEncoding];
//        decodedstr = [decodedstr stringByReplacingURLEncoding];
//
////        [appRenderer internalLinksSelection:[NSURLRequest requestWithURL:[NSURL URLWithString:decodedstr]]];
//        [appRenderer ProcessWebViewRequest:[NSURL URLWithString:decodedstr] Mblurb:nil contextKey:nil webView:nil currentPage:nil];
    }
    }else if ([[MainSectionButtons objectAtIndex:[(UIButton*)sender tag]-MAIN_SECTION_BUTTON_PREFIX]objectForKey:@"ActionParameters"]) {
        if ([[MainSectionButtons objectAtIndex:[(UIButton*)sender tag]-MAIN_SECTION_BUTTON_PREFIX]objectForKey:@"XmlFile"]){
//            [appRenderer.AppXMLParser readNewXml:[appRenderer getBookRootPath:[[MainSectionButtons objectAtIndex:[(UIButton*)sender tag]-MAIN_SECTION_BUTTON_PREFIX]objectForKey:@"XmlFile"]] propertyExists:YES];
//            [appRenderer goToComponent:[appRenderer.AppXMLParser doParseXMLForXPath:[[MainSectionButtons objectAtIndex:[(UIButton*)sender tag]-MAIN_SECTION_BUTTON_PREFIX]objectForKey:@"Action"]] params:[[MainSectionButtons objectAtIndex:[(UIButton*)sender tag]-MAIN_SECTION_BUTTON_PREFIX]objectForKey:@"ActionParameters"] highlightText:nil selectorText:nil shouldSwitch:false];
        }else
        if ([[MainSectionButtons objectAtIndex:[(UIButton*)sender tag]-MAIN_SECTION_BUTTON_PREFIX]objectForKey:@"Action"]) {
//            appRenderer.AppXMLParser.isAppXMLFile = NO;
//            [appRenderer goToComponent:[appRenderer.AppXMLParser doParseXMLForXPath:[[MainSectionButtons objectAtIndex:[(UIButton*)sender tag]-MAIN_SECTION_BUTTON_PREFIX]objectForKey:@"Action"]] params:[[MainSectionButtons objectAtIndex:[(UIButton*)sender tag]-MAIN_SECTION_BUTTON_PREFIX]objectForKey:@"ActionParameters"] highlightText:nil selectorText:nil shouldSwitch:false];
        }else{
//            appRenderer.AppXMLParser.isAppXMLFile = NO;
//            [appRenderer goToComponent:nil params:[[MainSectionButtons objectAtIndex:[(UIButton*)sender tag]-MAIN_SECTION_BUTTON_PREFIX]objectForKey:@"ActionParameters"] highlightText:nil selectorText:nil shouldSwitch:false];
        }
        
        
    } else {
//        appRenderer.AppXMLParser.isAppXMLFile = NO;
//       [appRenderer goToComponent:[appRenderer.AppXMLParser doParseXMLForXPath:[[MainSectionButtons objectAtIndex:[(UIButton*)sender tag]-MAIN_SECTION_BUTTON_PREFIX]objectForKey:@"Action"]] shouldSwitch:false];
    }
 }

#pragma mark - Setup Component Properties

-(CGRect)frameForAppBar 
{
//   if (IS_IPAD)
//    {
//        return UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation]) ? CGRectMake(0, 833, 768,145) : CGRectMake(0, 579, 1024,145);
//        //return UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation]) ? CGRectMake(0, 879, 768,145) : CGRectMake(0, 618, 1024,145);
//    }
//    else
//    {
//        return CGRectMake(0,(CGFloat) IS_IPHONE5?appBarSectionTopPosiPhone5:appBarSectionTopPos, (CGFloat)appBarSectionWidth, (CGFloat)appBarSectionHeight);
//    }
    return CGRectMake(0,(CGFloat)appBarSectionTopPos, (CGFloat)appBarSectionWidth, (CGFloat)appBarSectionHeight);
}

/*-(void)setAppBar:(CXMLElement *) AppBarNode
{
    // ******** Create a AppBarSection View and set background  ************
    //AppBarSection = [[UIView alloc]init];//WithFrame:(CGRectMake(0,0, (CGFloat)appBarSectionWidth, (CGFloat)appBarSectionHeight))];
    //AppBarSection.frame = [self frameForAppBar];
    
    //[self.view addSubview:AppBarSection];
    //AppBarSection.backgroundColor = [UIColor yellowColor];
    // ******** Get Properties and Buttons  ************
    for (CXMLElement* subNode in [AppBarNode children]){
        if ([(NSString*) [subNode name] isEqualToString:@"properties"]){
            // Get the Properties for the Section  * IF IT EXISTS
            appBarProperties = [appRenderer.AppXMLParser doParseProperties:subNode]; 
            
        }else if ([(NSString*) [subNode name] isEqualToString:@"objects"]){
            for (CXMLElement* objectNode in [subNode children]){
                if([[objectNode name ] isEqualToString:@"object"] ){ 
                    if ([[[objectNode attributeForName:@"type"] stringValue] isEqualToString:@"Button"]){
                        // Get the Properties of the button
                        NSMutableDictionary* buttonPropertiesDictionary = [[NSMutableDictionary alloc]init];                                
                        for (CXMLElement* objectSubNode in [objectNode children]){
                            if ([(NSString*) [objectSubNode name] isEqualToString:@"properties"]){
                                // Get the Properties for the Button
                                buttonPropertiesDictionary = [appRenderer.AppXMLParser doParseProperties:objectSubNode]; //commented for now to be used later
                            }
                        }
                        if ([appRenderer isHSButtonAvailable:buttonPropertiesDictionary currentTitleId:appRenderer.appID]) {
                           [AppBarSectionButtons addObject:buttonPropertiesDictionary];
                        }
                        
                    }
                } 
            }
            
            // ******   Now pass the array for buttons to be created ******** ;
            [self createAppBarSectionButtons:AppBarSectionButtons]; 
        }
    }
    [self.view addSubview:AppBarSection];
}
*/
-(void) createAppBarSectionButtons:(NSMutableArray *)ButtonPropertiesArray{
    
    appBarScrollView = [[UIScrollView alloc] initWithFrame:(CGRectMake(0, 0, (CGFloat)appBarSectionWidth, (CGFloat)appBarSectionHeight))];
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
//    if (IS_IPAD) {
//        if(orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
//            //Portrait orientation
//            appBarScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 768, 145)];
//        }
        if(orientation == UIInterfaceOrientationLandscapeRight ||orientation == UIInterfaceOrientationLandscapeLeft) {
            //Landscape orientation
            appBarScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 1024, 145)];
        }
//    }
    
    appBarScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	appBarScrollView.clipsToBounds = YES;
	appBarScrollView.scrollEnabled = YES;
	appBarScrollView.pagingEnabled = NO;
    appBarScrollView.showsHorizontalScrollIndicator = NO;
    [appBarScrollView setCanCancelContentTouches:NO];
    appBarScrollView.backgroundColor = [UIColor clearColor];
    
    
    // Sort Array based on Order attribute
    // Loop thorugh the button Array  and create buttons at the appropriate place with image and caption
    /*NSSortDescriptor * sortByRank = [[NSSortDescriptor alloc] initWithKey:@"Order" ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:sortByRank];
    ButtonPropertiesArray = [[NSMutableArray alloc]initWithArray:[ButtonPropertiesArray sortedArrayUsingDescriptors:descriptors]];
    AppBarSectionButtons = [[NSMutableArray alloc]initWithArray:[ButtonPropertiesArray sortedArrayUsingDescriptors:descriptors]];*/

    int StartingTop;
    int StartingLeft;
    
    int ColumnMargin;
    int RowMargin;
    
    int ButtonHeight;
    int ButtonWidth;
    int CaptionHeight;
//    int CaptionWidthExcess;
//    int CaptionWidth;
    
//    if (IS_IPAD) {
//        // For iPad
//        StartingTop =  20;
//        StartingLeft = ([ButtonPropertiesArray count] == 5) ? 30: 64;
//
//        ColumnMargin=75;
//        RowMargin=100;
//
//        ButtonHeight = 75;
//        ButtonWidth = 75;
//        CaptionHeight = 35;
////        CaptionWidthExcess = 20;
////        CaptionWidth = ButtonWidth+CaptionWidthExcess;
//    }else{
        StartingTop = 10;
        StartingLeft = ([ButtonPropertiesArray count] == 5) ? 5 : 20;
    
        ColumnMargin=15;
        RowMargin=0;
    
        ButtonHeight = 50  ;
        ButtonWidth = 50;
        CaptionHeight = 24;
//        CaptionWidthExcess = 5;
//        CaptionWidth = ButtonWidth+CaptionWidthExcess;
//    }
    
    
    int btnCounter= 0;
    int Totalrows = AppBarMaxNoOfRowsPerPage;
    
    for (int rowCounter =0 ; rowCounter <Totalrows ; rowCounter++) {
        //for (int columnCounter =0 ; columnCounter < AppBarMaxNoOfColumns ; columnCounter++) {
        for (int columnCounter =0 ; columnCounter < [ButtonPropertiesArray count] ; columnCounter++) {
            if (btnCounter < [AppBarSectionButtons count]) {
                
                // *********  Add the Button  **********
                NSDictionary* AppBarSectionButtonProperties = [ButtonPropertiesArray objectAtIndex:btnCounter];
                //Added by Ramesh -> Setting Auto click.
                [appRenderer setAutoClick:AppBarSectionButtonProperties];
                
                UIButton* AppBarSectionButton  = [UIButton buttonWithType:UIButtonTypeCustom];
                
                int buttonX = ((columnCounter)*ButtonWidth)+((columnCounter)*ColumnMargin) + StartingLeft;            
                int buttonY = ((rowCounter)*ButtonHeight)+((rowCounter)*RowMargin) + StartingTop;
                AppBarSectionButton.frame = CGRectMake( buttonX,buttonY, ButtonWidth, ButtonHeight);
                NSString *ImagePath = [appRenderer getBookRootPath:[AppBarSectionButtonProperties valueForKey:@"BgImage"]];

                UIImage* unresizedImage = [UIImage imageWithContentsOfFile:ImagePath];
                CGSize newSize = CGSizeMake(ButtonWidth, ButtonHeight);
               // CGSize unresizedImageSize = unresizedImage.size;
                UIImage* resizedImage = nil;
                
//                if ([UIScreen mainScreen].scale == 2 && unresizedImage.scale == 1
//                    && unresizedImageSize.height >= newSize.height * 2.0
//                    && unresizedImageSize.width >=  newSize.width  * 2.0) {
//                    resizedImage = [UIImage imageWithCGImage:unresizedImage.CGImage scale:2.0 orientation:UIImageOrientationUp];
//                } else {
//                if ([UIScreen mainScreen].scale == 2 )
//                {
//                    resizedImage = [UIImage imageWithCGImage:unresizedImage.CGImage scale:2.0 orientation:UIImageOrientationUp];
//                    
//                }else{
//                    resizedImage = [UIImage scale:unresizedImage toSize:newSize];
//                }
                
                NSString* imgPathExtension = [ImagePath pathExtension];
                NSString* imgfilename = [ImagePath stringByDeletingPathExtension];
                //NSString* folderpath = [imgPath stringByDeletingLastPathComponent];
                NSString* retinaImageName =nil;
                NSFileManager* fileManager = [NSFileManager defaultManager];
                
                if ([imgfilename rangeOfString:@"@2x"].location == NSNotFound ){
                    retinaImageName = [imgfilename stringByAppendingString:[NSString stringWithFormat:@"@2x.%@",imgPathExtension]];
                }else{
                    retinaImageName = ImagePath;
                }
                
                if (![fileManager fileExistsAtPath:retinaImageName]) {
                    // if file doesnt have 2x suffixed and no file exists with 2x
//                    resizedImage = [UIImage scale:unresizedImage toSize:newSize];
                    
                }else  if ([ImagePath isEqualToString:retinaImageName]){
                    
                    BOOL retinaimgFileExists = [fileManager fileExistsAtPath:ImagePath];
                    
                    if (retinaimgFileExists) {
                        resizedImage = [UIImage imageWithCGImage:unresizedImage.CGImage scale:2.0 orientation:UIImageOrientationUp];
                    }else{
//                        resizedImage = [UIImage scale:unresizedImage toSize:newSize];
                    }
                    
                }else if ([fileManager fileExistsAtPath:retinaImageName]) {
                    if ([UIScreen mainScreen].scale==2) {
                        resizedImage = [UIImage imageWithCGImage:unresizedImage.CGImage scale:2.0 orientation:UIImageOrientationUp];
                        
                    }
                    
                }else{
//                    resizedImage = [UIImage scale:unresizedImage toSize:newSize];
                }
                
                if (resizedImage) {
                    [AppBarSectionButton setImage:resizedImage forState:UIControlStateNormal];
                    
                }else{
                    [AppBarSectionButton setImage:unresizedImage forState:UIControlStateNormal];
                    
                }

                

                
//                [AppBarSectionButton setImage:resizedImage forState:UIControlStateNormal];

                //NSLog(@"%@",[appRenderer getBookRootPath:[[MainSectionButtons objectAtIndex:RowIncrement] valueForKey:@"BgImage"]]);
                //[AppBarSectionButton setImage:[UIImage imageWithContentsOfFile:ImagePath] forState:UIControlStateNormal];
                
                [AppBarSectionButton addTarget:self action:@selector(AppBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                AppBarSectionButton.userInteractionEnabled = YES;
                AppBarSectionButton.tag = btnCounter; //TODO change this to the button id
                
                // *********  Add the Caption  **********
                if([ComponentProperties objectForKey:@"AppBarCaptionVisibility"] &&
                   [[ComponentProperties objectForKey:@"AppBarCaptionVisibility"] caseInsensitiveCompare:@"visible"] == NSOrderedSame)
                {
                    UILabel* AppBarButtonCaption = [[UILabel alloc]init];//WithFrame:CGRectMake(buttonX, buttonY+ButtonHeight, CaptionWidth, CaptionHeight)];
                    
//                    if (IS_IPAD) {
//                        //                    AppBarButtonCaption.frame = CGRectMake(buttonX -(CaptionWidthExcess/2), buttonY+ButtonHeight, CaptionWidth,  CaptionHeight);
//
//                        AppBarButtonCaption.frame = CGRectMake(buttonX, buttonY+ButtonHeight, ButtonWidth,  CaptionHeight);
////                        [AppBarButtonCaption setFont:[UIFont fontWithName:FONTNAME size:14.0]];
//                        [AppBarButtonCaption setNumberOfLines:2];
//                    }else{
                        //                    AppBarButtonCaption.frame = CGRectMake(buttonX -(CaptionWidthExcess/2), buttonY+ButtonHeight, CaptionWidth, CaptionHeight);
                        
                        AppBarButtonCaption.frame = CGRectMake(buttonX, buttonY+ButtonHeight, ButtonWidth + 3, CaptionHeight);
//                        [AppBarButtonCaption setFont:[UIFont fontWithName:FONTNAME size:10.0]];
                        [AppBarButtonCaption setNumberOfLines:2];
//                    }
                    
                    [AppBarButtonCaption setText:[AppBarSectionButtonProperties objectForKey:@"Caption"]];
                    [AppBarButtonCaption setTextAlignment:NSTextAlignmentCenter];
                    
                    //NSString *appBarCaptionBgColor = [AppBarSectionButtonProperties valueForKey:@"CaptionBackground"];
                    NSString *appBarCaptionBgColor = [ComponentProperties valueForKey:@"AppbarCaptionBackground"];
                    NSString *captionTextColor = [ComponentProperties valueForKey:@"ButtonTextColor"];
                    
                    if (appBarCaptionBgColor && [appBarCaptionBgColor length] > 0 && [appBarCaptionBgColor characterAtIndex:0] == '#'){
//                        [AppBarButtonCaption setBackgroundColor:[UIColor colorWithHexStr:appBarCaptionBgColor]];
                    } else {
                        [AppBarButtonCaption setBackgroundColor:[UIColor clearColor]];
                    }
                    
                    if (captionTextColor && [captionTextColor length] > 0 && [captionTextColor characterAtIndex:0] == '#'){
//                        [AppBarButtonCaption setTextColor:[UIColor colorWithHexStr:captionTextColor]];
                    } else {
                        [AppBarButtonCaption setTextColor:[UIColor blackColor]];
                    }
                    
                    [AppBarButtonCaption setOpaque:NO];
                    [appBarScrollView addSubview:AppBarButtonCaption];
                }
                else
                {
                    CGRect tempFrame = AppBarSectionButton.frame;
                    tempFrame.origin.y = appBarScrollView.center.y - ButtonHeight/2;
                    AppBarSectionButton.frame = tempFrame;
                }
                [AppBarSectionButton setAlpha:0.0];
                [appBarScrollView addSubview:AppBarSectionButton];
                AppBarSectionButtonProperties =nil;
                btnCounter++;

            }
        }
    }
    //oldcode **hp** [appBarScrollView setContentSize:CGSizeMake(([ButtonPropertiesArray count] * ButtonWidth) + ([ButtonPropertiesArray count] * ColumnMargin) + StartingLeft, [appBarScrollView bounds].size.height)];

    CGFloat appBarSVwidth = ([ButtonPropertiesArray count] * ButtonWidth) + ([ButtonPropertiesArray count] * ColumnMargin) + StartingLeft;
    [appBarScrollView setContentSize:CGSizeMake(appBarSVwidth, [appBarScrollView bounds].size.height)];

    if(appBarSVwidth < self.view.frame.size.width)
    {
        CGRect scrollFrame = appBarScrollView.frame;
        scrollFrame.size = CGSizeMake(appBarScrollView.contentSize.width, appBarScrollView.frame.size.height);
        scrollFrame.origin.x = AppBarSection.center.x - (appBarSVwidth/2);
        appBarScrollView.frame = scrollFrame;
    }
    
    if(!AppBarSectionButtons.count && AppBarSectionButtons.count==0)
    {
        [AppBarSection setHidden:YES];
    }
    
    [AppBarSection addSubview:appBarScrollView];
       ButtonPropertiesArray = nil;
}

-(void)AppBarButtonAction:(id)sender {
    if ([[AppBarSectionButtons objectAtIndex:[(UIButton*)sender tag]]objectForKey:@"InternalLink"] &&
        ![[[AppBarSectionButtons objectAtIndex:[(UIButton*)sender tag]]objectForKey:@"InternalLink"] isEqualToString:@""]){
        
//        NSString* decodedstr = [[[AppBarSectionButtons objectAtIndex:[(UIButton*)sender tag]]objectForKey:@"InternalLink"] stringByReplacingURLEncoding];
//        decodedstr = [decodedstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        decodedstr = [decodedstr stringByAddingURLEncoding];
//        decodedstr = [decodedstr stringByReplacingURLEncoding];
//
//        [appRenderer ProcessWebViewRequest:[NSURL URLWithString:decodedstr] Mblurb:nil contextKey:nil webView:nil currentPage:nil];
//        [appRenderer internalLinksSelection:[NSURLRequest requestWithURL:[NSURL URLWithString:decodedstr]]];
        
//        [appRenderer internalLinksSelection:[NSURLRequest requestWithURL:[NSURL URLWithString:[[[AppBarSectionButtons objectAtIndex:[(UIButton*)sender tag]] objectForKey:@"InternalLink"]stringByReplacingURLEncoding]]]];
//        
    }else if ([[AppBarSectionButtons objectAtIndex:[(UIButton*)sender tag]]objectForKey:@"ActionParameters"]) {
        if ([[AppBarSectionButtons objectAtIndex:[(UIButton*)sender tag]]objectForKey:@"XmlFile"]){
//            [appRenderer.AppXMLParser readNewXml:[appRenderer getBookRootPath:[[AppBarSectionButtons objectAtIndex:[(UIButton*)sender tag]]objectForKey:@"XmlFile"]] propertyExists:YES];
//            [appRenderer goToComponent:[appRenderer.AppXMLParser doParseXMLForXPath:[[AppBarSectionButtons objectAtIndex:[(UIButton*)sender tag]]objectForKey:@"Action"]] params:[[AppBarSectionButtons objectAtIndex:[(UIButton*)sender tag]]objectForKey:@"ActionParameters"] highlightText:nil selectorText:nil shouldSwitch:false];
        }else
        if ([[AppBarSectionButtons objectAtIndex:[(UIButton*)sender tag]]objectForKey:@"Action"]) {
//            appRenderer.AppXMLParser.isAppXMLFile = NO;
//            [appRenderer goToComponent:[appRenderer.AppXMLParser doParseXMLForXPath:[[AppBarSectionButtons objectAtIndex:[(UIButton*)sender tag]]objectForKey:@"Action"]] params:[[AppBarSectionButtons objectAtIndex:[(UIButton*)sender tag]]objectForKey:@"ActionParameters"] highlightText:nil selectorText:nil shouldSwitch:false];
        }else{
//            appRenderer.AppXMLParser.isAppXMLFile = NO;
//            [appRenderer goToComponent:nil params:[[AppBarSectionButtons objectAtIndex:[(UIButton*)sender tag]]objectForKey:@"ActionParameters"] highlightText:nil selectorText:nil shouldSwitch:false];
        }
        
        
    }else {
//        appRenderer.AppXMLParser.isAppXMLFile = NO;
//        [appRenderer goToComponent:[appRenderer.AppXMLParser doParseXMLForXPath:[[AppBarSectionButtons objectAtIndex:[(UIButton*)sender tag]]objectForKey:@"Action"]] shouldSwitch:false];
    }
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
