//
//  INGFeatureCardCell.m
//  inga-app
//

#import "INGFeatureCardCell.h"
#import "INGHomeFeatureItemViewModel.h"

static const CGFloat INGCardCornerRadius = 16.0;
static const CGFloat INGCardPadding = 16.0;
static const CGFloat INGCardSpacing = 16.0;
static const CGFloat INGIconContainerSize = 48.0;
static const CGFloat INGIconContainerCornerRadius = 12.0;
static const CGFloat INGIconBackgroundAlpha = 0.15;
static const CGFloat INGHighlightScale = 0.97;
static const NSTimeInterval INGHighlightAnimationDuration = 0.2;

@interface INGFeatureCardCell ()

@property (nonatomic, strong) UIStackView *contentStackView;
@property (nonatomic, strong) UIView *iconContainerView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *summaryLabel;
@property (nonatomic, strong) UIImageView *chevronImageView;

@end

@implementation INGFeatureCardCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpAppearance];
        [self setUpViewHierarchy];
        [self setUpConstraints];
        [self setUpAccessibility];
        [self registerForTraitChanges:@[UITraitPreferredContentSizeCategory.class]
                           withAction:@selector(updateLayoutForContentSizeCategory)];
        [self updateLayoutForContentSizeCategory];
    }
    return self;
}

#pragma mark - Public

- (void)configureWithItem:(INGHomeFeatureItemViewModel *)item {
    UIColor *accentColor = [UIColor colorNamed:item.accentColorName] ?: self.tintColor;

    self.iconImageView.image = [UIImage systemImageNamed:item.iconSystemName];
    self.iconImageView.tintColor = accentColor;
    self.iconContainerView.backgroundColor = [accentColor colorWithAlphaComponent:INGIconBackgroundAlpha];
    self.titleLabel.text = item.title;
    self.summaryLabel.text = item.summary;
    self.accessibilityLabel = item.accessibilityLabel;
}

#pragma mark - Touch feedback

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];

    BOOL shouldScale = highlighted && !UIAccessibilityIsReduceMotionEnabled();
    CGAffineTransform transform = shouldScale
        ? CGAffineTransformMakeScale(INGHighlightScale, INGHighlightScale)
        : CGAffineTransformIdentity;
    UIColor *backgroundColor = highlighted
        ? UIColor.tertiarySystemGroupedBackgroundColor
        : UIColor.secondarySystemGroupedBackgroundColor;

    [UIView animateWithDuration:INGHighlightAnimationDuration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
        self.contentView.transform = transform;
        self.contentView.backgroundColor = backgroundColor;
    }
                     completion:nil];
}

#pragma mark - Dynamic Type

/// At accessibility text sizes, stack vertically so the text gets the
/// full width and isn't truncated.
- (void)updateLayoutForContentSizeCategory {
    BOOL isAccessibilitySize = UIContentSizeCategoryIsAccessibilityCategory(self.traitCollection.preferredContentSizeCategory);
    self.contentStackView.axis = isAccessibilitySize ? UILayoutConstraintAxisVertical : UILayoutConstraintAxisHorizontal;
    self.contentStackView.alignment = isAccessibilitySize ? UIStackViewAlignmentLeading : UIStackViewAlignmentCenter;
    self.chevronImageView.hidden = isAccessibilitySize;
}

#pragma mark - Setup

- (void)setUpAppearance {
    self.contentView.backgroundColor = UIColor.secondarySystemGroupedBackgroundColor;
    self.contentView.layer.cornerRadius = INGCardCornerRadius;
    self.contentView.layer.cornerCurve = kCACornerCurveContinuous;
    self.contentView.layer.masksToBounds = YES;
}

- (void)setUpViewHierarchy {
    self.iconImageView = [[UIImageView alloc] init];
    self.iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.iconImageView.contentMode = UIViewContentModeCenter;
    self.iconImageView.preferredSymbolConfiguration =
        [UIImageSymbolConfiguration configurationWithTextStyle:UIFontTextStyleTitle2];

    self.iconContainerView = [[UIView alloc] init];
    self.iconContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.iconContainerView.layer.cornerRadius = INGIconContainerCornerRadius;
    self.iconContainerView.layer.cornerCurve = kCACornerCurveContinuous;
    [self.iconContainerView addSubview:self.iconImageView];

    self.titleLabel = [self makeLabelWithTextStyle:UIFontTextStyleHeadline color:UIColor.labelColor];
    self.summaryLabel = [self makeLabelWithTextStyle:UIFontTextStyleSubheadline color:UIColor.secondaryLabelColor];

    UIStackView *textStackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.titleLabel, self.summaryLabel]];
    textStackView.axis = UILayoutConstraintAxisVertical;
    textStackView.spacing = 4.0;
    [textStackView setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];

    UIImageSymbolConfiguration *chevronConfiguration =
        [[UIImageSymbolConfiguration configurationWithTextStyle:UIFontTextStyleFootnote]
            configurationByApplyingConfiguration:[UIImageSymbolConfiguration configurationWithWeight:UIImageSymbolWeightSemibold]];
    // "forward" automatically flips for right-to-left languages.
    self.chevronImageView = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"chevron.forward"
                                                                       withConfiguration:chevronConfiguration]];
    self.chevronImageView.tintColor = UIColor.tertiaryLabelColor;
    [self.chevronImageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.chevronImageView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

    self.contentStackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.iconContainerView, textStackView, self.chevronImageView]];
    self.contentStackView.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentStackView.spacing = INGCardSpacing;
    [self.contentView addSubview:self.contentStackView];
}

- (void)setUpConstraints {
    // Bottom constraint below required priority to avoid conflicts while
    // the cell self-sizes from its estimated height.
    NSLayoutConstraint *bottomConstraint =
        [self.contentStackView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-INGCardPadding];
    bottomConstraint.priority = UILayoutPriorityRequired - 1;

    [NSLayoutConstraint activateConstraints:@[
        [self.contentStackView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:INGCardPadding],
        [self.contentStackView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:INGCardPadding],
        [self.contentStackView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-INGCardPadding],
        bottomConstraint,

        [self.iconContainerView.widthAnchor constraintEqualToConstant:INGIconContainerSize],
        [self.iconContainerView.heightAnchor constraintEqualToConstant:INGIconContainerSize],
        [self.iconImageView.centerXAnchor constraintEqualToAnchor:self.iconContainerView.centerXAnchor],
        [self.iconImageView.centerYAnchor constraintEqualToAnchor:self.iconContainerView.centerYAnchor],
    ]];
}

- (void)setUpAccessibility {
    // The whole card is a single actionable element for VoiceOver.
    self.isAccessibilityElement = YES;
    self.accessibilityTraits = UIAccessibilityTraitButton;
}

- (UILabel *)makeLabelWithTextStyle:(UIFontTextStyle)textStyle color:(UIColor *)color {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont preferredFontForTextStyle:textStyle];
    label.adjustsFontForContentSizeCategory = YES;
    label.textColor = color;
    label.numberOfLines = 0;
    return label;
}

@end
