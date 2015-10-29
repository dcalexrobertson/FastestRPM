//
//  ViewController.m
//  Fastest RPM
//
//  Created by Alex on 2015-10-29.
//  Copyright © 2015 Alex. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSNumber *topSpeed;
@property (weak, nonatomic) IBOutlet UIImageView *needle;
@property (weak, nonatomic) IBOutlet UILabel *topSpeedLabel;

- (void)resetNeedle;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetNeedle];
    self.topSpeed = [[NSNumber alloc] initWithDouble:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fingerSpeed:(UIPanGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateFailed || sender.state == UIGestureRecognizerStateCancelled) {
        
        [self resetNeedle];
        
    } else {
        
        CGPoint vel = [sender velocityInView:self.view];
        double fingerSpeed = (vel.x * vel.x) + (vel.y * vel.y);
        NSNumber *speed = [NSNumber numberWithDouble:sqrt(fingerSpeed)];

        if ([speed intValue] > [self.topSpeed intValue]) {
            self.topSpeed = speed;
        }
        
        self.topSpeedLabel.text = [NSString stringWithFormat:@"Fastest Speed: %@", self.topSpeed];
    
        //max speed is 10 000
    
        NSNumber *percentage = [NSNumber numberWithDouble:[speed doubleValue] / 10000];
    
        NSNumber *degrees = [NSNumber numberWithDouble:270 * [percentage doubleValue]];
    
        NSLog(@"%@", degrees);
    
        CGFloat rotation = [degrees doubleValue] * (M_PI/180);
    
        CGFloat min = (M_PI * 0.75);
    
        self.needle.transform = CGAffineTransformMakeRotation(rotation + min);
    }
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(resetNeedle) userInfo:nil repeats:YES];
}

- (void)resetNeedle {self.needle.transform = CGAffineTransformMakeRotation(M_PI * 0.75);}


@end
