//
//  INGHomeFeatureItemViewModel.h
//  inga-app
//
//  Display-ready data for rendering a feature card.
//  Foundation only: colors are exposed as asset names so the ViewModel
//  stays testable without UIKit.
//

#import <Foundation/Foundation.h>

@class INGCommunicationFeature;

NS_ASSUME_NONNULL_BEGIN

@interface INGHomeFeatureItemViewModel : NSObject

@property (nonatomic, strong, readonly) INGCommunicationFeature *feature;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *summary;
@property (nonatomic, copy, readonly) NSString *iconSystemName;
@property (nonatomic, copy, readonly) NSString *accentColorName;
@property (nonatomic, copy, readonly) NSString *accessibilityLabel;

- (instancetype)initWithFeature:(INGCommunicationFeature *)feature NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
