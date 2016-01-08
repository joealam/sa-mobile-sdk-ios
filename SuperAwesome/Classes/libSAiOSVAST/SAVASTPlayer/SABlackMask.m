//
//  SABlackMask.m
//  Pods
//
//  Created by Gabriel Coman on 08/01/2016.
//
//

#import "SABlackMask.h"

@implementation SABlackMask

- (id) init {
    if (self = [super initWithImage:[UIImage imageNamed:@"mark.png"]]) {
        // do nothing
    }
    
    return self;
}

- (void) didMoveToSuperview {
    CGRect _parentFrame = self.superview.frame;
    self.alpha = 0.75f;
    self.frame = CGRectMake(0, _parentFrame.size.height - 40, _parentFrame.size.width, 40);
}
@end