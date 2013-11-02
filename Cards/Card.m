// Copyright 2013 Bret Taylor

#import "Card.h"

@implementation Card

-(id)initWithIndex:(NSUInteger)index {
    if (self = [super init]) {
        _index = index;
    }
    return self;
}

-(id)initWithSuit:(Suit)suit number:(NSUInteger)number {
    if (self = [super init]) {
        _index = suit * 13 + number - 2;
    }
    return self;
}

-(Suit)suit {
    return (Suit)(_index / 13);
}

-(NSUInteger)number {
    return _index % 13 + 2;
}

-(BOOL)isEqual:(id)object {
    return [object isKindOfClass:Card.class] && ((Card *)object).index == _index;
}

-(NSUInteger)hash {
    return [NSNumber numberWithUnsignedInteger:_index].hash;
}

@end
