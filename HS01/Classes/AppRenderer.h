//
//  AppRenderer.h
//  HS01
//
//  Created by Poornima on 05/04/18.
//

#import <Foundation/Foundation.h>

@interface AppRenderer : NSObject
{
    UINavigationController* customMblurbNavControl;
    NSMutableArray *mblurbListArray;
    NSString* temComponentInstID;
    NSString* MA11ImageSaveKey;
    //int MaxRandomCount = 10;
    
}

typedef void (^UserActivityCallBack)(NSMutableDictionary* dicObj,NSMutableArray* arrayObj);
typedef void (^AlertActionCallback)(NSString *title, int tag);


-(id)initWithNavigationController:(UINavigationController*)_navigationController bookID:(NSString*)_appID;
-(id)initWithBookID:(NSString*)_appID;
-(id)initWithShelfID:(NSString*)shelfId;

-(void)openBook;
-(UIViewController*)loadViewController;



- (NSData *)requestSynchronousData:(NSURLRequest *)request;


@property(nonatomic,strong)UINavigationController* navigationController;
@property(nonatomic,strong)NSString* appID;
//@property(nonatomic,strong)AppXmlParser* AppXMLParser;
@property(nonatomic, strong) NSMutableDictionary* headerBackgrounds;
@property(nonatomic,strong) UIViewController* currentViewController;
@property(nonatomic,strong) UIViewController* settingViewController;

//-- To get the book properties --
@property(nonatomic,strong)NSString *bookName;
@property(nonatomic,strong)NSString *bookVersion;
@property(nonatomic,strong)NSString *bookFlurryAPIKey;
@property(nonatomic,strong)NSString *bookChecksum;

//-- To get the default header properties --
@property(nonatomic,strong)NSString *defaultHeaderText;
@property(nonatomic,strong)NSString *defaultHeaderBackground;
@property(nonatomic,strong)NSString *defaultHeaderTextColor;
@property(nonatomic,strong)NSString *showHeaderText;
@property(nonatomic,strong)NSString *defaultBgImage;
@property(nonatomic,strong)NSString *defaultButtonTextColor;
@property(nonatomic,strong)NSString *defaultFooterBackground;
@property(nonatomic,strong)NSString *defaultMainSectionCaptionBackground;
@property(nonatomic, strong) NSMutableDictionary* globalProperties;
@property(nonatomic, strong) UIImageView *headerShadowView;

//@property(nonatomic,strong) Reachability* reachability;
@property(nonatomic,strong) NSString *deviceSecureUDID;
@property(nonatomic,strong) NSString *accessToken;
@property(nonatomic,readwrite) NSInteger isStatsAccountAccessToken;

@property(nonatomic,strong) NSString* fromMG01;
//@property (nonatomic, retain) ShareModules *shareModules;

//--- TitleItems Downloading ----
@property(nonatomic,strong)NSMutableArray* downloadingItems;

