//
//  CPFTopicVoiceView.m
//  百思不得姐
//
//  Created by cuipengfei on 16/7/14.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "CPFTopicVoiceView.h"
#import "CPFShowPictureController.h"

@interface CPFTopicVoiceView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;


@end

@implementation CPFTopicVoiceView

+ (instancetype)voiceView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

// 模态视图显示图片
- (void)showPictuer {
    CPFShowPictureController *showPicture = [[CPFShowPictureController alloc] init];
    showPicture.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}

- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
    
    // 图片交互
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPictuer)]];
}

- (void)setTopic:(CPFTopic *)topic {
    _topic = topic;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    self.playTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute, second];
}

@end
