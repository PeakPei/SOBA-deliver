//
//  mainSKScene.m
//  SOBA
//
//  Created by 志水 亮介 on 2014/07/23.
//  Copyright (c) 2014年 companyName. All rights reserved.
//

#import "mainSKScene.h"
//タイトル画面のtitleSKScene.hをimportする
#import "titleSKScene.h"

@interface mainSKScene() {
    // あとで使えるように終了ラベルを宣言する
    SKLabelNode *exitSKLabel;
    // 落とすせいろの番号を宣言する
    int seiroID;
    // プラグラム上（node）にも、せいろに名前を宣言する
    SKSpriteNode *soba;
}
@end

SKAction *SEAction2;
SKAction *SEAction3;

@implementation mainSKScene

-(instancetype)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        // 背景に色をつける
        self.backgroundColor = [UIColor colorWithRed:0.612 green:0.612 blue:0.612 alpha:1];
        
        // 「やめる」ラベルを作って表示する
        exitSKLabel = [SKLabelNode labelNodeWithFontNamed:@"uzura_font"];
        exitSKLabel.text = @"やめる";
        exitSKLabel.position = CGPointMake(80, size.height - 80);
        [self addChild:exitSKLabel];
        
        // 物理シミュレーションの空間を用意する
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, size.width, size.height)];
        
        // 空き缶を作って画面に登場させる
        SKSpriteNode *stick1 = [SKSpriteNode spriteNodeWithImageNamed:@"can"];
        stick1.position = CGPointMake(160, 80);
        stick1.size = CGSizeMake(11,30);
        SKPhysicsBody *pbody1 = [SKPhysicsBody bodyWithRectangleOfSize:stick1.size];
        stick1.physicsBody = pbody1;
        [self addChild:stick1];
        
        // バイト猫を作って画面に登場させる
        SKSpriteNode *stick2 = [SKSpriteNode spriteNodeWithImageNamed:@"sobaya"];
        stick2.position = CGPointMake(160, 160);
        stick2.size = CGSizeMake(60, 150);
        SKPhysicsBody *pbody2 = [SKPhysicsBody bodyWithRectangleOfSize:stick2.size];
        stick2.physicsBody = pbody2;
        [self addChild:stick2];
        
        // そばせいろを作って画面に登場させる
        soba = [SKSpriteNode spriteNodeWithImageNamed:@"seiro"];
        soba.position = CGPointMake(160, 220);
        soba.size = CGSizeMake(110, 15);
        SKPhysicsBody *pbody3 = [SKPhysicsBody bodyWithRectangleOfSize:soba.size];
        soba.physicsBody = pbody3;
        [self addChild:soba];
        
        // せいろ番号のリセット
        seiroID = 0;
        
        //SEを設定
        SEAction2 = [SKAction playSoundFileNamed:@"kaere.m4a" waitForCompletion:NO];
        SEAction3 = [SKAction playSoundFileNamed:@"kora.m4a" waitForCompletion:NO];
        
        //BGMを設定
        NSError* error;
        
        NSURL* URL2 = [[NSBundle mainBundle]URLForResource:@"kaere"withExtension:@"m4a"];
        self.bgm2 = [[AVAudioPlayer alloc]initWithContentsOfURL:URL2 error:&error];
        
        NSURL* URL3 = [[NSBundle mainBundle]URLForResource:@"kora"withExtension:@"m4a"];
        self.bgm2 = [[AVAudioPlayer alloc]initWithContentsOfURL:URL3 error:&error];
        
        self.bgm2.numberOfLoops = -1;
        [self.bgm2 prepareToPlay];
        
    }
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 積み上げるせいろの配列を用意する
    NSArray *bgname = @[@"seiro",@"seiro",@"seiro",@"seiro",@"seiro",@"seiro",@"seiro",@"seiro",@"seiro"];
    
    // タッチした座標を調べる
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    // 「やめる」ラベルをタッチしていたら、タイトルシーンにドアが閉じるように切り替える
    if ([exitSKLabel containsPoint:location]) {
        titleSKScene *scene = [[titleSKScene alloc] initWithSize:self.size];
        SKTransition *transition = [SKTransition doorsCloseHorizontalWithDuration:0.5];
        [self.view presentScene:scene transition:transition];
        
        //「帰れ！」という声を出す
        [self runAction:SEAction2];
        
    } else {
        
        // 「やめる」ラベル以外をタッチしたとき、せいろ番号がせいろの数より少なければ実行
        if (seiroID < bgname.count) {
            
            // せいろを画面に登場させる
            SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:bgname[seiroID]];
            sprite.position = location;
            sprite.size = CGSizeMake(110, 15);
            SKPhysicsBody *pbody = [SKPhysicsBody bodyWithRectangleOfSize:sprite.size];
            sprite.physicsBody = pbody;
            [self addChild:sprite];
        }
        // せいろIDのカウントアップ
        seiroID = seiroID + 1;
    }
}


// 毎回の画面更新時にチェック
-(void)update:(NSTimeInterval)currentTime {
    
    // ゲーム中のとき
    if (seiroID < 99) {
        
        // せいろが下に落ちてしまったら
        if (soba.position.y < 180) {
            
            // せいろIDを99にして落とせなくする＆ゲームオーバーとする
            seiroID = 99;
            
            // 「ばかやろう！」ラベルを表示する
            SKLabelNode *endSKLabel = [SKLabelNode labelNodeWithFontNamed:@"uzura_font"];
            endSKLabel.text = @"ばかやろう！";
            endSKLabel.position = CGPointMake(160, 300);
            [self addChild:endSKLabel];
            
            //「こら！」という声を出す
            [self runAction:SEAction3];
        }
    }
}

@end
