//
//  INGCommunicationFeature.h
//  inga-app
//
//  Domain entity: a communication feature available to the user.
//  Immutable and free of UIKit dependencies.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, INGCommunicationFeatureType) {
    INGCommunicationFeatureTypeChat,
    INGCommunicationFeatureTypeBulletins,
    INGCommunicationFeatureTypeNews,
};

@interface INGCommunicationFeature : NSObject

@property (nonatomic, assign, readonly) INGCommunicationFeatureType type;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *summary;

- (instancetype)initWithType:(INGCommunicationFeatureType)type
                       title:(NSString *)title
                     summary:(NSString *)summary NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
