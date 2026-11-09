//
//  INGHomeViewModel.h
//  inga-app
//
//  State and presentation logic for the Home screen. It knows nothing about
//  UIKit or concrete navigation: it forwards user intents to its
//  coordinatorDelegate.
//

#import <Foundation/Foundation.h>
#import "INGCommunicationFeatureProvider.h"

@class INGHomeViewModel;
@class INGHomeFeatureItemViewModel;
@class INGCommunicationFeature;

NS_ASSUME_NONNULL_BEGIN

@protocol INGHomeViewModelCoordinatorDelegate <NSObject>

- (void)homeViewModel:(INGHomeViewModel *)viewModel didSelectFeature:(INGCommunicationFeature *)feature;

@end

@interface INGHomeViewModel : NSObject

@property (nonatomic, weak, nullable) id<INGHomeViewModelCoordinatorDelegate> coordinatorDelegate;

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *subtitle;
@property (nonatomic, copy, readonly) NSArray<INGHomeFeatureItemViewModel *> *items;

- (instancetype)initWithFeatureProvider:(id<INGCommunicationFeatureProvider>)featureProvider NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/// User intent: open the feature represented by `item`.
- (void)selectItem:(INGHomeFeatureItemViewModel *)item;

@end

NS_ASSUME_NONNULL_END
