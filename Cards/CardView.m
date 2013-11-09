// Copyright 2013 Bret Taylor

#import "CardView.h"

static NSMutableDictionary *gImageCache;

@implementation CardView {
    Card *_card;
    BOOL _showBack;
    CGSize _lastDrawSize;
    UIImageView *_cardImage;
}

+(void)initialize {
    if (self == CardView.class) {
        gImageCache = [NSMutableDictionary new];
    }
}

-(id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.opaque = NO;
        static const CGFloat cornderRadius = 3;
        static const CGFloat shadowSize = 1;
        UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"Card"] resizableImageWithCapInsets:UIEdgeInsetsMake(cornderRadius + shadowSize, cornderRadius + shadowSize, cornderRadius + shadowSize, cornderRadius + shadowSize)]];
        backgroundImage.frame = CGRectInset(self.bounds, -shadowSize, -shadowSize);
        backgroundImage.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:backgroundImage];

        _cardImage = [[UIImageView alloc] initWithFrame:self.bounds];
        _cardImage.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_cardImage];
    }
    return self;
}

-(void)setCard:(Card *)card {
    _card = card;
    [self draw];
}

-(Card *)card {
    return _card;
}

-(void)setShowBack:(BOOL)showBack {
    _showBack = showBack;
    [self draw];
}

-(BOOL)showBack {
    return _showBack;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    if (!CGSizeEqualToSize(_cardImage.bounds.size, _lastDrawSize)) {
        [self draw];
    }
}

-(void)draw {
    _lastDrawSize = _cardImage.bounds.size;
    if (_showBack) {
        _cardImage.image = [CardView imageForSize:_lastDrawSize index:52];
    } else {
        _cardImage.image = [CardView imageForSize:_lastDrawSize index:_card.index];
    }
}

+(UIImage *)imageForSize:(CGSize)size index:(NSUInteger)index {
    NSValue *key = [NSValue valueWithCGSize:size];
    NSMutableArray *images = gImageCache[key];
    if (!images) {
        NSURL *url = [NSURL fileURLWithPath:[NSBundle.mainBundle pathForResource:@"Cards" ofType:@"pdf"]];
        CGPDFDocumentRef document = CGPDFDocumentCreateWithURL((CFURLRef)url);
        images = [NSMutableArray new];
        for (size_t i = 0; i < CGPDFDocumentGetNumberOfPages(document); i++) {
            UIGraphicsBeginImageContextWithOptions(size, false, 0);
            CGContextRef context = UIGraphicsGetCurrentContext();
            
            CGContextTranslateCTM(context, 0.0, size.height);
            CGContextScaleCTM(context, 1.0, -1.0);
            
            CGPDFPageRef page = CGPDFDocumentGetPage(document, i + 1);
            CGRect pdfBox = CGPDFPageGetBoxRect(page, kCGPDFBleedBox);
            CGRect targetRect = CGRectMake(0, 0, size.width, size.height);
            CGFloat xScale = targetRect.size.width / pdfBox.size.width;
            CGFloat yScale = targetRect.size.height / pdfBox.size.height;
            CGFloat theScale = xScale < yScale ? xScale : yScale;
            
            CGPathRef path = CGPathCreateWithRect(CGRectMake(0, 0, size.width, size.height), NULL);
            
            CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
            CGContextAddPath(context, path);
            CGPathRelease(path);
            CGContextFillPath(context);
            
            CGContextConcatCTM(context, CGAffineTransformMakeScale(theScale, theScale));
            CGContextDrawPDFPage(context, page);
            
            [images addObject:UIGraphicsGetImageFromCurrentImageContext()];
            
        }
        CGPDFDocumentRelease(document);
        [gImageCache setObject:images forKey:key];
    }
    return images[index];
}

+(CGFloat)heightForWidth:(CGFloat)width {
    return ceil(width * 1.3966);
}
@end
