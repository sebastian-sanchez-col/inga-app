//
//  INGHomeCoordinator.m
//  inga-app
//

#import "INGHomeCoordinator.h"
#import "INGHomeViewModel.h"
#import "INGHomeViewController.h"
#import "INGCommunicationFeature.h"

@interface INGHomeCoordinator () <INGHomeViewModelCoordinatorDelegate>

@property (nonatomic, strong, readonly) UINavigationController *navigationController;
@property (nonatomic, strong, readonly) id<INGCommunicationFeatureProvider> featureProvider;

@end

@implementation INGHomeCoordinator

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController
                             featureProvider:(id<INGCommunicationFeatureProvider>)featureProvider {
    self = [super init];
    if (self) {
        _navigationController = navigationController;
        _featureProvider = featureProvider;
    }
    return self;
}

#pragma mark - INGCoordinator

- (void)start {
    INGHomeViewModel *viewModel = [[INGHomeViewModel alloc] initWithFeatureProvider:self.featureProvider];
    viewModel.coordinatorDelegate = self;

    INGHomeViewController *viewController = [[INGHomeViewController alloc] initWithViewModel:viewModel];
    [self.navigationController setViewControllers:@[viewController] animated:NO];
}

#pragma mark - INGHomeViewModelCoordinatorDelegate

- (void)homeViewModel:(INGHomeViewModel *)viewModel didSelectFeature:(INGCommunicationFeature *)feature {
    // Chat, Bulletins and News don't exist yet. Instead of a "dead" tap we
    // show an informative empty state. Once each module exists, its own
    // coordinator will be started here (e.g. INGChatCoordinator).
    [self.navigationController pushViewController:[self makeComingSoonViewControllerForFeature:feature]
                                         animated:YES];
}

#pragma mark - Factories

- (UIViewController *)makeComingSoonViewControllerForFeature:(INGCommunicationFeature *)feature {
    UIContentUnavailableConfiguration *configuration = [UIContentUnavailableConfiguration emptyConfiguration];
    configuration.image = [UIImage systemImageNamed:@"hourglass"];
    configuration.text = NSLocalizedString(@"comingSoon.title", @"Placeholder title for unavailable sections");
    configuration.secondaryText = NSLocalizedString(@"comingSoon.message", @"Placeholder message for unavailable sections");

    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.title = feature.title;
    viewController.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
    viewController.view.backgroundColor = UIColor.systemBackgroundColor;
    viewController.contentUnavailableConfiguration = configuration;
    return viewController;
}

@end
