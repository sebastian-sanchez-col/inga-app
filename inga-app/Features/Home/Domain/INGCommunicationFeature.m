//
//  INGCommunicationFeature.m
//  inga-app
//

#import "INGCommunicationFeature.h"

@implementation INGCommunicationFeature

- (instancetype)initWithType:(INGCommunicationFeatureType)type
                       title:(NSString *)title
                     summary:(NSString *)summary {
    self = [super init];
    if (self) {
        _type = type;
        _title = [title copy];
        _summary = [summary copy];
    }
    return self;
}

@end
