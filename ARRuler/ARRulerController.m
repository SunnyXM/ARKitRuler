//
//  ARRulerController.m
//  MySmartHome
//
//  Created by XM on 2017/10/19.
//  Copyright © 2017年 my. All rights reserved.
//

#import "ARRulerController.h"

#import "ARLine.h"
@interface ARRulerController ()<ARSCNViewDelegate,ARSessionDelegate>

@property(nonatomic,strong)ARSession *arSession;

@property(nonatomic,strong)ARWorldTrackingConfiguration *arSessionConfiguration;

@property(nonatomic,assign)SCNVector3 vectorZero;

@property(nonatomic,assign)SCNVector3 vectorStart;

@property(nonatomic,assign)SCNVector3 vectorStop;

@property(nonatomic,strong)ARLine *currentLine;

@property(nonatomic,strong)NSMutableArray *arLines;

@property(nonatomic,assign)BOOL isMuseing;

@end

@implementation ARRulerController


- (void)viewDidLoad {
    [super viewDidLoad];
     _scnView.delegate = self;
     _scnView.showsStatistics = YES;
    _scnView.autoenablesDefaultLighting = YES;
    _scnView.session = self.arSession;
    self.vectorZero = SCNVector3Zero;
    // Do any additional setup after loading the view from its nib.
}

#pragma mark Getter

-(ARSession *)arSession{
    if (_arSession == nil) {
        _arSession = [[ARSession alloc] init];
        _arSession.delegate = self;
    }
    return _arSession;
}

-(NSMutableArray *)arLines{
    if (_arLines == nil) {
        _arLines = [NSMutableArray array];
    }
    return _arLines;
}
-(ARWorldTrackingConfiguration *)arSessionConfiguration{
    if (_arSessionConfiguration == nil) {
        
        _arSessionConfiguration = [[ARWorldTrackingConfiguration alloc] init];
        
        _arSessionConfiguration.planeDetection = ARPlaneDetectionHorizontal;
        
        _arSessionConfiguration.lightEstimationEnabled = YES;
        
    }
    return _arSessionConfiguration;
}

-(void)reset{
    self.vectorStart = SCNVector3Zero;
    self.vectorStop = SCNVector3Zero;
    self.isMuseing = YES;
}

-(void)worldPosition{

    SCNVector3 worldP = SCNVector3Zero;
    NSArray *results = [self.scnView hitTest:self.view.center types:ARHitTestResultTypeFeaturePoint];
    
    if (results.count<=0) {
        worldP =  SCNVector3Zero;
    }
    ARHitTestResult *result = results.firstObject;
    worldP = SCNVector3Make(result.worldTransform.columns[3].x,result.worldTransform.columns[3].y, result.worldTransform.columns[3].z);

    if (_arLines.count<=0) {
        self.infoLabel.text = @"点击屏幕开始测距";
    }
    
    if (self.isMuseing) {

        if (self.vectorStart.x == self.vectorZero.x && self.vectorStart.y == self.vectorZero.y && self.vectorStart.z == self.vectorZero.z) {
            self.vectorStart = worldP;
            self.currentLine = [[ARLine alloc] initWithScnView:self.scnView scnVector:self.vectorStart unit:100.0];
            
        }
        self.vectorStop = worldP;
        [self.currentLine upDateToVector:self.vectorStop];
        self.infoLabel.text = [NSString stringWithFormat:@"%f",[self.currentLine destanceWithVector:self.vectorStop]];

        
    }
   
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!self.isMuseing) {
        self.isMuseing = YES;
        self.vectorStart = SCNVector3Zero;
        self.vectorStop = SCNVector3Zero;
        self.addView.image = [UIImage imageNamed:@"GreenImage"];
    }else{
        self.addView.image = [UIImage imageNamed:@"WhiteImage"];
        self.isMuseing = NO;
        if (self.currentLine) {
            [self.arLines addObject:self.currentLine];
            self.currentLine = nil ;
        }
    }
    
    
}

-(void)renderer:(id<SCNSceneRenderer>)renderer updateAtTime:(NSTimeInterval)time{
    
    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"time:%f",time);
         [self worldPosition];
        
    });
   
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.arSession runWithConfiguration:self.arSessionConfiguration options:ARSessionRunOptionRemoveExistingAnchors];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.arSession pause];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Action

- (IBAction)resetBtnClick:(id)sender {
    for (ARLine *line in _arLines) {
        [line remove];
    }
    [_arLines removeAllObjects];
}
@end









