//
//  INGHomeViewController.h
//  inga-app
//
//  "Passive" view: renders what the ViewModel provides and forwards user
//  interactions to it. Contains no business logic or navigation.
//

#import <UIKit/UIKit.h>

@class INGHomeViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface INGHomeViewController : UIViewController

- (instancetype)initWithViewModel:(INGHomeViewModel *)viewModel;

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
