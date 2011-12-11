//
// PuruBtn.m
//

#import "PuruBtn.h"

@implementation PuruBtn


//////////////////////////////////////////////////////////////////////

- (void)_init
{
    [self schedule:@selector(tick:) interval: 1.0f];
}

- (void)tick:(ccTime) dt
{
    id step0;
    id step1;
    id easeAction;
    
	step0 = [CCRotateBy actionWithDuration:0.1f angle:3];
	step1 = [CCRotateBy actionWithDuration:0.6f angle:-3];
    easeAction = [CCEaseElasticOut actionWithAction:step1];
    
	[self runAction:[CCSequence actions:step0, easeAction, nil]];
    
	srand(rand()%99 + time(nil));
    float time = rand()%3;
    
    [self unschedule:@selector(tick:)];
    [self schedule:@selector(tick:) interval: time];
}

//////////////////////////////////////////////////////////////////////

@end
