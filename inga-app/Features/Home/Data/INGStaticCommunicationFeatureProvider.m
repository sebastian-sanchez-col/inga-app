//
//  INGStaticCommunicationFeatureProvider.m
//  inga-app
//

#import "INGStaticCommunicationFeatureProvider.h"
#import "INGCommunicationFeature.h"

@implementation INGStaticCommunicationFeatureProvider

- (NSArray<INGCommunicationFeature *> *)availableFeatures {
    // Chat goes first: it's the most frequently used action.
    return @[
        [[INGCommunicationFeature alloc] initWithType:INGCommunicationFeatureTypeChat
                                                title:NSLocalizedString(@"feature.chat.title", @"Chat feature title")
                                              summary:NSLocalizedString(@"feature.chat.summary", @"Chat feature description")],
        [[INGCommunicationFeature alloc] initWithType:INGCommunicationFeatureTypeBulletins
                                                title:NSLocalizedString(@"feature.bulletins.title", @"Bulletins feature title")
                                              summary:NSLocalizedString(@"feature.bulletins.summary", @"Bulletins feature description")],
        [[INGCommunicationFeature alloc] initWithType:INGCommunicationFeatureTypeNews
                                                title:NSLocalizedString(@"feature.news.title", @"News feature title")
                                              summary:NSLocalizedString(@"feature.news.summary", @"News feature description")],
    ];
}

@end
