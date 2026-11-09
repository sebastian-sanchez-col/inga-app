//
//  INGHomeViewController.m
//  inga-app
//

#import "INGHomeViewController.h"
#import "INGHomeViewModel.h"
#import "INGHomeFeatureItemViewModel.h"
#import "INGFeatureCardCell.h"
#import "INGHomeHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

typedef UICollectionViewDiffableDataSource<NSString *, INGHomeFeatureItemViewModel *> INGHomeDataSource;
typedef NSDiffableDataSourceSnapshot<NSString *, INGHomeFeatureItemViewModel *> INGHomeSnapshot;

static NSString *const INGHomeMainSectionIdentifier = @"communication";
static const CGFloat INGHomeSpacing = 12.0;
static const CGFloat INGHomeEstimatedCardHeight = 96.0;
static const CGFloat INGHomeEstimatedHeaderHeight = 44.0;
/// Minimum width at which cards are laid out in a single row (iPad / wide landscape).
static const CGFloat INGHomeMultiColumnMinimumWidth = 700.0;

@interface INGHomeViewController () <UICollectionViewDelegate>

@property (nonatomic, strong, readonly) INGHomeViewModel *viewModel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) INGHomeDataSource *dataSource;

@end

@implementation INGHomeViewController

- (instancetype)initWithViewModel:(INGHomeViewModel *)viewModel {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _viewModel = viewModel;
    }
    return self;
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = self.viewModel.title;
    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
    self.view.backgroundColor = UIColor.systemGroupedBackgroundColor;

    [self setUpCollectionView];
    [self setUpDataSource];
    [self applySnapshot];
}

#pragma mark - Setup

- (void)setUpCollectionView {
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                             collectionViewLayout:[self makeLayout]];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.backgroundColor = UIColor.clearColor;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];

    [NSLayoutConstraint activateConstraints:@[
        [self.collectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
    ]];
}

- (UICollectionViewLayout *)makeLayout {
    return [[UICollectionViewCompositionalLayout alloc] initWithSectionProvider:
            ^NSCollectionLayoutSection * _Nullable(NSInteger sectionIndex, id<NSCollectionLayoutEnvironment> environment) {
        NSInteger columns = [INGHomeViewController columnCountForEnvironment:environment];

        NSCollectionLayoutSize *cardSize =
            [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0]
                                           heightDimension:[NSCollectionLayoutDimension estimatedDimension:INGHomeEstimatedCardHeight]];
        NSCollectionLayoutItem *item = [NSCollectionLayoutItem itemWithLayoutSize:cardSize];
        NSCollectionLayoutGroup *group = [NSCollectionLayoutGroup horizontalGroupWithLayoutSize:cardSize
                                                                               repeatingSubitem:item
                                                                                          count:columns];
        group.interItemSpacing = [NSCollectionLayoutSpacing fixedSpacing:INGHomeSpacing];

        NSCollectionLayoutSize *headerSize =
            [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0]
                                           heightDimension:[NSCollectionLayoutDimension estimatedDimension:INGHomeEstimatedHeaderHeight]];
        NSCollectionLayoutBoundarySupplementaryItem *header =
            [NSCollectionLayoutBoundarySupplementaryItem boundarySupplementaryItemWithLayoutSize:headerSize
                                                                                     elementKind:UICollectionElementKindSectionHeader
                                                                                       alignment:NSRectAlignmentTop];

        NSCollectionLayoutSection *section = [NSCollectionLayoutSection sectionWithGroup:group];
        section.interGroupSpacing = INGHomeSpacing;
        section.contentInsetsReference = UIContentInsetsReferenceLayoutMargins;
        section.contentInsets = NSDirectionalEdgeInsetsMake(0, 0, INGHomeSpacing * 2, 0);
        section.boundarySupplementaryItems = @[header];
        return section;
    }];
}

+ (NSInteger)columnCountForEnvironment:(id<NSCollectionLayoutEnvironment>)environment {
    BOOL isAccessibilitySize =
        UIContentSizeCategoryIsAccessibilityCategory(environment.traitCollection.preferredContentSizeCategory);
    BOOL hasRoomForColumns = environment.container.effectiveContentSize.width >= INGHomeMultiColumnMinimumWidth;
    return (hasRoomForColumns && !isAccessibilitySize) ? 3 : 1;
}

- (void)setUpDataSource {
    UICollectionViewCellRegistration *cellRegistration =
        [UICollectionViewCellRegistration registrationWithCellClass:[INGFeatureCardCell class]
                                               configurationHandler:^(__kindof UICollectionViewCell *cell,
                                                                      NSIndexPath *indexPath,
                                                                      id item) {
            [(INGFeatureCardCell *)cell configureWithItem:(INGHomeFeatureItemViewModel *)item];
        }];

    // Capture the text (not self) to avoid a retain cycle:
    // self -> dataSource -> registration -> self.
    NSString *subtitle = self.viewModel.subtitle;
    UICollectionViewSupplementaryRegistration *headerRegistration =
        [UICollectionViewSupplementaryRegistration registrationWithSupplementaryClass:[INGHomeHeaderView class]
                                                                          elementKind:UICollectionElementKindSectionHeader
                                                                 configurationHandler:^(__kindof UICollectionReusableView *supplementaryView,
                                                                                        NSString *elementKind,
                                                                                        NSIndexPath *indexPath) {
            [(INGHomeHeaderView *)supplementaryView configureWithText:subtitle];
        }];

    self.dataSource = [[INGHomeDataSource alloc] initWithCollectionView:self.collectionView
                                                           cellProvider:^UICollectionViewCell * _Nullable(UICollectionView *collectionView,
                                                                                                          NSIndexPath *indexPath,
                                                                                                          INGHomeFeatureItemViewModel *item) {
        return [collectionView dequeueConfiguredReusableCellWithRegistration:cellRegistration
                                                                forIndexPath:indexPath
                                                                        item:item];
    }];

    self.dataSource.supplementaryViewProvider = ^UICollectionReusableView * _Nullable(UICollectionView *collectionView,
                                                                                     NSString *elementKind,
                                                                                     NSIndexPath *indexPath) {
        return [collectionView dequeueConfiguredReusableSupplementaryViewWithRegistration:headerRegistration
                                                                             forIndexPath:indexPath];
    };
}

- (void)applySnapshot {
    INGHomeSnapshot *snapshot = [[INGHomeSnapshot alloc] init];
    [snapshot appendSectionsWithIdentifiers:@[INGHomeMainSectionIdentifier]];
    [snapshot appendItemsWithIdentifiers:self.viewModel.items];
    [self.dataSource applySnapshot:snapshot animatingDifferences:NO];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];

    INGHomeFeatureItemViewModel *item = [self.dataSource itemIdentifierForIndexPath:indexPath];
    if (item != nil) {
        [self.viewModel selectItem:item];
    }
}

@end

NS_ASSUME_NONNULL_END
