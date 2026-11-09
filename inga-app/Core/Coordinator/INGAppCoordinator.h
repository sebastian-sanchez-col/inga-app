//
//  INGAppCoordinator.h
//  inga-app
//
//  Root coordinator and the app's composition root: the only place where
//  concrete implementations of dependencies are chosen.
//

#import <UIKit/UIKit.h>
#import "INGCoordinator.h"

NS_ASSUME_NONNULL_BEGIN

@interface INGAppCoordinator : NSObject <INGCoordinator>

- (instancetype)initWithWindow:(UIWindow *)window NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
