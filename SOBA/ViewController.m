//
//  ViewController.m
//  SOBA
//
//  Created by 志水 亮介 on 2014/07/21.
//  Copyright (c) 2014年 companyName. All rights reserved.
//

#import "ViewController.h"

//タイトルシーンのtitleSKScene.hをimportする
#import "titleSKScene.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	//SKviewを利用する
    SKView *skView = (SKView *)self.view;
    //SKSceneを作る
    SKScene *scene = [titleSKScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    //SKviewに作ったシーンを表示する
    [skView presentScene:scene];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//ステータスバーを非表示
-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end
