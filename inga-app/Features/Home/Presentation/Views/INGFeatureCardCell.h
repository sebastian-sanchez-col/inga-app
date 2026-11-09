//
//  INGFeatureCardCell.h
//  inga-app
//
//  Tappable card representing a communication feature.
//

#import <UIKit/UIKit.h>

@class INGHomeFeatureItemViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface INGFeatureCardCell : UICollectionViewCell

- (void)configureWithItem:(INGHomeFeatureItemViewModel *)item;

@end

NS_ASSUME_NONNULL_END
