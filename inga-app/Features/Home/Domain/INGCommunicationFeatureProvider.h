//
//  INGCommunicationFeatureProvider.h
//  inga-app
//
//  Abstraction (port) the presentation layer depends on to know which
//  communication features to offer. It allows changing the data source
//  (static, remote config, backend...) without touching the Home screen,
//  and replacing it with a test double (Dependency Inversion).
//

#import <Foundation/Foundation.h>

@class INGCommunicationFeature;

NS_ASSUME_NONNULL_BEGIN

@protocol INGCommunicationFeatureProvider <NSObject>

/// Available features, in the order they should be displayed.
- (NSArray<INGCommunicationFeature *> *)availableFeatures;

@end

NS_ASSUME_NONNULL_END
