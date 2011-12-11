//
//  ExampleLayer.m
//  untitled
//

#import "ExampleLayer.h"
#import "CCSpriteBtn.h"
#import "PuruBtn.h"
#import "PuyoBtn.h"

@implementation ExampleLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	ExampleLayer *layer = [ExampleLayer node];
	[scene addChild: layer];
	return scene;
}

-(id) init
{
	if( (self=[super init])) {
        
        //
		stage = [[CCDirector sharedDirector] winSize];
        
        //btn - onPress
        CCSpriteBtn *b0 = [[CCSpriteBtn alloc] initWithFiles:@"b_border80.png" ro:@"b_border80_on.png"];
        b0.Id = 0;
        b0.position = ccp( stage.width/2 , stage.height/2 + 150 );
        [b0 addListner:self selector:@selector(onPress:)];
        [b0 addListnerRelease:self selector:@selector(onRelease:)];
        [b0 addLabel:@"Normal"];
        [self addChild: b0];
        
        //btn - ToggleBtn
        CCSpriteBtn *b2 = [[CCSpriteBtn alloc] initToggleWithFiles:@"b_border80.png" toggle:@"b_border80_on.png"];
        b2.Id = 2;
        b2.position = ccp( stage.width/2 , stage.height/2 + 50 );
        [b2 addListner:self selector:@selector(onPress:)];
        [b2 addLabel:@"Toggle"];
        [self addChild: b2];
        
        //PuruBtn - onPress
        PuruBtn *b3 = [[PuruBtn alloc] initWithFiles:@"b_border80.png" ro:@"b_border80_on.png"];
        b3.Id = 3;
        b3.position = ccp( stage.width/2 , stage.height/2 - 50 );
        [b3 addListner:self selector:@selector(onPress:)];
        [b3 addLabel:@"PuruBtn extend CCSpriteBtn"];
        [self addChild: b3];
        
        //PuyoBtn - onPress
        PuyoBtn *b4 = [[PuyoBtn alloc] initWithFiles:@"b_border80.png" ro:@"b_border80_on.png"];
        b4.Id = 4;
        b4.position = ccp( stage.width/2 , stage.height/2 - 150 );
        [b4 addListner:self selector:@selector(onPress:)];
        [b4 addLabel:@"PuyoBtn extend CCSpriteBtn"];
        [self addChild: b4];
        
        
	}
	return self;
}

-(void) onPress:(CCSpriteBtn*)sender
{
	NSLog(@"onPress:%i", sender.Id);
    
	switch (sender.Id)
	{
		case 2://トグルボタンの場合は状態をOutput
            NSLog(@"togle:%i", sender.isToggle);
			break;
	}
}
-(void) onRelease:(CCSpriteBtn*)sender
{
	NSLog(@"onRelease:%i", sender.Id);
}

- (void) dealloc
{
	[super dealloc];
}
@end