//-- Book Shelf common properies --
//@property (strong, nonatomic) NSMutableDictionary* PapyrusBooksGroups;
@property (strong, nonatomic) NSMutableDictionary* PapyrusTitles;
@property (strong, nonatomic) NSMutableArray* PapyrusFilterTags;
@property (strong, nonatomic) NSMutableArray* ShelfMenuBlurImages;
@property (nonatomic,strong) NSString* shelfID;
@property (nonatomic,strong) NSString* defaultShelfID;
@property (nonatomic,strong) NSString* shelfName;
@property (nonatomic,strong) NSMutableArray* shelvesArray;
//@property (strong, nonatomic) NSMutableArray* shelfRowCacheObj;
@property (strong, nonatomic) NSArray* PapyrusBookGroupsKeys;
@property (strong, nonatomic) NSArray* PapyrusTitleKeys;
//@property(nonatomic,strong) SqlExtraDatabase *extraDatabase;
@property(nonatomic,strong) NSString *globalKeyValue;
@property(nonatomic, strong) NSDictionary* globalGetVariables;
@property(nonatomic,strong) NSString *globalFileKeyValue;
@property(nonatomic, strong) NSDictionary* globalFileVariables;
@property (strong, nonatomic) NSMutableArray* downloadingTitles;
//@property (strong, nonatomic) AFHTTPRequestOperation* downloadOperation;
@property(nonatomic,strong) dispatch_queue_t queue;
@property(nonatomic,strong) dispatch_group_t group;
@property(nonatomic,strong) NSMutableArray* arrayMG03DownloadComplete;
@property(nonatomic,strong) NSString* ma06CompID;
@property(nonatomic,strong) NSString* shelfAppId;
@property(nonatomic,strong) NSString* logOutSkipEmailId;
@property(nonatomic,readwrite) BOOL logOutSkipUserExists;
@property(nonatomic,assign)int homeScreen;
@property(nonatomic,assign)BOOL showSignUp;
@property(nonatomic,assign)BOOL enableLastRead;
@property(nonatomic,assign)BOOL isDeepLink;
@property(nonatomic,assign)BOOL isEnabledInAppPurchase;
@property(nonatomic,assign)BOOL isEnableShelfSwitch;
@property(nonatomic,assign)BOOL isEnableSubscription;
@property(nonatomic,assign)BOOL ShelfOnlineMode;
@property(nonatomic,assign)BOOL showLastReadMsg;
@property(nonatomic,assign)BOOL shelfAutoSwitch;
@property(nonatomic,assign)BOOL isEnabledCategory;
@property(nonatomic,assign)BOOL isEnabledRedeem;
@property(nonatomic,assign)BOOL isEnableSearch;
@property(nonatomic,assign)BOOL isEnableMBlurb;
@property(nonatomic,assign)BOOL isEnabledUserTracking;
@property(nonatomic,assign)BOOL includeParse;
@property(nonatomic,strong)NSString* sampleMoreOption;
@property(nonatomic,strong)NSString* eBookShareText;
@property(nonatomic,strong)NSString* StartUpTitle;
@property(nonatomic,assign)BOOL isEnableeBook;
@property(nonatomic,assign)BOOL isEnableAudioTitle;
@property(nonatomic,assign)BOOL isEnabledInteractiveApps;
@property(nonatomic,assign)BOOL isEnabledSCInAppPurchase;
@property(nonatomic,strong)NSString* newsLetterTitle;
@property(nonatomic,strong)NSString* newsletterSignupText;
@property(nonatomic,assign)BOOL isEnableNewsLetterSignup;
@property(nonatomic,assign)BOOL storeNavBarTransparent;
@property(nonatomic,assign)BOOL showRecentActivity;
@property(strong,nonatomic) NSArray* purchaseCountries;
@property (strong, nonatomic) NSDictionary* AutoClickDict;
////////////in app purchase products///////////////
@property(nonatomic,strong) NSArray *_IAProducts;
@property(nonatomic,strong) NSArray *_IASubscriptionProducts;
///////////////////////////////////////////////////



//-- To get the default header properties --
@property(nonatomic,strong)NSString *appNavBarLogo;
@property(nonatomic,strong)NSString *appNavBarLandscapeBackground;
@property(nonatomic,strong)NSString *appNavBarPortraitBackground;
@property(nonatomic,strong)NSString *showBgImage;
@property(nonatomic,strong)NSString *shelfBackground;
@property(nonatomic,strong)NSString *shelfColor;
@property(nonatomic,strong)NSString *aboutContent;
@property(nonatomic,assign)int showLogin;
@property(nonatomic,strong)NSString *showLoginCancel;
@property(nonatomic,strong)NSString *showLoginSkip;
@property(nonatomic,strong)NSString *loginScreenBackground;
@property(nonatomic,strong)NSString *visiblePriceView;
@property(nonatomic,strong)NSString *showPapertrellBrand;
@property(nonatomic,strong)NSString* shelfHeaderTextColor;
@property(nonatomic,strong)NSString* languageCode;
@property(nonatomic,strong)NSString* titleClickAction;
@property(nonatomic,strong)NSString* bannerClickAction;
//@property(nonatomic,strong) MBlurbViewController *mblurbVC;
//@property(nonatomic,strong) UserActivityView* uAview;
@property (strong, nonatomic) NSMutableDictionary* userActivityTitles;
@property (strong, nonatomic) NSString* iapSCkey;
//End
@property(nonatomic,strong) NSString *isFavorite;


