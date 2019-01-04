//
//  SpecialLayerViewController.m
//  YMOCCodeStandard
//
//  Created by iOS on 2019/1/2.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "SpecialLayerViewController.h"
#import "RefectionView.h"

@interface SpecialLayerViewController ()

/// 背景滚动视图
@property (nonatomic, readwrite, strong) UIScrollView *scrollView;
/// 火柴人视图
@property (nonatomic, readwrite, strong) UIView *matchesView;
/// textLayer
@property (nonatomic, readwrite, strong) UIView *labelView;
/// 颜色渐变视图
@property (nonatomic, readwrite, strong) UIView *gradientView;
/// 重复视图
@property (nonatomic, readwrite, strong) RefectionView *repeatView;
/// 粒子效果视图
@property (nonatomic, readwrite, strong) UIView *emitterView;

/// gl 视图
@property (nonatomic, readwrite, strong) UIView *glView;
@property (nonatomic, readwrite, strong) EAGLContext *glContent;
@property (nonatomic, readwrite, strong) CAEAGLLayer *glLayer;
@property (nonatomic, readwrite, assign) GLuint framebuffer;
@property (nonatomic, readwrite, assign) GLuint colorRenderbuffer;
@property (nonatomic, readwrite, assign) GLint framebufferWidth;
@property (nonatomic, readwrite, assign) GLint framebufferHeight;
@property (nonatomic, readwrite, strong) GLKBaseEffect *effect;

/// 视频播放视图
@property (nonatomic, readwrite, strong) UIView *playerView;

@end

@implementation SpecialLayerViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self tearDownBuffers];
    [EAGLContext setCurrentContext:nil];
}

- (instancetype)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    }
    return self;
}

- (void)orientChange:(NSNotification *)noti {
    [self layoutSubviews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"专用图层";
}

#pragma mark - - 加载视图
- (void)loadSubviews {
    [super loadSubviews];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.matchesView];
    [self.scrollView addSubview:self.labelView];
    [self.scrollView addSubview:self.gradientView];
    [self.scrollView addSubview:self.repeatView];
    [self.scrollView addSubview:self.emitterView];
    [self.scrollView addSubview:self.glView];
    [self.scrollView addSubview:self.playerView];
}

#pragma mark - - 配置属性
- (void)configSubviews {
    [super configSubviews];
    
    self.matchesView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.labelView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.repeatView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.emitterView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.glView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.playerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

#pragma mark - - 布局视图
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.scrollView.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenHeight - NavBarHeight);
    self.matchesView.frame = CGRectMake((MainScreenWidth - 250) / 2, 30, 250, 250);
    self.labelView.frame = CGRectMake(15, self.matchesView.bottom + 30, MainScreenWidth - 30, 300);
    self.gradientView.frame = CGRectMake((MainScreenWidth - 200) / 2, self.labelView.bottom + 30, 200, 200);
    self.repeatView.frame = CGRectMake((MainScreenWidth - 50) / 2, self.gradientView.bottom + 30, 50, 50);
    self.emitterView.frame = CGRectMake(0, self.repeatView.bottom + 100, MainScreenWidth, 100);
    self.glView.frame = CGRectMake(15, self.emitterView.bottom + 30, MainScreenWidth - 30, 300);
    self.playerView.frame = CGRectMake(15, self.glView.bottom + 30, MainScreenWidth - 30, 300);
    
    self.scrollView.contentSize = CGSizeMake(MainScreenWidth, self.playerView.bottom + 50);
    
    // 绘制火柴人
    [self graphicsMatches];
    // 圆角矩形
    [self graphicsCornerCube];
    // view textLayer 画文本
    [self crateLabelTextLayer];
    // view textLayer 画富文本
    [self createNSAttributeTextLayer];
    // 渐变视图
    [self graphicsGradientView];
    // 重复图层
    [self graphicsRepeatLayer];
    // 粒子效果
    [self emitterLayer];
    // gl 视图
    [self graphicsGLView];
    // 视频播放
    [self graphicsPlayerLayer];
}

#pragma mark - - 绘制火柴人
- (void)graphicsMatches {
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(self.matchesView.width / 2, 100)];
    
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    [path moveToPoint:CGPointMake(150, 125)];
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    
    [self.matchesView.layer addSublayer:shapeLayer];
}

#pragma mark - - 绘制圆角矩形
- (void)graphicsCornerCube {
    CGRect rect = CGRectMake(0, 0, self.matchesView.width, self.matchesView.height);
    CGSize size = CGSizeMake(20, 20);
    UIRectCorner corners = UIRectCornerTopRight | UIRectCornerTopLeft | UIRectCornerBottomLeft;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:size];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    [self.matchesView.layer addSublayer:shapeLayer];
}

