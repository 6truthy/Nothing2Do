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

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if (!self.GIFImageView) {
        self.GIFImageView = [[FLAnimatedImageView alloc] init];
        self.GIFImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.GIFImageView.clipsToBounds = YES;
    }
    [self.view addSubview:self.GIFImageView];
    self.GIFImageView.frame = CGRectMake(0.0, 120.0, 360, 120);

    NSURL *url = [[NSBundle mainBundle] URLForResource:@"1" withExtension:@"gif"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    FLAnimatedImage *animatedImage = [FLAnimatedImage animatedImageWithGIFData:data];
    self.GIFImageView.animatedImage = animatedImage;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