@property (nonatomic, readwrite) BOOL didUserCommented;
@property (nonatomic, readwrite) BOOL didUserLiked;
@property (nonatomic, readwrite) BOOL didUserLoved;

@property (assign, nonatomic) BOOL isAppXMLFile;
//@property (nonatomic, strong) AVAudioPlayer *MG03OutSidePlayer;
//@property (strong, nonatomic) NSString* MG03_Audio_Key;
// ----- MA11
@property (nonatomic, strong) UIImagePickerController *imgPicker;
@property(nonatomic,assign)BOOL doReloadLockItems;

-(void)setDefaultHeaderProperties;
-(void)setNavigationHeaderBar:(UINavigationController *)navController orientation:(UIInterfaceOrientation)orientation;
//------------------------------------------

-(NSString*) getBookRootPath ;
-(NSString*)getBookUserDataPath;
-(NSString*)getBookPath;
-(NSString*)getBookPath:(NSString*)relativeFilepath;
-(NSString*) getBookRootPath:(NSString*) relativeFilepath;
-(NSString*) getBookTitlePath : (NSString*) titleID forChecksum: (NSString*) checkSum;
-(NSString*) getTitleExtrasPath:(NSString*) relativeFilepath;
-(void)setNavigationHeaderBar:(NSMutableDictionary*)componentProperties navController:(UINavigationController *)navController orientation:(UIInterfaceOrientation)orientation;
-(void)setShelfNavigationHeaderBar:(UINavigationController *)navController navigationItem:(UINavigationItem *)navItem orientation:(UIInterfaceOrientation)orientation;

-(void)removeCustomNavigationBar :(UINavigationController *)navController;
-(void) goToContentComponent:(NSString*)contextKey shouldSwitch:(BOOL) isSwitch;

//-(void) goToComponent:(CXMLElement*)ComponentXMLNode shouldSwitch:(BOOL) isSwitch;
//-(void) goToComponent:(CXMLElement*)ComponentXMLNode path:(NSString*)filePath selector:(NSString*)selectorPath shouldSwitch:(BOOL) isSwitch;
//-(void) goToComponent:(CXMLElement*)ComponentXMLNode startParameters:(NSDictionary*)startParameters shouldSwitch:(BOOL) isSwitch;
//-(void) goToComponent:(CXMLElement*)ComponentXMLNode startParameters:(NSDictionary*)startParameters isStructuredContent:(BOOL)isStructuredContent shouldSwitch:(BOOL) isSwitch;
//-(void) goToComponent:(CXMLElement*)componentXMLNode params:(NSString*)stringParams highlightText:(NSString*)highlight selectorText:(NSString*)selector shouldSwitch:(BOOL) isSwitch;
//-(void) goToComponent:(CXMLElement*)componentXMLNode parameters:(NSDictionary*)parameters highlightText:(NSString*)highlight selectorText:(NSString*)selector shouldSwitch:(BOOL) isSwitch;
-(void) goToLastSeen;
//-(void) executeInComponent:(CXMLElement*)ComponentXMLNode startParameters:(NSDictionary*)startParameters;
-(void)setDefaultCustomShelfProperties;
-(void)setShelfPropertiesFromApi;
//- (void)LogAnalyticsforLoad:(CXMLElement *)node;
- (void)LogAnalytics:(NSDictionary*)parameters;
- (BOOL)reachable;
- (BOOL)internalLinksSelection:(NSURLRequest*)theRequest;
-(void)clearTitleDefaultProperties;

-(void)openHSPopUp :(NSMutableDictionary*) componentProperties;
//***************************** Mblurb Internal link **********************************************/
-(void)mblurbInternalLink:(NSURL*)url navController:(UINavigationController*)navContrl pageTitle:(NSString*)title;
//************************************************************************************************/

