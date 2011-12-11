//
//  CCSpriteBtn.h
//

#import "cocos2d.h"

//

@interface CCSpriteBtn : CCSprite <CCTargetedTouchDelegate>
{
	//
	NSInvocation* invocation;
	NSInvocation* invocation_release;
	BOOL isTouch;
	int Id;
	
	//
	BOOL toggleMode;
	BOOL isToggle;
	BOOL isActive;
	
	//
	CCSprite* ro;
	NSString* deffile;
	NSString* rofile;
	NSString* togglefile;
}
@property (readwrite, assign) int Id;
@property (readwrite, assign) BOOL isToggle;
@property (readwrite, assign) BOOL isActive;

-(id) initWithFiles:(NSString*)filename ro:(NSString*)rofilename;
-(id) initToggleWithFiles:(NSString*)filename toggle:(NSString*)togglefilename;

-(void) addLabel:(NSString*)s;

-(void) addListner:(id)t selector:(SEL)sel;
-(void) addListnerRelease:(id)t selector:(SEL)sel;

-(void) toggle:(BOOL)bo;
-(void) act:(BOOL)bo;

-(void) onPress;
-(void) onRelease;

-(void) _init;
-(void) _press;
-(void) _release;

@end



