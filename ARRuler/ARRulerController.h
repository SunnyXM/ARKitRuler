//
//  ARRulerController.h
//  MySmartHome
//
//  Created by XM on 2017/10/19.
//  Copyright © 2017年 my. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ARKit/ARKit.h>
#import <SceneKit/SceneKit.h>

@interface ARRulerController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *addView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet ARSCNView *scnView;

@property (weak, nonatomic) IBOutlet UIButton *resetBtn;
- (IBAction)resetBtnClick:(id)sender;

@end
