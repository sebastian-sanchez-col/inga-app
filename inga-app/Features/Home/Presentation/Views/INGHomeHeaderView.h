//
//  INGHomeHeaderView.h
//  inga-app
//
//  Home header: a sentence explaining the purpose of the screen.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface INGHomeHeaderView : UICollectionReusableView

- (void)configureWithText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
