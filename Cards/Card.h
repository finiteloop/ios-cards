// Copyright 2013 Bret Taylor

#import <UIKit/UIKit.h>

typedef enum {
    Spades,
    Hearts,
    Clubs,
    Diamonds,
} Suit;

typedef enum {
    Ace = 14,
    King = 13,
    Queen = 12,
    Jack = 11,
} FaceCard;

@interface Card : NSObject

@property (readonly) Suit suit;
@property (readonly) NSUInteger number;
@property (readonly) NSUInteger index;

-(id)initWithSuit:(Suit)suit number:(NSUInteger)number;
-(id)initWithIndex:(NSUInteger)index;

@end
