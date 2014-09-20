//
//  titleSKScene.m
//  SOBA
//
//  Created by 志水 亮介 on 2014/07/22.
//  Copyright (c) 2014年 companyName. All rights reserved.
//

#import "titleSKScene.h"
//タイトル画面のmainSKScene.hをimportする
#import "mainSKScene.h"

@interface titleSKScene(){
    //スタート用のラベルを用意する
    SKLabelNode *startSKLabel;
}
@end

SKAction *SEAction1;

@implementation titleSKScene

-(instancetype)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        
        //背景色を設定する
        self.backgroundColor = [UIColor colorWithRed:0 green:0.392 blue:0 alpha:1];
        
        //タイトルを作って追加する(画面中央より50上の位置)
        SKLabelNode *mySKLabel = [SKLabelNode labelNodeWithFontNamed:@"uzura_font"];
        mySKLabel.text = @"そば屋のバイト";
        mySKLabel.position = CGPointMake(size.width/2, size.height/2 + 50);
        [self addChild:mySKLabel];
        
        //スタートラベルを作って追加する（画面中央より１００下の位置）
        startSKLabel = [SKLabelNode labelNodeWithFontNamed:@"uzura_font"];
        startSKLabel.text = @"配達訓練スタート";
        startSKLabel.position = CGPointMake(size.width/2, size.height/2 - 100);
        [self addChild:startSKLabel];
        
        //SEを設定
        SEAction1 = [SKAction playSoundFileNamed:@"j_drum.mp3" waitForCompletion:NO];
        
        //BGMを設定
        NSError* error;
        NSURL* URL = [[NSBundle mainBundle]URLForResource:@"j_drum"withExtension:@"mp3"];
        self.bgm1 = [[AVAudioPlayer alloc]initWithContentsOfURL:URL error:&error];
        self.bgm1.numberOfLoops = -1;
        [self.bgm1 prepareToPlay];
        
    }
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //タッチした座標を取得して、
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    //スタートラベルをタッチしたら
    if ([startSKLabel containsPoint:location]) {
        
        //メイン画面を作り、
        mainSKScene *scene = [[mainSKScene alloc] initWithSize:self.size];
        
        //ドアが開くように切り替える
        SKTransition *transition = [SKTransition doorsOpenHorizontalWithDuration:0.5];
        [self.view presentScene:scene transition:transition];
        
        //太鼓の効果音を出す
        [self runAction:SEAction1];
    }
}

@end