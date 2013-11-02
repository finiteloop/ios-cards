// Copyright 2013 Bret Taylor

#import <UIKit/UIKit.h>
#import "Card.h"

@interface CardView : UIView

@property (readwrite) Card *card;
@property (readwrite) BOOL showBack;

+(CGFloat)heightForWidth:(CGFloat)width;

@end
