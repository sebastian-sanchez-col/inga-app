//
//  INGCoordinator.h
//  inga-app
//
//  Minimal Coordinator contract: encapsulates a navigation flow.
//  View controllers never decide where to navigate; they delegate that
//  responsibility (through their ViewModel) to the Coordinator that created them.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol INGCoordinator <NSObject>

/// Starts the flow by showing its initial screen.
- (void)start;

@end

NS_ASSUME_NONNULL_END
