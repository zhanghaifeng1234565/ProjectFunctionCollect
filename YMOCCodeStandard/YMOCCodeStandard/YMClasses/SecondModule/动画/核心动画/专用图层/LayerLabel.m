//
//  LayerLabel.m
//  YMOCCodeStandard
//
//  Created by iOS on 2019/1/2.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "LayerLabel.h"

@interface LayerLabel ()

/// 文本图层
@property (nonatomic, readwrite, strong) CATextLayer *textLayer;

@end

@implementation LayerLabel

+ (Class)layerClass {
    return [CATextLayer class];
}

- (CATextLayer *)textLayer {
    return (CATextLayer *)self.layer;
}

- (void)setUp {
    self.text = self.text;
    self.textColor = self.textColor;
    self.font = self.font;
    
    [self textLayer].alignmentMode = kCAAlignmentJustified;
    [self textLayer].wrapped = YES;
    [self.layer display];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUp];
}

- (void)setText:(NSString *)text {
    super.text = text;
    [self textLayer].string = text;
}

- (void)setTextColor:(UIColor *)textColor {
    super.textColor = textColor;
    [self textLayer].foregroundColor = textColor.CGColor;
}

- (void)setFont:(UIFont *)font {
    super.font = font;
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    [self textLayer].font = fontRef;
    [self textLayer].fontSize = font.pointSize;
    CGFontRelease(fontRef);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