#pragma mark textLayer 创建一个 label
- (void)crateLabelTextLayer {
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = self.labelView.bounds;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.labelView.layer addSublayer:textLayer];
    
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
    
    UIFont *font = [UIFont systemFontOfSize:15];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    
    NSString *text = @"锄禾日当午，汗滴禾下土。谁知盘中餐，粒粒皆辛苦。锄禾日当午，汗滴禾下土。谁知盘中餐，粒粒皆辛苦。锄禾日当午，汗滴禾下土。谁知盘中餐，粒粒皆辛苦。锄禾日当午，汗滴禾下土。谁知盘中餐，粒粒皆辛苦。锄禾日当午，汗滴禾下土。谁知盘中餐，粒粒皆辛苦。锄禾日当午，汗滴禾下土。谁知盘中餐，粒粒皆辛苦。锄禾日当午，汗滴禾下土。谁知盘中餐，粒粒皆辛苦。锄禾日当午，汗滴禾下土。谁知盘中餐，粒粒皆辛苦。";
    textLayer.string = text;
}

#pragma mark textLayer 创建一个 label 富文本
- (void)createNSAttributeTextLayer {
    CATextLayer *textLayer = [[CATextLayer alloc] init];
    textLayer.frame = self.labelView.bounds;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.labelView.layer addSublayer:textLayer];
    
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
    
    UIFont *font = [UIFont systemFontOfSize:15];
    
    NSString *text = @"锄禾日当午，汗滴禾下土。谁知盘中餐，粒粒皆辛苦。锄禾日当午，汗滴禾下土。谁知盘中餐，粒粒皆辛苦。锄禾日当午，汗滴禾下土。谁知盘中餐，粒粒皆辛苦。锄禾日当午，汗滴禾下土。谁知盘中餐，粒粒皆辛苦。锄禾日当午，汗滴禾下土。谁知盘中餐，粒粒皆辛苦。锄禾日当午，汗滴禾下土。谁知盘中餐，粒粒皆辛苦。锄禾日当午，汗滴禾下土。谁知盘中餐，粒粒皆辛苦。锄禾日当午，汗滴禾下土。谁知盘中餐，粒粒皆辛苦。";
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
    
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFloat fontSize = font.pointSize;
    CTFontRef fontRef = CTFontCreateWithName(fontName, fontSize, NULL);
    
    NSDictionary *attribs = @{(__bridge id)kCTForegroundColorAttributeName : (__bridge id)[UIColor blackColor].CGColor,
                              (__bridge id)kCTFontAttributeName : (__bridge id)fontRef
                                  };
    [attString setAttributes:attribs range:NSMakeRange(0, [text length])];
    
    attribs = @{(__bridge id)kCTForegroundColorAttributeName : (__bridge id)[UIColor blueColor].CGColor,
                (__bridge id)kCTFontAttributeName : (__bridge id)fontRef,
                (__bridge id)kCTUnderlineStyleAttributeName : @(kCTUnderlineStyleSingle)};
    [attString setAttributes:attribs range:NSMakeRange(6, 5)];
    
    CFRelease(fontRef);
    
    textLayer.string = attString;
}

#pragma mark 渐变视图
- (void)graphicsGradientView {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.gradientView.bounds;
    [self.gradientView.layer addSublayer:gradientLayer];
    
    // 渐变颜色
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor blueColor].CGColor];
    
    // 渐变范围可以不设置
    gradientLayer.locations = @[@0.0, @0.25, @0.5];
    
    // 左上角开始
    gradientLayer.startPoint = CGPointMake(0, 0);
    // 右下角结束
    gradientLayer.endPoint = CGPointMake(1, 1);
}

#pragma mark 创建重复图层
- (void)graphicsRepeatLayer { // 创建重复视图失败，原因不明。
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = self.repeatView.bounds;
    [self.repeatView.layer addSublayer:replicatorLayer];
    
    replicatorLayer.repeatCount = 10;
    replicatorLayer.backgroundColor = [UIColor redColor].CGColor;
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DMakeTranslation(0, 50, 0);
    transform = CATransform3DRotate(transform, M_PI / 5.0, 0, 0, 1);
    transform = CATransform3DTranslate(transform, 0, -50, 0);
    replicatorLayer.instanceTransform = transform;
    
    replicatorLayer.instanceBlueOffset = -0.1;
    replicatorLayer.instanceGreenOffset = -0.1;

    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(50, 50, 50, 50);
    layer.backgroundColor = [UIColor blueColor].CGColor;
    [replicatorLayer addSublayer:layer];
}

#pragma mark 粒子效果
- (void)emitterLayer {
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    emitterLayer.frame = self.emitterView.bounds;
    [self.emitterView.layer addSublayer:emitterLayer];
    
//    emitterLayer.renderMode = kCAEmitterLayerAdditive;
    emitterLayer.emitterPosition = CGPointMake((MainScreenWidth - 40) / 2, 60);
    
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id)[UIImage imageNamed:@"yellow_star"].CGImage;
    cell.birthRate = 20;
    cell.lifetime = 5.0;
    cell.color = [UIColor colorWithRed:1.0 green:0.5 blue:0.1 alpha:1.0f].CGColor;
    cell.alphaSpeed = -0.4;
    cell.velocity = 20;
    cell.velocityRange = M_PI * 2;
    
    CAEmitterCell *cell1 = [[CAEmitterCell alloc] init];
    cell1.contents = (__bridge id)[UIImage imageNamed:@"forward_resumes_blue_btn"].CGImage;
    cell1.birthRate = 20;
    cell1.lifetime = 5.0;
    cell1.color = [UIColor colorWithRed:1.0 green:0.5 blue:0.1 alpha:1.0f].CGColor;
    cell1.alphaSpeed = -0.4;
    cell1.velocity = 20;
    cell1.velocityRange = M_PI * 2;
    
    emitterLayer.emitterCells = @[cell, cell1];
}

