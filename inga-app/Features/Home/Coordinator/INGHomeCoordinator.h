//
//  INGHomeCoordinator.h
//  inga-app
//
//  Builds the Home screen (assembles its dependencies) and decides where
//  to navigate when the user picks a feature.
//

#import <UIKit/UIKit.h>
#import "INGCoordinator.h"
#import "INGCommunicationFeatureProvider.h"

NS_ASSUME_NONNULL_BEGIN

@interface INGHomeCoordinator : NSObject <INGCoordinator>

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController
                             featureProvider:(id<INGCommunicationFeatureProvider>)featureProvider NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