-(NSString*) getSecureUDID;
- (BOOL)validateUrl: (NSString *) url;
-(BOOL)isValidEmail:(NSString*)Email;
-(BOOL)isHolderApp;
-(BOOL)isCustomBookShelfApp;
-(void)setStatsAccessToken;
-(BOOL)IsNetworkAvailable;
-(NSMutableDictionary*)createHtmlFilesForStructuredContent:(NSString*)templatePath DataSrc:(NSString*)datasrc uniqueID:(NSString*)_contextKey isStructuredContent:(NSString*)isSC pageTitle:(NSString*)caption dataID:(NSString*)_dataID;
-(NSDictionary *)parseQueryString:(NSString *)query;
-(NSDictionary*)getElementsForStructureContent:(NSString*)params objectCount:(int)total;
//-(BOOL)isStaging;
//-(BOOL)isDevelopmentServer;
-(void)createFoldersIfNotFound:(NSString*)BookAppFolder;
-(NSString*)getFilePath:(NSString*)file;

-(NSDictionary*)getValuesFromDB:(NSString*)key;
-(NSDictionary*)ServerURLs :(NSString*)serviceUrl ;
-(void)insertIntoExtrasDB:(NSDictionary*)globalvariables;
-(NSString*)customFontPath:(NSString*)path;
-(void)clearGlobalVariableTable:(NSDictionary*)globalvariables;
-(void)setAutoClick:(NSDictionary*)dict;

#pragma mark Custom Shelf Common Methods
-(NSString*)getBookShelfRootPath;
-(NSMutableDictionary*) LoadfromDB;
-(NSString*)getBookShelfRootPath:(NSString*) relativeFilepath;
-(NSString*)getBookShelfPath:(NSString*) relativeFilepath ;
-(NSString*)getBookShelfPath;
-(BOOL)isXmlExists :(NSString*)filePath;
-(BOOL)isFileExists :(NSString*)filePath;
//-(BOOL)isValidXML :(CXMLDocument *)XMLDoc;
-(void)WiteXmlResponseToFile:(NSData*)_xmlData FilePath:(NSString*)filepath FileName:(NSString*)file;
-(NSString*)getIconName:(NSString*)iconName HeaderTextColor:(UIColor*)color;
-(NSString*)getIconName:(NSString*)iconName IsLightColor:(BOOL)isLight;
-(NSString*)getIconName:(NSString*)iconName HeaderTextColorWithHexaString:(NSString*)colorString;
-(NSString*)getIconNameByBgImage:(NSString*)iconName HeaderTextColor:(UIColor*)color;
-(void)parseShelvesXml:(NSData*)_xmlData OverWrite:(BOOL)overWrite;
-(NSArray*)parseShelfSettingXml:(NSData*)_xmlData;
-(NSString*)getTitleImageCDNUrlWithSize:(NSString*)URLString;
-(NSString*)getTitleImageUrlWithSize:(NSString*)URLString;
+(NSString*)getShelfLogoImageUrlWithSize:(NSString*)URLString;
+(NSString*)getBannerImageUrlWithSize:(NSString*)URLString IsBackground:(BOOL)isBackground;
-(void)openTitleDetail:(NSMutableDictionary *)titleObject;
-(void)openTitle:(NSString *)titleID;
-(void)setPreTitleDownloadStatus:(NSMutableDictionary*)values  TitleId:(NSString *)titleID;
-(void)clearPreTitleDownloadStatus:(NSString *)titleID;
+(NSString*)getTier:(NSString*)Identifier ShelfID:(NSString*) currentShelfID;
-(BOOL)isHSButtonAvailable :(NSDictionary*)dict currentTitleId:(NSString*)currentTitleId;
-(NSString*)saveLocationImageToUserData:(NSString*)componentInstID;
//-(void)parseRootCategoryXml:(NSData*)_xmlData;
#pragma mark Skyepub Common Methods

//-(BOOL)installEPub:(NSString*)filePath;

#pragma mark - Setting Methods

+(void)setUserTracking:(BOOL)trackingStartus;
+(BOOL)isSetUserTracking;
+(void)setTrackingUserId:(NSString*)userId;
+(NSString*)getTrackingUserId;
#pragma mark - Alert

-(void)showErrorDropDownMessage :(NSString*)messageTitle mesage:(NSString*)messageText;
-(void)showWarningDropDownMessage :(NSString*)messageTitle mesage:(NSString*)messageText;
-(void)showSuccessDropDownMessage :(NSString*)messageTitle mesage:(NSString*)messageText;

