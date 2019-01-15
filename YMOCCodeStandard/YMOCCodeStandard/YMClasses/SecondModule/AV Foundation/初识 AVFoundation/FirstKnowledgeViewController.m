//
//  FirstKnowledgeViewController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2019/1/14.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "FirstKnowledgeViewController.h"

#import "THSpeechController.h"

@interface FirstKnowledgeViewController ()

@end

@implementation FirstKnowledgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"初识 AVFoundation";
}

#pragma mark 会话
- (void)speechDemo {
    AVSpeechSynthesizer *synthesizer = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:@"Hello World"];
    [synthesizer speakUtterance:utterance];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[THSpeechController speechController] beginConversation];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