#pragma mark gl 视图 效果没有实现 暂不清楚原因
- (void)graphicsGLView {
    self.glContent = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
    [EAGLContext setCurrentContext:self.glContent];
    
    self.glLayer = [CAEAGLLayer layer];
    self.glLayer.frame = self.glView.bounds;
    [self.glView.layer addSublayer:self.glLayer];
    
//    self.glLayer.drawableProperties = @{kEAGLDrawablePropertyRetainedBacking:@"fff"};
    
    self.effect = [[GLKBaseEffect alloc] init];
    
    [self setUpBuffers];
    [self drawFrame];
}

- (void)setUpBuffers {
    glGenFramebuffers(1, &_framebuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
    
    glGenRenderbuffers(1, &_colorRenderbuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderbuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _colorRenderbuffer);
    [self.glContent renderbufferStorage:GL_RENDERBUFFER fromDrawable:nil];
    
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &_framebufferWidth);
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &_framebufferHeight);
    
    if (glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE) {
        NSLog(@"failed to make complete framebuffer object:");
    }
}

- (void)tearDownBuffers {
    if (_framebuffer) {
        glDeleteFramebuffers(1, &_framebuffer);
        _framebuffer = 0;
    }
    
    if (_colorRenderbuffer) {
        glDeleteRenderbuffers(1, &_colorRenderbuffer);
        _colorRenderbuffer = 0;
    }
}

- (void)drawFrame {
    glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
    glViewport(0, 0, _framebufferWidth, _framebufferHeight);
    
    [self.effect prepareToDraw];
    
    glClear(GL_COLOR_BUFFER_BIT);
    glClearColor(0.0, 0.0, 0.0, 1);
    
    GLfloat vertices[] = {
      -0.5f, -0.5f, -1.0f, 0.0f, 0.5f, -1.0f, 0.5f, -0.5f, 1.0f
    };
    
    GLfloat colors[] = {
        0.0f, 0.0f, 1.0f, 1.0f, 0.0f, 1.0f, 0.0f, 1.0f, 1.0f, 0.0f
    };
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glEnableVertexAttribArray(GLKVertexAttribColor);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, GL_FLOAT, vertices);
    glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, GL_FLOAT, colors);
    glDrawArrays(GL_TRIANGLES, 0, 3);
    
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderbuffer);
    [self.glContent presentRenderbuffer:GL_RENDERBUFFER];
}

#pragma mark 视频播放
- (void)graphicsPlayerLayer {
    NSURL *URL = [[NSBundle mainBundle] URLForResource:@"IMG_4303" withExtension:@"MOV"];
    
    AVPlayer *player = [AVPlayer playerWithURL:URL];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    playerLayer.frame = self.playerView.bounds;
    [self.playerView.layer addSublayer:playerLayer];
    
    CATransform3D transfrom = CATransform3DIdentity;
    transfrom.m34 = -1.0 / 500.0;
    transfrom = CATransform3DRotate(transfrom, M_PI_4, 1, 1, 1);
    playerLayer.transform = transfrom;
    
    playerLayer.masksToBounds = YES;
    playerLayer.cornerRadius = 20.0f;
    playerLayer.borderColor = [UIColor redColor].CGColor;
    playerLayer.borderWidth = 5.0f;
    
    [player play];
}

#pragma mark - - lazyLoadUI
- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}

- (UIView *)matchesView {
    if (_matchesView == nil) {
        _matchesView = [[UIView alloc] init];
    }
    return _matchesView;
}

- (UIView *)labelView {
    if (_labelView == nil) {
        _labelView = [[UIView alloc] init];
    }
    return _labelView;
}

- (UIView *)gradientView {
    if (_gradientView == nil) {
        _gradientView = [[UIView alloc] init];
    }
    return _gradientView;
}

- (RefectionView *)repeatView {
    if (_repeatView == nil) {
        _repeatView = [[RefectionView alloc] init];
    }
    return _repeatView;
}

- (UIView *)emitterView {
    if (_emitterView == nil) {
        _emitterView = [[UIView alloc] init];
    }
    return _emitterView;
}

- (UIView *)glView {
    if (_glView == nil) {
        _glView = [[UIView alloc] init];
    }
    return _glView;
}

- (UIView *)playerView {
    if (_playerView == nil) {
        _playerView = [[UIView alloc] init];
    }
    return _playerView;
}

@end