#define Shelf
-(void)setShelfAccessTokenFromDB :(NSString*)shelfID;
-(void)createShelfMenuBlurImage;
-(BOOL)isLoggedIn;
-(BOOL)isSkipUser;
-(void)removeSkipUser;
+(BOOL)isValidUserLoggedIn;
-(NSString*)getUserDiaplayName;
-(void)previousLoggedInUser:(NSString*)currentEmailID;
-(void)clearAccessToken;
-(void)loadAboutFromCache;
//-(NSDictionary*)globalSettingsServerURLs;
-(BOOL)isglobalSettingsXmlExists;
-(void)saveXmlLocal :(NSData*)_xmlData;
-(NSMutableDictionary*)parseXmlforGlobalSettings:(NSData*)_xmlData;
-(void)deleteFailureDownloads;
-(void)RegisterPushNotification :(NSString*)deviceToken;
+(void)setStoreExpire;
-(BOOL)isReachableAlertExpired;
-(void)setNextExpireTime;
-(void)setReachableAlertExpired;
-(BOOL)isServerChange;
-(BOOL)ConnectivityWithView:(UIView*)mainView;
-(void)setStoreExpireForIAP;
-(void)setIAPOverlayFrame:(UIInterfaceOrientation) toInterfaceOrientation;
-(NSMutableDictionary*)getQueryParameters:(NSURLRequest*)req;
-(NSString*)getLowestConsumableIdentifier;
-(NSString*)getRoundConsumableIdentifier:(NSString*)titlePrice;
-(NSString*)getConsumableIdentifierByPrice:(NSString*)princeString;
-(int)getConsumableProductCredits:(NSString*)titlePrice;
-(NSMutableArray*)addConsumableIdentifier:(NSMutableArray*)products;
-(NSMutableArray*)addSubscriptionIdentifier:(NSMutableArray*)products;
-(void) pushView: (UIViewController*) control;
-(void)doPushNotification;
//-(void)createUserAction:(MBlurb*)mblurb dictParam:(NSMutableDictionary *)typedict;
//-(void)mblurbstats:(MBlurb*)mblurb contextParam:(NSString*)key dictParam:(NSString *)type web:(UIWebView *)webview callbackFunc:(NSString *)callbackparam;
-(void)updateTitleFolders;
//SAS Custom Code. need to remove from Papertrell holder
-(NSMutableDictionary*)getChapterInstanceID;
-(BOOL)checkDBRestore :(NSString*)titleID TableName:(NSString*)tableName;
-(void)setDBRestore :(NSString*)titleID TableName:(NSString*)tableName;
-(NSString*) getSASDBRootPath;

//Internal Link
//-(void)ProcessWebViewRequest:(NSURL*) url Mblurb:(MBlurb*) mblurbObj contextKey:(NSString*) contextKey webView:(UIWebView*) webview currentPage:(NSInteger) currPage;
//-(void)ProcessNavigationUrls:(NSURL*) url Mblurb:(MBlurb*) mblurbObj contextKey:(NSString*) contextKey webView:(UIWebView*) webview currentPage:(NSInteger) currPage;
//-(void)ProcessNavigationUrls:(NSURL*) url Mblurb:(MBlurb*) mblurbObj contextKey:(NSString*) contextKey webView:(UIWebView*) webview currentPage:(NSInteger) currPage isSkipUpdate:(BOOL)skipUpdate;
+(NSString*)getUrlWithExtraParameters :(NSMutableDictionary*)extraParams Url:(NSString*)urlValue;

#pragma mark - IAP

+(void)doTrasactionLog:(NSString*)titleId EventType :(NSString*)eventType EventDetails :(NSString*)eventDetails;
//+(void)saveCompleteTransaction :(SKPaymentTransaction *)transaction ResponseString:(NSString*)responseString OverWriteObject:(BOOL)overWriteObject;
//+(void)saveCompleteTransaction :(SKPaymentTransaction *)transaction
//                 ResponseString:(NSString*)responseString
//                OverWriteObject:(BOOL)overWriteObject
//               IsVerifyPurchase:(BOOL)isVerifyPurchase;
+(NSMutableDictionary*)getsavedCompleteTransaction;

//Oreintation Change for component based on users preferance
-(UIInterfaceOrientation) getSuportedOrientation: (NSString*) forcedOrientProp;
-(void) forceOrientationToView:(NSString*) forcedOrienProp;
-(BOOL) shouldAutoRotateView : (NSString*) forcedOrientProp;

