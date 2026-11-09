//
//  INGHomeViewModel.m
//  inga-app
//

#import "INGHomeViewModel.h"
#import "INGHomeFeatureItemViewModel.h"
#import "INGCommunicationFeature.h"

@implementation INGHomeViewModel

- (instancetype)initWithFeatureProvider:(id<INGCommunicationFeatureProvider>)featureProvider {
    self = [super init];
    if (self) {
        _title = NSLocalizedString(@"home.title", @"Home screen title");
        _subtitle = NSLocalizedString(@"home.subtitle", @"Home screen subtitle");

        NSArray<INGCommunicationFeature *> *features = [featureProvider availableFeatures];
        NSMutableArray<INGHomeFeatureItemViewModel *> *items = [NSMutableArray arrayWithCapacity:features.count];
        for (INGCommunicationFeature *feature in features) {
            [items addObject:[[INGHomeFeatureItemViewModel alloc] initWithFeature:feature]];
        }
        _items = [items copy];
    }
    return self;
}

- (void)selectItem:(INGHomeFeatureItemViewModel *)item {
    [self.coordinatorDelegate homeViewModel:self didSelectFeature:item.feature];
}

@end
