#import "FlutterRtmpPublisherPlugin.h"
#import <UIKit/UIKit.h>
#import "LMLivePreview.h"
#import "UIControl+YYAdd.h"
#import "UIView+YYAdd.h"

@interface FlutterRtmpPublisherPlugin ()

@property(strong, nonatomic) UIViewController *viewController;
@property (nonatomic, strong) UIButton *cButton;
@property (nonatomic, retain) UIViewController *anotherViewController;

@end

@implementation FlutterRtmpPublisherPlugin {
    UIViewController *_viewController;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  FlutterMethodChannel *channel =
      [FlutterMethodChannel methodChannelWithName:@"rtmp_publisher"
                                  binaryMessenger:registrar.messenger];
  UIViewController *viewController =
      [UIApplication sharedApplication].delegate.window.rootViewController;
    
    
  FlutterRtmpPublisherPlugin *plugin =
      [[FlutterRtmpPublisherPlugin alloc] initWithViewController:viewController];
  [registrar addMethodCallDelegate:plugin channel:channel];
}
 

- (instancetype)initWithViewController:(UIViewController *)viewController {
  self = [super init];
  if (self) {
    self.viewController = viewController;
  }
  return self;
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
  NSString *url = call.arguments[@"url"];
  if ([@"stream" isEqualToString:call.method]) {
    _anotherViewController = [[UIViewController alloc] init];
    [self.viewController presentViewController:_anotherViewController animated:NO completion:nil];

      LMLivePreview *mainView = [[LMLivePreview alloc] initWithFrame:CGRectMake(0, 0, self.viewController.view.bounds.size.width, self.viewController.view.bounds.size.height)];
      
      mainView.streamUrl = url;
      mainView.viewC = self.viewController;
      _anotherViewController.view = mainView;
    result(@"null");
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end


