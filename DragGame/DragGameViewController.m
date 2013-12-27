//
//  DragGameViewController.m
//  DragGame
//
//  Created by AIR on 13-12-26.
//  Copyright (c) 2013年 AIR. All rights reserved.
//

#import "DragGameViewController.h"
#import "AboutViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface DragGameViewController (){
    
    int currentValue;
    int targetValue;
    int score;
    int round;
    
    
}
- (IBAction)showInfo:(id)sender;
- (IBAction)startOver:(id)sender;
- (IBAction)sliderMoved:(UISlider*)sender;
@property (strong, nonatomic) IBOutlet UISlider *slider;

@property (strong, nonatomic) IBOutlet UILabel *targetLabel;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *roundLabel;

@property(nonatomic,strong)AVAudioPlayer *audioPlayer;

- (IBAction)showAlert:(id)sender;
@end

@implementation DragGameViewController
@synthesize slider;
@synthesize targetLabel;
@synthesize scoreLabel;
@synthesize roundLabel;
@synthesize audioPlayer;

-(void)playBackgroundMusic{
    
    NSString *musicPath =[[NSBundle mainBundle]pathForResource:@"卡农" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:musicPath];
    NSError *error;
    
    audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    audioPlayer.numberOfLoops = -1;
    if(audioPlayer ==nil){
        NSString *errorInfo = [NSString stringWithString:[error description]];
        NSLog(@"the error is:%@",errorInfo);
    }else{
        [audioPlayer play];
    }
    
    
    
}

-(void)updateLabels{
    
    self.targetLabel.text = [NSString stringWithFormat:@"%d",targetValue];
    self.scoreLabel.text = [NSString stringWithFormat:@"%d",score];
    self.roundLabel.text = [NSString stringWithFormat:@"%d",round];
}


-(void)startNewRound{
    
    round +=1;
    targetValue = 1+(arc4random()%100);
    currentValue = 50;
    self.slider.value = currentValue;
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    //播放背景音乐
    [self playBackgroundMusic];
    
    
    //美化滑动条
    
    
    UIImage *thumbImageNormal = [UIImage imageNamed:@"SliderThumb-Normal"];
    [self.slider setThumbImage:thumbImageNormal forState:UIControlStateNormal];
    
    
    UIImage *thumbImageHighlighted = [UIImage imageNamed:@"SliderThumb-Highlighted"];
    [self.slider setThumbImage:thumbImageHighlighted forState:UIControlStateHighlighted];
    
    UIImage *trackLeftImage = [[UIImage imageNamed:@"SliderTrackLeft"] stretchableImageWithLeftCapWidth:14 topCapHeight:0];
    [self.slider setMinimumTrackImage:trackLeftImage forState:UIControlStateNormal];
    
    UIImage *trackRightImage = [[UIImage imageNamed:@"SliderTrackRight"] stretchableImageWithLeftCapWidth:14 topCapHeight:0];
    [self.slider setMaximumTrackImage:trackRightImage forState:UIControlStateNormal];
    
    
    [self startNewRound];
    [self updateLabels];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)startNewGame{
    
    score = 0;
    round = 0;
    [self startNewRound];
    
    
}
- (IBAction)showInfo:(id)sender {
    
    AboutViewController *controller = [[AboutViewController alloc]initWithNibName:@"AboutViewController" bundle:nil];
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
    
}

- (IBAction)startOver:(id)sender {
    
    
    //添加过渡效果
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = 3;
    transition.timingFunction  = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    
    [self startNewGame];
    [self updateLabels];
    
    [self.view.layer addAnimation:transition forKey:nil];
}

- (IBAction)sliderMoved:(UISlider*)sender {
    
    currentValue = (int)lroundf(sender.value);
    
}

- (IBAction)showAlert:(id)sender {
    
    int difference = abs(currentValue - targetValue);
    
    int points = 100-difference;
    
    score += points;
    
    NSString *title;
    
    if(difference ==0){
        title = @"你太NB了！";
        points +=100;
        
    }else if(difference <5){
        
        if(difference ==1){
            points +=50;
        }
        title = @"太棒了，差一点！";
    }else if(difference <10){
        title = @"好吧，还不错";
    }else{
        title = @"远的没边了！";
    }
    
    NSString *message = [NSString stringWithFormat:@"恭喜高富帅，您的得分是：%d",points];
    
    [[[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"朕已知晓，爱卿辛苦了" otherButtonTitles:nil, nil]show];
    
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    [self startNewRound];
    [self updateLabels];
}

@end
