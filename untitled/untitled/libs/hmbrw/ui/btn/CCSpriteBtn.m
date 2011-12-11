//
// CCSpriteBtn.m
//

#import "CCSpriteBtn.h"

@implementation CCSpriteBtn


//////////////////////////////////////////////////////////////////////

//synthesize

@synthesize Id;
@synthesize isToggle;
@synthesize isActive;

//////////////////////////////////////////////////////////////////////

-(id) initWithFiles:(NSString*)filename ro:(NSString*)rofilename
{
	NSAssert(filename!=nil, @"Invalid filename for sprite");
	
	toggleMode = FALSE;
	isToggle = FALSE;
	
	deffile = filename;
	rofile = rofilename;
	
	CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage:deffile];
	if( texture ) {
		CGRect rect = CGRectZero;
		rect.size = texture.contentSize;
        [self _init];
		return [self initWithTexture:texture rect:rect];
	}
	[self release];
    return nil;
}

-(id) initToggleWithFiles:(NSString*)filename toggle:(NSString*)togglefilename
{
	NSAssert(filename!=nil, @"Invalid filename for sprite");
	
	toggleMode = TRUE;
	isToggle = FALSE;
	
	deffile = filename;
	togglefile = togglefilename;
	
	CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage: filename];
	if( texture ) {
		CGRect rect = CGRectZero;
		rect.size = texture.contentSize;
        [self _init];
		return [self initWithTexture:texture rect:rect];
	}
    
	[self release];
	return nil;
}

//////////////////////////////////////////////////////////////////////

//ラベル付ける
-(void) addLabel:(NSString*)s
{
	CGSize size = [self.texture contentSize];
	CCLabelTTF *label;
	label = [CCLabelTTF labelWithString:s 
                             dimensions:CGSizeMake(contentSize_.width - 10, contentSize_.height - 34) 
                              alignment:CCTextAlignmentCenter
                               fontName:@"Helvetica"
                               fontSize:12
             ];

	label.position = ccp( size.width/2 , size.height/2 );
	[self addChild: label];
}

//////////////////////////////////////////////////////////////////////

//リスナー
-(void) addListner:(id)t selector:(SEL)sel;
{
	//
	if( t && sel ) {
		NSMethodSignature * sig = nil;
		sig = [[t class] instanceMethodSignatureForSelector:sel];
		invocation = nil;
		
		if(invocation) [invocation release];
		invocation = [NSInvocation invocationWithMethodSignature:sig];
		[invocation setTarget:t];
		[invocation setSelector:sel];
#if NS_BLOCKS_AVAILABLE
		if ([sig numberOfArguments] == 3) 
#endif
			[invocation setArgument:&self atIndex:2];
		
		[invocation retain];
	}
	
}
-(void) addListnerRelease:(id)t selector:(SEL)sel;
{
	//
	if( t && sel ) {
		NSMethodSignature * sig = nil;
		sig = [[t class] instanceMethodSignatureForSelector:sel];
		invocation_release = nil;
		
		if(invocation_release) [invocation_release release];
		invocation_release = [NSInvocation invocationWithMethodSignature:sig];
		[invocation_release setTarget:t];
		[invocation_release setSelector:sel];
#if NS_BLOCKS_AVAILABLE
		if ([sig numberOfArguments] == 3) 
#endif
			[invocation_release setArgument:&self atIndex:2];
		
		[invocation_release retain];
	}
}

//////////////////////////////////////////////////////////////////////

//タッチロジック

-(void) onEnter{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
	[super onEnter];
}
-(void) onExit{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super onExit];
}     

// Spriteの矩形サイズを返す
-(CGRect) rect {
	CGSize s = [self.texture contentSize];
	return CGRectMake(-s.width / 2, -s.height / 2, s.width, s.height);
}

// Spriteの矩形サイズの中にタッチの位置が入っているかどうかチェック
-(BOOL) containsTouchLocation:(UITouch *)touch {
	return CGRectContainsPoint(self.rect, [self convertTouchToNodeSpaceAR:touch]);
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	if ( ![self containsTouchLocation:touch] ) return NO;
	
	//NSLog(@"touch:%i", Id_);
	//[invocation invoke];
	
    [self _press];
	[self onPress];
	return YES;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self _release];
	[self onRelease];
}

//////////////////////////////////////////////////////////////////////

-(void) toggle:(BOOL)bo
{
	isToggle = bo;
	CCTexture2D *texture;
	if( toggleMode ) {
		if( isToggle ) {
			texture = [[CCTextureCache sharedTextureCache] addImage:togglefile];
			[self setTexture:texture];
		} else {
			texture = [[CCTextureCache sharedTextureCache] addImage:deffile];
			[self setTexture:texture];
		}
	}
}

//////////////////////////////////////////////////////////////////////

-(void) act:(BOOL)bo
{
	isActive = bo;
    
    CCTexture2D *texture;
    if(bo) {
        texture = [[CCTextureCache sharedTextureCache] addImage:rofile];
        [self setTexture:texture];
    } else {
        texture = [[CCTextureCache sharedTextureCache] addImage:deffile];
        [self setTexture:texture];
    }
}

//////////////////////////////////////////////////////////////////////

-(void) onPress
{
    if(isActive) return;
    
	if(!isTouch) {
		isTouch = TRUE;
		
		CCTexture2D *texture;
		
		if( toggleMode ) {
			if( isToggle ) {
				isToggle = FALSE;
				texture = [[CCTextureCache sharedTextureCache] addImage:deffile];
				[self setTexture:texture];
			} else {
				isToggle = TRUE;
				texture = [[CCTextureCache sharedTextureCache] addImage:togglefile];
				[self setTexture:texture];
			}
		} else {
			if( rofile ) {
				texture = [[CCTextureCache sharedTextureCache] addImage:rofile];
				[self setTexture:texture];
			}
		}
		
		[invocation invoke];
	}
}

-(void) onRelease
{
    if(isActive) return;
    
    CCTexture2D *texture;
	if(isTouch) {
		
		if( rofile ) {
			texture = [[CCTextureCache sharedTextureCache] addImage:deffile];
			[self setTexture:texture];
		}
		
		[invocation_release invoke];
		isTouch = FALSE;
	}
    
}

//////////////////////////////////////////////////////////////////////

//継承用
-(void) _init
{
}
-(void) _press
{
}
-(void) _release
{
}

//////////////////////////////////////////////////////////////////////

-(void) dealloc
{
	if(invocation) [invocation release];
	if(invocation_release) [invocation_release release];
	
	[super dealloc];
}

@end
