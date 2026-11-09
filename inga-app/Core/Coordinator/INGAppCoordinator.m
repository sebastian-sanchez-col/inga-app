//
//  INGAppCoordinator.m
//  inga-app
//

#import "INGAppCoordinator.h"
#import "INGHomeCoordinator.h"
#import "INGStaticCommunicationFeatureProvider.h"

NS_ASSUME_NONNULL_BEGIN

@interface INGAppCoordinator ()

@property (nonatomic, strong, readonly) UIWindow *window;
@property (nonatomic, strong, nullable) id<INGCoordinator> homeCoordinator;

@end

@implementation INGAppCoordinator

- (instancetype)initWithWindow:(UIWindow *)window {
    self = [super init];
    if (self) {
        _window = window;
    }
    return self;
}

- (void)start {
    UINavigationController *navigationController = [[UINavigationController alloc] init];
    navigationController.navigationBar.prefersLargeTitles = YES;

    INGHomeCoordinator *homeCoordinator =
        [[INGHomeCoordinator alloc] initWithNavigationController:navigationController
                                                 featureProvider:[[INGStaticCommunicationFeatureProvider alloc] init]];
    self.homeCoordinator = homeCoordinator;
    [homeCoordinator start];

    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
}

@end

NS_ASSUME_NONNULL_END
