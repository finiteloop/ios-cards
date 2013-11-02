// Copyright 2013 Bret Taylor

#import "CardsController.h"
#import "CardView.h"

@interface CardCell : UICollectionViewCell

@property (readwrite) CardView *cardView;

@end

@implementation CardCell

-(id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _cardView = [[CardView alloc] initWithFrame:self.contentView.bounds];
        _cardView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:_cardView];
    }
    return self;
}

@end

@implementation CardsController

-(id)init {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad ?
        CGSizeMake(179, [CardView heightForWidth:179]) :
        CGSizeMake(100, [CardView heightForWidth:100]);
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    if (self = [super initWithCollectionViewLayout:layout]) {
        self.title = @"Cards";
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = UIColor.whiteColor;
    [self.collectionView registerClass:CardCell.class forCellWithReuseIdentifier:@"CardCell"];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 52;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CardCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CardCell" forIndexPath:indexPath];
    cell.cardView.card = [[Card alloc] initWithIndex:indexPath.item];
    return cell;
}

@end
