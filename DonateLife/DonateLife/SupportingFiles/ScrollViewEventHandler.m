
#import "ScrollViewEventHandler.h"

@implementation ScrollViewEventHandler

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.nextResponder touchesBegan:touches withEvent:event];
    NSLog(@"Hello");
}



@end