-(NSDictionary*)getPicPropertiesFromDB:(NSString*)key;
-(void)insertPicPropertiesIntoExtrasDB:(NSDictionary*)globalvariables;
-(void)updateCaption:(NSString*)captionText ContextKeyId:(NSString*)contextKeyId;
-(void)clearPicTable:(NSString *)origImage;
-(void)clearAllPicTable;
-(BOOL)createPicTable;
-(NSMutableArray *)LoadPics;
-(NSMutableArray *)LoadPics:(NSString *)g;
-(NSString *)loadImagePath:(NSString*)key;
+(NSString*)getJsonStringByDictionary:(NSDictionary*)dictionary;
+(NSDictionary*)getDictionaryStringByString:(NSString*)stringValue;

//Last Seen Feature
-(void) createLastSeenIfNotExist :(NSString*) titleId;
-(void) updateLastSeenWithContextKey: (NSString*) contextKey forAppWithId:(NSString*) titleId;
-(void) updateLastSeenWithComponent: (NSString*) componentInstaceId forAppWithId:(NSString*) titleId;
-(void) updateEpubSettingWithComponentID:(NSString*) componentID andTitleSrc:(NSString*) titleSrc forAppWithId:(NSString*) titleId;
-(void) deleteLastSeenSettings:(NSString*) settingKey forAppWithId:(NSString*) titleId;
-(void) deleteLastSeenSettings:(NSString*) settingKey forAppWithId:(NSString*) titleId clearAll:(BOOL)isClearAll;
-(void) removeShadowImage;
-(void) loadBackStackAppXML;
-(void) onlyCreateLastSeenIfNotExist:(NSString*) titleId;
-(void)openUserActivityView:(NSMutableDictionary*)activityResposeData titleOrder:(NSMutableArray*)titleOrder;
-(void) closeUserActivityView;
-(void)getUserActivityData :(void(^)(NSMutableDictionary* response,NSMutableArray* arrayOrderObj))callBack;
//
-(NSString*) getAppXml;
//-(void)getFilterCategories:(NSString *)catID;

//Easy Shelf Switchimg
-(void) setSwitchShelfID:(NSString *)switchShelfID andShelfName:(NSString*)shelfName;
-(NSString*) getSwitchShelfID;

-(void) navigateToBook:(NSURL*) url;
-(void) processImageZoom: (NSMutableDictionary*) querydic;
-(void) processBookmark: (NSURL*) url contextKey: (NSString*)contextKey urlQuery :(NSMutableDictionary*) dict webView:(UIWebView*) webview;
//-(void) processMblurbRequest: (NSURL*) url contextKey: (NSString*)contextKey urlQuery :(NSMutableDictionary*) dict mblurb:(MBlurb *) MBlurbObj webView:(UIWebView*) webview currentPg:(NSInteger)currPg;
+(NSString*)getTitleId:(NSString*) urlAppId;
+ (void)logIt:(NSString *)string;
+(BOOL)isLockMA12Items;
+(NSString*)getUIActivityStringValye:(NSString*)type;
-(void)setLibraryLastSelection:(NSString*)lastSelection;
-(NSString*)getLibraryLastSelection;
-(void)ShowActivityIndicator;
-(void)HideActivityIndicator;

//functions added by kanagu
-(CGRect ) getSizeFromString:(NSString *)str withSize:(CGSize )size attributes:(NSDictionary *)attributes;
-(NSMutableParagraphStyle *) getParagraphStyleWithLineBreakMode :(NSLineBreakMode ) lineBreakMode;
-(BOOL )isObjectValid:(id )obj;
+(UIAlertController *) doAlertwithActions:(NSArray *)actionTitles cancelAction:(NSString *)cancel withTitle:(NSString *)title withMessage:(NSString *)msg withTag:(int) tag handler:(AlertActionCallback )handler;
+(UIAlertController *) doAlertwithActions:(NSArray *)actionTitles cancelAction:(NSString *)cancel withTitle:(NSString *)title withMessage:(NSString *)msg withTag:(int) tag withPresentController:(UIViewController *)controller  handler:(AlertActionCallback )handler;

@end
