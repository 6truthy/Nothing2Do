//
//  ViewController.m
//  Nothing2Do
//
//  Created by ChaunceyLu on 3/3/15.
//  Copyright (c) 2015 ChaunceyLu. All rights reserved.
//

#import "ViewController.h"
#import "FLAnimatedImage.h"
@interface ViewController ()

@property (nonatomic, strong) FLAnimatedImageView *GIFImageView;
@end

@implementation ViewController {
    UIButton *watchButton, *listenButton, *clickButton, *introButton, *backButton, *nextButton, *dogeButton;
    CGSize screenSize;
    AVAudioPlayer *audioPlayer;
    NSTimer *timer;
    UILabel *levelLabel;
    UILabel *scoreLabel;
    UILabel *titleLabel;
    NSArray *level2Title;
    UIImageView *dogecoinImageView;
    UIImageView *introImageView;
    UISwipeGestureRecognizer *gestureRecognizer, *gestureRecognizer2;
    int hasStarted;
    UITapGestureRecognizer *gr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [self.view addGestureRecognizer:gr];
    gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    gestureRecognizer2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    level2Title = [[NSArray alloc] initWithObjects:@"发呆doge",@"无聊doge",@"寂寞doge",@"神烦doge",@"无聊到爆炸",@"发呆王",@"发呆神",@"度日如年",@"需要人陪",@"6truthy@gmail.com", nil];
    screenSize = [[UIScreen mainScreen] bounds].size;
    int heightOffset44 = (double)44 / 568 * screenSize.height;
    int heightOffsetdogecoin = (double)44 / 568 * screenSize.height;
    int heightOffset480 = (double)480 / 568 * screenSize.height;
    // Do any additional setup after loading the view, typically from a nib.
    if (!self.GIFImageView) {
        self.GIFImageView = [[FLAnimatedImageView alloc] init];
        self.GIFImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.GIFImageView.clipsToBounds = YES;
    }
    [self.view addSubview:self.GIFImageView];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"gif"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    FLAnimatedImage *animatedImage = [FLAnimatedImage animatedImageWithGIFData:data];
    self.GIFImageView.frame = CGRectMake(0.0, 0.0, screenSize.width, heightOffset480);
    self.GIFImageView.animatedImage = animatedImage;
    watchButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    listenButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    clickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    introButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    nextButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    dogeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dogecoinImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, heightOffset480, heightOffsetdogecoin, heightOffsetdogecoin)];
    dogecoinImageView.contentMode = UIViewContentModeScaleAspectFill;
    dogecoinImageView.image = [UIImage imageNamed:@"dogecoin.png"];
    introImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, screenSize.height, 320, 480)];
    introImageView.contentMode = UIViewContentModeScaleAspectFill;
    introImageView.image = [UIImage imageNamed:@"intro.png"];
    levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenSize.width / 2, heightOffset480 + heightOffset44, screenSize.width / 2, heightOffset44)];
    scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, heightOffset480, screenSize.width / 2, heightOffset44)];
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenSize.width / 2, heightOffset480, screenSize.width / 2, heightOffset44)];
    levelLabel.textAlignment = NSTextAlignmentCenter;
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [watchButton setTitle:@"看·发呆" forState:UIControlStateNormal];
    [listenButton setTitle:@"听·发呆" forState:UIControlStateNormal];
    [clickButton setTitle:@"点·发呆" forState:UIControlStateNormal];
    [introButton setTitle:@"发呆说明" forState:UIControlStateNormal];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [nextButton setTitle:@"换一个" forState:UIControlStateNormal];
    watchButton.frame = CGRectMake(0.0, heightOffset480, screenSize.width / 2, heightOffset44);
    listenButton.frame = CGRectMake(screenSize.width / 2, heightOffset480, screenSize.width / 2, heightOffset44);
    clickButton.frame = CGRectMake(0.0, heightOffset480 + heightOffset44, screenSize.width / 2, heightOffset44);
    introButton.frame = CGRectMake(screenSize.width / 2, heightOffset480 + heightOffset44, screenSize.width / 2, heightOffset44);
    backButton.frame = CGRectMake(0.0, heightOffset480 + heightOffset44, screenSize.width / 2, heightOffset44);
    nextButton.frame = CGRectMake(screenSize.width / 2, heightOffset480 + heightOffset44, screenSize.width / 2, heightOffset44);
    [self.view addSubview:watchButton];
    [self.view addSubview:clickButton];
    [self.view addSubview:listenButton];
    [self.view addSubview:introButton];
    [self.view addSubview:backButton];
    [self.view addSubview:nextButton];
    [self.view addSubview:dogeButton];
    [self.view addSubview:levelLabel];
    [self.view addSubview:scoreLabel];
    [self.view addSubview:titleLabel];
    [self.view addSubview:dogecoinImageView];
    [self.view addSubview:introImageView];
    [gestureRecognizer2 setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:gestureRecognizer];
    [self.view addGestureRecognizer:gestureRecognizer2];
    backButton.hidden = TRUE;
    nextButton.hidden = TRUE;
    levelLabel.hidden = TRUE;
    scoreLabel.hidden = TRUE;
    titleLabel.hidden = TRUE;
    gestureRecognizer.enabled = NO;
    gestureRecognizer2.enabled = NO;
    dogecoinImageView.hidden = TRUE;
    [watchButton addTarget:self
               action:@selector(watchButtonClicked)
     forControlEvents:UIControlEventTouchUpInside];
    [listenButton addTarget:self
               action:@selector(listenButtonClicked)
     forControlEvents:UIControlEventTouchUpInside];
    [clickButton addTarget:self
               action:@selector(clickButtonClicked)
     forControlEvents:UIControlEventTouchUpInside];
    [introButton addTarget:self
               action:@selector(introButtonClicked)
     forControlEvents:UIControlEventTouchUpInside];
    [backButton addTarget:self
                    action:@selector(backButtonClicked)
          forControlEvents:UIControlEventTouchUpInside];
    [nextButton addTarget:self
                    action:@selector(nextButtonClicked)
          forControlEvents:UIControlEventTouchUpInside];
    [dogeButton addTarget:self
                   action:@selector(dogeButtonClicked)
         forControlEvents:UIControlEventTouchUpInside];
