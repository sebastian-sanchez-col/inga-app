//
//  INGHomeHeaderView.m
//  inga-app
//

#import "INGHomeHeaderView.h"

static const CGFloat INGHeaderBottomPadding = 12.0;

@interface INGHomeHeaderView ()

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation INGHomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _textLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        _textLabel.adjustsFontForContentSizeCategory = YES;
        _textLabel.textColor = UIColor.secondaryLabelColor;
        _textLabel.numberOfLines = 0;
        [self addSubview:_textLabel];

        NSLayoutConstraint *bottomConstraint =
            [_textLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-INGHeaderBottomPadding];
        bottomConstraint.priority = UILayoutPriorityRequired - 1;

        [NSLayoutConstraint activateConstraints:@[
            [_textLabel.topAnchor constraintEqualToAnchor:self.topAnchor],
            [_textLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
            [_textLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
            bottomConstraint,
        ]];
    }
    return self;
}

- (void)configureWithText:(NSString *)text {
    self.textLabel.text = text;
}

@end
