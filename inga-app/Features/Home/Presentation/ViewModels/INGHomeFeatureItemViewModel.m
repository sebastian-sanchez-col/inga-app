//
//  INGHomeFeatureItemViewModel.m
//  inga-app
//

#import "INGHomeFeatureItemViewModel.h"
#import "INGCommunicationFeature.h"

@implementation INGHomeFeatureItemViewModel

- (instancetype)initWithFeature:(INGCommunicationFeature *)feature {
    self = [super init];
    if (self) {
        _feature = feature;
        _title = [feature.title copy];
        _summary = [feature.summary copy];
        _iconSystemName = [[self class] iconSystemNameForType:feature.type];
        _accentColorName = [[self class] accentColorNameForType:feature.type];
        // Title and summary in a single label: VoiceOver reads the whole card
        // content at once (users may have hints turned off).
        _accessibilityLabel = [NSString stringWithFormat:@"%@, %@", feature.title, feature.summary];
    }
    return self;
}

#pragma mark - Equality (stable identity for the diffable data source)

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    if (![object isKindOfClass:[INGHomeFeatureItemViewModel class]]) {
        return NO;
    }
    return self.feature.type == ((INGHomeFeatureItemViewModel *)object).feature.type;
}

- (NSUInteger)hash {
    return (NSUInteger)self.feature.type;
}

#pragma mark - Presentation mapping

+ (NSString *)iconSystemNameForType:(INGCommunicationFeatureType)type {
    switch (type) {
        case INGCommunicationFeatureTypeChat:
            return @"bubble.left.and.bubble.right.fill";
        case INGCommunicationFeatureTypeBulletins:
            return @"envelope.open.fill";
        case INGCommunicationFeatureTypeNews:
            return @"newspaper.fill";
    }
    return @"questionmark.circle.fill";
}

+ (NSString *)accentColorNameForType:(INGCommunicationFeatureType)type {
    switch (type) {
        case INGCommunicationFeatureTypeChat:
            return @"ChatAccent";
        case INGCommunicationFeatureTypeBulletins:
            return @"BulletinsAccent";
        case INGCommunicationFeatureTypeNews:
            return @"NewsAccent";
    }
    return @"AccentColor";
}

@end