//    backButton.backgroundColor = [UIColor whiteColor];
//    nextButton.backgroundColor = [UIColor whiteColor];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
- (void)watchButtonClicked {
    int heightOffset150 = (double)150 / 568 * screenSize.height;
    int heightOffset50 = (double)50 / 568 * screenSize.height;
    watchButton.hidden = TRUE;
    listenButton.hidden = TRUE;
    clickButton.hidden = TRUE;
    introButton.hidden = TRUE;
    backButton.hidden = FALSE;
    nextButton.hidden = FALSE;
    dogeButton.hidden = TRUE;
    levelLabel.hidden = TRUE;
    scoreLabel.hidden = TRUE;
    titleLabel.hidden = TRUE;
    dogecoinImageView.hidden = TRUE;
    gestureRecognizer.enabled = YES;
    gestureRecognizer2.enabled = YES;
    int i = arc4random_uniform(126) + 1;
    NSString *gifName = [NSString stringWithFormat:@"%d",i];
    NSURL *url = [[NSBundle mainBundle] URLForResource:gifName withExtension:@"gif"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    FLAnimatedImage *animatedImage = [FLAnimatedImage animatedImageWithGIFData:data];
    if (i != 8 && i != 100 & i != 102)
        self.GIFImageView.frame = CGRectMake(0.0, heightOffset150, screenSize.width, animatedImage.size.height * screenSize.width / animatedImage.size.width);
    else
        self.GIFImageView.frame = CGRectMake(0.0, heightOffset50, screenSize.width, animatedImage.size.height * screenSize.width / animatedImage.size.width);

    self.GIFImageView.animatedImage = animatedImage;
    self.view.backgroundColor = [UIColor blackColor];
}
- (void)listenButtonClicked {
    int heightOffset150 = (double)150 / 568 * screenSize.height;
    int heightOffset44 = (double)44 / 568 * screenSize.height;
    watchButton.hidden = TRUE;
    listenButton.hidden = TRUE;
    clickButton.hidden = TRUE;
    introButton.hidden = TRUE;
    backButton.hidden = FALSE;
    nextButton.hidden = TRUE;
    dogeButton.hidden = TRUE;
    levelLabel.hidden = TRUE;
    scoreLabel.hidden = TRUE;
    titleLabel.hidden = TRUE;
    dogecoinImageView.hidden = TRUE;
    gestureRecognizer.enabled = NO;
    gestureRecognizer2.enabled = NO;
    int i = arc4random_uniform(4);
    NSString *gifName;
    NSString *soundName;
    switch (i) {
        case 0:
            gifName = @"rainySunset";
            soundName = @"raining";
            break;
        case 1:
            gifName = @"waterfall";
            soundName = @"waterfall";
            break;
        case 2:
            gifName = @"wave";
            soundName = @"wave";
            break;
        case 3:
            gifName = @"Disc";
            soundName = @"Bandari - Spring Water";
            break;
        default:
            break;
    }
    self.view.backgroundColor = [UIColor blackColor];
    NSURL *url = [[NSBundle mainBundle] URLForResource:gifName withExtension:@"gif"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    FLAnimatedImage *animatedImage = [FLAnimatedImage animatedImageWithGIFData:data];
    if (i <= 1)
        self.GIFImageView.frame = CGRectMake(0.0, 0.0, screenSize.width, screenSize.height - heightOffset44);
    else
        self.GIFImageView.frame = CGRectMake(0.0, heightOffset150, screenSize.width, animatedImage.size.height * screenSize.width / animatedImage.size.width);
    self.GIFImageView.animatedImage = animatedImage;
    NSURL *soundUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                  pathForResource:soundName
                                  ofType:@"mp3"]];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl
                                                         error:nil];
    audioPlayer.numberOfLoops = -1;
    [audioPlayer play];
}
- (void)clickButtonClicked {
    watchButton.hidden = TRUE;
    listenButton.hidden = TRUE;
    clickButton.hidden = TRUE;
    introButton.hidden = TRUE;
    backButton.hidden = FALSE;
    nextButton.hidden = TRUE;
    dogeButton.hidden = FALSE;
    levelLabel.hidden = FALSE;
    scoreLabel.hidden = FALSE;
    titleLabel.hidden = FALSE;
    dogecoinImageView.hidden = FALSE;
    gestureRecognizer.enabled = NO;
    gestureRecognizer2.enabled = NO;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int level = (int)[defaults integerForKey:@"level"];
    levelLabel.text = [NSString stringWithFormat:@"Level: %d", level];
    int score = (int)[defaults integerForKey:@"score"];
    scoreLabel.text = [NSString stringWithFormat:@"%d", score];
    titleLabel.text = level2Title[level];
    self.GIFImageView.hidden = NO;
    int heightOffset480 = (double)480 / 568 * screenSize.height;
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"space" withExtension:@"gif"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    FLAnimatedImage *animatedImage = [FLAnimatedImage animatedImageWithGIFData:data];
    self.GIFImageView.frame = CGRectMake(0.0, 0.0, screenSize.width, heightOffset480);
    self.GIFImageView.animatedImage = animatedImage;
    double level2Interval[10] = {2.2,2.0,1.8,1.6,1.4,1.2,1.0,0.8,0.7,0.6};
    timer = [NSTimer scheduledTimerWithTimeInterval:level2Interval[level]
                                             target:self
                                           selector:@selector(onTick:)
                                           userInfo:nil
                                            repeats:YES];
    [timer fire];
    backButton.titleLabel.textColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
}
- (void)backButtonClicked {
    int heightOffset480 = (double)480 / 568 * screenSize.height;
    watchButton.hidden = FALSE;
    listenButton.hidden = FALSE;
    clickButton.hidden = FALSE;
    introButton.hidden = FALSE;
    backButton.hidden = TRUE;
    nextButton.hidden = TRUE;
    dogeButton.hidden = TRUE;
    levelLabel.hidden = TRUE;
    scoreLabel.hidden = TRUE;
    titleLabel.hidden = TRUE;
    dogecoinImageView.hidden = TRUE;
    self.GIFImageView.hidden = NO;
    gestureRecognizer.enabled = NO;
    gestureRecognizer2.enabled = NO;
    backButton.titleLabel.textColor = [UIColor whiteColor];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"gif"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    FLAnimatedImage *animatedImage = [FLAnimatedImage animatedImageWithGIFData:data];
    self.GIFImageView.frame = CGRectMake(0.0, 0.0, screenSize.width, heightOffset480);
    self.GIFImageView.animatedImage = animatedImage;
    self.view.backgroundColor = [UIColor whiteColor];
    [audioPlayer stop];
    [timer invalidate];
    timer = nil;
}
- (void)nextButtonClicked {
    int heightOffset150 = (double)150 / 568 * screenSize.height;
    int heightOffset50 = (double)50 / 568 * screenSize.height;
    int i = arc4random_uniform(126) + 1;
    NSString *gifName = [NSString stringWithFormat:@"%d",i];
    NSURL *url = [[NSBundle mainBundle] URLForResource:gifName withExtension:@"gif"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    FLAnimatedImage *animatedImage = [FLAnimatedImage animatedImageWithGIFData:data];
    if (i != 8 && i != 100 & i != 102)
        self.GIFImageView.frame = CGRectMake(0.0, heightOffset150, screenSize.width, animatedImage.size.height * screenSize.width / animatedImage.size.width);
    else
        self.GIFImageView.frame = CGRectMake(0.0, heightOffset50, screenSize.width, animatedImage.size.height * screenSize.width / animatedImage.size.width);
    self.GIFImageView.animatedImage = animatedImage;
}
- (void)dogeButtonClicked {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    int level = (int)[defaults integerForKey:@"level"];
//    levelLabel.text = [NSString stringWithFormat:@"Level: %d", level];
    int score = (int)[defaults integerForKey:@"score"] + 1;
    int level = (int) log10(score);
    scoreLabel.text = [NSString stringWithFormat:@"%d", score];
    levelLabel.text = [NSString stringWithFormat:@"Level: %d",level];
    titleLabel.text = level2Title[level];
    [defaults setInteger:score forKey:@"score"];
    [defaults setInteger:level forKey:@"level"];
}
- (void)onTick:(NSTimer *)timer {
    double level2Size[10] = {70,65,60,55,50,45,40,35,30,25};
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int level = (int)[defaults integerForKey:@"level"];
    int heightOffset44 = (double)44 / 568 * screenSize.height;
    int heightOffsetdoge = level2Size[level] / 568 * screenSize.height;
    int x = arc4random_uniform(screenSize.width - heightOffsetdoge);
    int y = arc4random_uniform(screenSize.height - heightOffset44 * 2 - heightOffsetdoge);
    dogeButton.frame = CGRectMake(x, y, heightOffsetdoge, heightOffsetdoge);
    [dogeButton setImage:[UIImage imageNamed:@"doge.png"] forState:UIControlStateNormal];
}
- (void)introButtonClicked {
    watchButton.enabled = FALSE;
    listenButton.enabled = FALSE;
    clickButton.enabled = FALSE;
    introButton.enabled = FALSE;
    gr.enabled = NO;
    hasStarted = 1;
    [UIView animateWithDuration:1.0f
                     animations:^{
                         introImageView.frame = CGRectMake((screenSize.width - 320) / 2, (screenSize.height - 480) / 2, 320, 480);
                         self.GIFImageView.alpha = 0.5; }
                     completion:^(BOOL finished) {
                         gr.enabled = YES;
                     }];
}
- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer {

    if (hasStarted) {
        [UIView animateWithDuration:1.0f animations:^{
            introImageView.frame = CGRectMake(0, -screenSize.height, 320, 480);
            self.GIFImageView.alpha = 1;
        } completion:^(BOOL finished) {
            introImageView.frame = CGRectMake(0.0, screenSize.height, 320, 480);
            watchButton.enabled = TRUE;
            listenButton.enabled = TRUE;
            clickButton.enabled = TRUE;
            introButton.enabled = TRUE;
        }];
        hasStarted = 0;
    }
}
-(void)swipeHandler:(UISwipeGestureRecognizer *)recognizer {
    [self nextButtonClicked];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
