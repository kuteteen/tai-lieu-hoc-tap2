#import <Foundation/Foundation.h>
#import "esp.h"
#import <UIKit/UIKit.h>

@implementation esp : UIView
@synthesize players;
@synthesize espboxes;
@synthesize esplines;
@synthesize healthbarr;
@synthesize distanceesp;
- (id)initWithFrame:(UIWindow*)main
{
    self = [super initWithFrame:main.frame];
    self.userInteractionEnabled = false;
    self.hidden = false;
    self.backgroundColor = [UIColor clearColor];
    if(!players){
        players = new std::vector<player_t *>();
    }
    [main addSubview:self];
    return self;
}
- (void)drawRect:(CGRect)rect {
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextClearRect(contextRef,self.bounds);
    CGContextSetLineWidth(contextRef, 1.0);
    CGColor *colour;
    UIColor *Ucolour;
    for(int i = 0; i < players->size(); i++) {
        if((*players)[i]->enemy){
            colour = [UIColor redColor].CGColor;
            Ucolour = [UIColor redColor];
        }else{
            colour = [UIColor blueColor].CGColor;
            Ucolour = [UIColor blueColor];
        }
        CGContextSetStrokeColorWithColor(contextRef, colour);
        if(esplines){
            if((*players)[i]->enemy){
                CGContextMoveToPoint(contextRef,self.frame.size.width/2, 0.0f);
                CGContextAddLineToPoint(contextRef, (*players)[i]->topofbox.x, (*players)[i]->topofbox.y);
            }else{
                CGContextMoveToPoint(contextRef,self.frame.size.width/2, self.frame.size.height);
                CGContextAddLineToPoint(contextRef, (*players)[i]->bottomofbox.x, (*players)[i]->bottomofbox.y);
            }
            CGContextStrokePath(contextRef);
        }
        if(espboxes){
            CGContextStrokeRect(contextRef, (*players)[i]->box);
        }
        if(healthbarr){
            [[UIColor redColor] setFill];
            CGContextFillRect(contextRef, (*players)[i]->healthbar);
            [[UIColor greenColor] setFill];
            float cc = (*players)[i]->health/100;
            CGRect healthbar = CGRectMake((*players)[i]->healthbar.origin.x, (*players)[i]->healthbar.origin.y, (*players)[i]->healthbar.size.width, (*players)[i]->healthbar.size.height*cc);
            CGContextFillRect(contextRef, healthbar);
        }
        if(distanceesp){
            NSString *text = [NSString stringWithFormat:@"%.0f", (*players)[i]->distance];
            float xd = 30 / ((*players)[i]->distance/10);
            if(xd>25){
                xd = 25.0f;
            }
            xd = (*players)[i]->box.size.width/2;
            NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:xd], NSForegroundColorAttributeName:Ucolour};
            [text drawAtPoint:CGPointMake(((*players)[i]->box.origin.x), ((*players)[i]->bottomofbox.y)) withAttributes:attributes];
        }
    }
    
}



@end
