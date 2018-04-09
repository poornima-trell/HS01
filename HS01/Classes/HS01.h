//
//  HS01.h
//  Papyrus
//
//  Created by Arun Benty on 12/2/11.
//  Copyright (c) 2011 Trellisys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppRenderer.h"
#import "AppConstants.h"
//#import "CXMLNode.h"
//#import "CXMLElement.h"

@interface HS01 : UIViewController <UIScrollViewDelegate>{    
    NSInteger splashCounter;
    NSTimer *splashTimer;
    //Component Properties

    UIButton *SearchButton;
    UIButton *InfoButton;
    
    UIImageView *splashScreen;
    UIImageView *splashScreenView;
    
    UIImageView *BgImage;
    UIImageView *SearchImage;
    UIImageView *InfoImage;
    UIImageView *topBarImage;
    UIImageView *bottomBarImage;
    UILabel *HeaderText;
    

    
    //Home Screen
    NSMutableDictionary* componentProperties;
    
    
    
    //Main Section
    UIView *MainSection;
    NSDictionary* mainSectionProperties ;
    NSMutableArray * MainSectionButtons;
    
    
    //App Bar Section
    UIView *AppBarSection;
    NSDictionary* appBarProperties;
    NSMutableArray * AppBarSectionButtons;
    IBOutlet UINavigationBar *HSNavigationBar;
    
    BOOL splashScreenShown;
    BOOL doShowSplashScreen;
    BOOL pageControlBeingUsed;
    
    NSMutableArray* buttonFrames;
}

// ***********************************
// STANDARD PROPERTIES

@property (strong, nonatomic) AppRenderer* appRenderer;
@property (strong, nonatomic)  NSMutableDictionary* ComponentProperties ;

@property (strong, nonatomic) NSString* ComponentInstanceID;
@property (strong, nonatomic) NSString* ComponentName;
@property (strong, nonatomic) NSString* clearallnavigation;
// ***********************************



//@property (strong,nonatomic) CXMLNode* componentNode ;
@property (strong, nonatomic) IBOutlet UIImageView *BackgroundImage;
@property (strong,nonatomic)  NSTimer *splashTimer;
@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl* pageControl;
@property (strong, nonatomic) IBOutlet UIImageView *AppBarBackgroundImage;

@property (nonatomic, retain) UIScrollView* appBarScrollView;

-(IBAction)changePage:(id)sender;
-(void)PageControllerSettings:(NSInteger)numberOfPages;



-(id)initWithAppRender:(AppRenderer*)_appRenderer;
// ***************************************************************************
// STANDARD  METHODS
//-(void) openComponentTemplate:(CXMLElement*)ComponentXMLNode;
-(void)setComponentProperties;
-(void)setNavigationBar; 

-(void)searchButtonClick;
//-(CGRect)frameForAppBar;

// SPECIFIC INTERNAL METHODS
//-(void)doParseComponentXML:(CXMLElement*) ComponentXML;
//-(void)setComponentPropertiesSection:(CXMLElement *) ComponentPropertiesSectionNode;


//-(void)setMainSection:(CXMLElement *) MainSectionNode;
//-(void)createMainSectionButtons:(NSMutableArray *)ButtonPropertiesArray;

//-(void)setAppBar:(CXMLElement *) AppBarNode;
-(void) createAppBarSectionButtons:(NSMutableArray *)ButtonPropertiesArray;

-(void)HandleOrientation:(UIInterfaceOrientation) toInterfaceOrientation;
-(void)addAppren:(NSObject*)obj;
@end
