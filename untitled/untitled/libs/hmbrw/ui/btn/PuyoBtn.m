//
// PuyoBtn.m
//

#import "PuyoBtn.h"

@implementation PuyoBtn

enum{
    kTagSequence,
};

//////////////////////////////////////////////////////////////////////

- (void)_press
{
    [self stopActionByTag:kTagSequence];
    
    id step0;
    id easeAction;
    CCSequence* sequence;
    
	step0 = [CCScaleTo actionWithDuration:0.1f scale:1.1f];
    easeAction = [CCEaseElasticOut actionWithAction:step0];
    sequence = [CCSequence actions:step0, easeAction, nil];
    sequence.tag = kTagSequence;
    [self runAction:sequence];
}

- (void)_release
{
    [self stopActionByTag:kTagSequence];
    
    id step0;
    id easeAction;
    CCSequence* sequence;
    
	step0 = [CCScaleTo actionWithDuration:0.3f scale:1.0f];
    easeAction = [CCEaseElasticOut actionWithAction:step0];
    sequence = [CCSequence actions:step0, easeAction, nil];
    sequence.tag = kTagSequence;
    [self runAction:sequence];
}

//////////////////////////////////////////////////////////////////////

@end
