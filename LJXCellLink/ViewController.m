//
//  ViewController.m
//  LJXCellLink
//
//  Created by 栾金鑫 on 2019/9/12.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import "ViewController.h"
#import "LJXModel.h"
#import "LJXCell.h"

@interface ViewController () <UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , strong) UITableView * tableView;
/* 数据源 */
@property(nonatomic,strong) NSMutableArray * dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview: self.tableView];
    
    [self getDataFromNet];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count > 0 ? self.dataArray.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"cellId";
    LJXCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[LJXCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    if (self.dataArray.count > 0) {
        cell.model = self.dataArray[indexPath.row];
    }
    __weak typeof (self) weakSelf = self;
    [cell doRefreshModel:^(LJXModel* model, NSInteger rowNum, NSInteger sectionNum) {
        
        LJXModel * ljxmodel = (LJXModel *)model;
        ljxmodel.isOpen = !ljxmodel.isOpen;
        //刷新选中的某一行
        [weakSelf.dataArray replaceObjectAtIndex:indexPath.row withObject:ljxmodel];
        [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    LJXModel * model = self.dataArray[indexPath.row];
    if (model.isOpen) {
        //如果是打开的状态  就显示实际需要的高度
       
        return model.msgSize.height + 20;
    }else{
        return 80;
    }
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

//模拟数据
-(void)getDataFromNet{
    NSArray * text = @[@"由于项目需要一个环形渐变进度条显示课程，这方便网上的确有很多相关资料但是，都是比较零散的而且，大多数只是放一堆代码就算完了。这里我想详细写一篇我自己实现这个进度条的过程。实现一个圆弧进度条主要分为三步\n一、画圆弧这里用的贝赛尔曲线，就是这个东西：UIBezierPath",@"由于项目需要一个环形渐变进度条显示课程，这方便网上的确有很多相关资料但是，都是比较零散的而且，大多数只是放一堆代码就算完了。这里我想详细写一篇我自己实现这个进度条的过程。实现一个圆弧进度条主要分为三步\n一、画圆弧这里用的贝赛尔曲线，就是这个东西：UIBezierPath\n二、根据贝塞尔曲线路径画两个圆弧一个底色一个上面的填充色，用到的是这个类CAShapeLayer.h\n三、画两个渐变色块，把上面的进度条路径映射到渐变色块上，渐变色块用的是这个东西习近平对贺一诚获中央政府任命为澳门特别行政区第五任行政长官表示祝贺。习近平说，长期以来，你秉持爱国爱澳立场，热心服务澳门社会，在担任全国人大常委和澳门立法会主席等多个公职期间尽心尽力，为国家改革开放和现代化建设、为澳门繁荣稳定作出了积极贡献。中央对此是充分肯定的。在这次行政长官选举中，你高票提名、高票当选，充分表明澳门社会对你是广泛认同的。习近平表示，今年是澳门回归祖国20周年。20年来，在何厚铧、崔世安两位行政长官带领下，澳门特别行政区政府团结社会各界人士，全面准确理解和贯彻“一国两制”方针，坚定维护宪法和基本法权威，传承爱国爱澳的核心价值观，促进澳门经济快速增长、民生持续改善、社会稳定和谐，向世界展示了具有澳门特色的“一国两制”成功实践。事实证明，“一国两制”是完全行得通、办得到、得人心的！",@"由于项目需要一个环形渐变进度条显示课程，这方便网上的确有很多相关资料但是，都是比较零散的而且，大多数只是放一堆代码就算完了。这里我想详细写一篇我自己实现这个进度条的过程。实现一个圆弧进度条主要分为三步\n一、画圆弧这里用的贝赛尔曲线，就是这个东西：UIBezierPath\n二、根据贝塞尔曲线路径画两个圆弧一个底色一个上面的填充色，用到的是这个类CAShapeLayer.h\n三、画两个渐变色块，把上面的进度条路径映射到渐变色块上，渐变色块用的是这个东西习近平对贺一诚获中央政府任命为澳门特别行政区第五任行政长官表示祝贺。习近平说，长期以来，你秉持爱国爱澳立场，热心服务澳门社会，在担任全国人大常委和澳门立法会主席等多个公职期间尽心尽力，为国家改革开放和现代化建设、为澳门繁荣稳定作出了积极贡献。中央对此是充分肯定的。在这次行政长官选举中，你高票提名、高票当选，充分表明澳门社会对你是广泛认同的。习近平表示，今年是澳门回归祖国20周年。20年来，在何厚铧、崔世安两位行政长官带领下，澳门特别行政区政府团结社会各界人士，全面准确理解和贯彻“一国两制”方针，坚定维护宪法和基本法权威，传承爱国爱澳的核心价值观，促进澳门经济快速增长、民生持续改善、社会稳定和谐，向世界展示了具有澳门特色的“一国两制”成功实践。事实证明，“一国两制”是完全行得通、办得到、得人心的！",@"由于项目需要一个环形渐变进度条显示课程，这方便网上的确有很多相关资料但是，都是比较零散的而且，大多数只是放一堆代码就算完了。这里我想详细写一篇我自己实现这个进度条的过程。实现一个圆弧进度条主要分为三步\n一、画圆弧这里用的贝赛尔曲线，就是这个东西：UIBezierPath\n二、根据贝塞尔曲线路径画两个圆弧一个底色一个上面的填充色，用到的是这个类CAShapeLayer.h\n三、画两个渐变色块，把上面的进度条路径映射到渐变色块上，渐变色块用的是这个东西习近平对贺一诚获中央政府任命为澳门特别行政区第五任行政长官表示祝贺。习近平说，长期以来，你秉持爱国爱澳立场，热心服务澳门社会，在担任全国人大常委和澳门立法会主席等多个公职期间尽心尽力，为国家改革开放和现代化建设、为澳门繁荣稳定作出了积极贡献。中央对此是充分肯定的。在这次行政长官选举中，你高票提名、高票当选，充分表明澳门社会对你是广泛认同的。习近平表示，今年是澳门回归祖国20周年。20年来，在何厚铧、崔世安两位行政长官带领下，澳门特别行政区政府团结社会各界人士，全面准确理解和贯彻“一国两制”方针，坚定维护宪法和基本法权威，传承爱国爱澳的核心价值观，促进澳门经济快速增长、民生持续改善、社会稳定和谐，向世界展示了具有澳门特色的“一国两制”成功实践。事实证明，“一国两制”是完全行得通、办得到、得人心的！",@"由于项目需要一个环形渐变进度条显示课程，这方便网上的确有很多相关资料但是，都是比较零散的而且，大多数只是放一堆代码就算完了。这里我想详细写一篇我自己实现这个进度条的过程。实现一个圆弧进度条主要分为三步\n一、画圆弧这里用的贝赛尔曲线，就是这个东西：UIBezierPath\n二、根据贝塞尔曲线路径画两个圆弧一个底色一个上面的填充色，用到的是这个类CAShapeLayer.h\n三、画两个渐变色块，把上面的进度条路径映射到渐变色块上，渐变色块用的是这个东西习近平对贺一诚获中央政府任命为澳门特别行政区第五任行政长官表示祝贺。习近平说，长期以来，你秉持爱国爱澳立场，热心服务澳门社会，在担任全国人大常委和澳门立法会主席等多个公职期间尽心尽力，为国家改革开放和现代化建设、为澳门繁荣稳定作出了积极贡献。中央对此是充分肯定的。在这次行政长官选举中，你高票提名、高票当选，充分表明澳门社会对你是广泛认同的。习近平表示，今年是澳门回归祖国20周年。20年来，在何厚铧、崔世安两位行政长官带领下，澳门特别行政区政府团结社会各界人士，全面准确理解和贯彻“一国两制”方针，坚定维护宪法和基本法权威，传承爱国爱澳的核心价值观，促进澳门经济快速增长、民生持续改善、社会稳定和谐，向世界展示了具有澳门特色的“一国两制”成功实践。事实证明，“一国两制”是完全行得通、办得到、得人心的！",@"由于项目需要一个环形渐变进度条显示课程，这方便网上的确有很多相关资料但是，都是比较零散的而且，大多数只是放一堆代码就算完了。这里我想详细写一篇我自己实现这个进度条的过程。实现一个圆弧进度条主要分为三步\n一、画圆弧这里用的贝赛尔曲线，就是这个东西：UIBezierPath\n二、根据贝塞尔曲线路径画两个圆弧一个底色一个上面的填充色，用到的是这个类CAShapeLayer.h\n三、画两个渐变色块，把上面的进度条路径映射到渐变色块上，渐变色块用的是这个东西习近平对贺一诚获中央政府任命为澳门特别行政区第五任行政长官表示祝贺。习近平说，长期以来，你秉持爱国爱澳立场，热心服务澳门社会，在担任全国人大常委和澳门立法会主席等多个公职期间尽心尽力，为国家改革开放和现代化建设、为澳门繁荣稳定作出了积极贡献。中央对此是充分肯定的。在这次行政长官选举中，你高票提名、高票当选，充分表明澳门社会对你是广泛认同的。习近平表示，今年是澳门回归祖国20周年。20年来，在何厚铧、崔世安两位行政长官带领下，澳门特别行政区政府团结社会各界人士，全面准确理解和贯彻“一国两制”方针，坚定维护宪法和基本法权威，传承爱国爱澳的核心价值观，促进澳门经济快速增长、民生持续改善、社会稳定和谐，向世界展示了具有澳门特色的“一国两制”成功实践。事实证明，“一国两制”是完全行得通、办得到、得人心的！",@"由于项目需要一个环形渐变进度条显示课程，这方便网上的确有很多相关资料但是，都是比较零散的而且，大多数只是放一堆代码就算完了。这里我想详细写一篇我自己实现这个进度条的过程。实现一个圆弧进度条主要分为三步\n一、画圆弧这里用的贝赛尔曲线，就是这个东西：UIBezierPath\n二、根据贝塞尔曲线路径画两个圆弧一个底色一个上面的填充色，用到的是这个类CAShapeLayer.h\n三、画两个渐变色块，把上面的进度条路径映射到渐变色块上，渐变色块用的是这个东西习近平对贺一诚获中央政府任命为澳门特别行政区第五任行政长官表示祝贺。习近平说，长期以来，你秉持爱国爱澳立场，热心服务澳门社会，在担任全国人大常委和澳门立法会主席等多个公职期间尽心尽力，为国家改革开放和现代化建设、为澳门繁荣稳定作出了积极贡献。中央对此是充分肯定的。在这次行政长官选举中，你高票提名、高票当选，充分表明澳门社会对你是广泛认同的。习近平表示，今年是澳门回归祖国20周年。20年来，在何厚铧、崔世安两位行政长官带领下，澳门特别行政区政府团结社会各界人士，全面准确理解和贯彻“一国两制”方针，坚定维护宪法和基本法权威，传承爱国爱澳的核心价值观，促进澳门经济快速增长、民生持续改善、社会稳定和谐，向世界展示了具有澳门特色的“一国两制”成功实践。事实证明，“一国两制”是完全行得通、办得到、得人心的！",@"由于项目需要一个环形渐变进度条显示课程，这方便网上的确有很多相关资料但是，都是比较零散的而且，大多数只是放一堆代码就算完了。这里我想详细写一篇我自己实现这个进度条的过程。实现一个圆弧进度条主要分为三步\n一、画圆弧这里用的贝赛尔曲线，就是这个东西：UIBezierPath\n二、根据贝塞尔曲线路径画两个圆弧一个底色一个上面的填充色，用到的是这个类CAShapeLayer.h\n三、画两个渐变色块，把上面的进度条路径映射到渐变色块上，渐变色块用的是这个东西习近平对贺一诚获中央政府任命为澳门特别行政区第五任行政长官表示祝贺。习近平说，长期以来，你秉持爱国爱澳立场，热心服务澳门社会，在担任全国人大常委和澳门立法会主席等多个公职期间尽心尽力，为国家改革开放和现代化建设、为澳门繁荣稳定作出了积极贡献。中央对此是充分肯定的。在这次行政长官选举中，你高票提名、高票当选，充分表明澳门社会对你是广泛认同的。习近平表示，今年是澳门回归祖国20周年。20年来，在何厚铧、崔世安两位行政长官带领下，澳门特别行政区政府团结社会各界人士，全面准确理解和贯彻“一国两制”方针，坚定维护宪法和基本法权威，传承爱国爱澳的核心价值观，促进澳门经济快速增长、民生持续改善、社会稳定和谐，向世界展示了具有澳门特色的“一国两制”成功实践。事实证明，“一国两制”是完全行得通、办得到、得人心的！",@"由于项目需要一个环形渐变进度条显示课程，这方便网上的确有很多相关资料但是，都是比较零散的而且，大多数只是放一堆代码就算完了。这里我想详细写一篇我自己实现这个进度条的过程。实现一个圆弧进度条主要分为三步\n一、画圆弧这里用的贝赛尔曲线，就是这个东西：UIBezierPath\n二、根据贝塞尔曲线路径画两个圆弧一个底色一个上面的填充色，用到的是这个类CAShapeLayer.h\n三、画两个渐变色块，把上面的进度条路径映射到渐变色块上，渐变色块用的是这个东西习近平对贺一诚获中央政府任命为澳门特别行政区第五任行政长官表示祝贺。习近平说，长期以来，你秉持爱国爱澳立场，热心服务澳门社会，在担任全国人大常委和澳门立法会主席等多个公职期间尽心尽力，为国家改革开放和现代化建设、为澳门繁荣稳定作出了积极贡献。中央对此是充分肯定的。在这次行政长官选举中，你高票提名、高票当选，充分表明澳门社会对你是广泛认同的。习近平表示，今年是澳门回归祖国20周年。20年来，在何厚铧、崔世安两位行政长官带领下，澳门特别行政区政府团结社会各界人士，全面准确理解和贯彻“一国两制”方针，坚定维护宪法和基本法权威，传承爱国爱澳的核心价值观，促进澳门经济快速增长、民生持续改善、社会稳定和谐，向世界展示了具有澳门特色的“一国两制”成功实践。事实证明，“一国两制”是完全行得通、办得到、得人心的！",@"由于项目需要一个环形渐变进度条显示课程，这方便网上的确有很多相关资料但是，都是比较零散的而且，大多数只是放一堆代码就算完了。这里我想详细写一篇我自己实现这个进度条的过程。实现一个圆弧进度条主要分为三步\n一、画圆弧这里用的贝赛尔曲线，就是这个东西：UIBezierPath\n二、根据贝塞尔曲线路径画两个圆弧一个底色一个上面的填充色，用到的是这个类CAShapeLayer.h\n三、画两个渐变色块，把上面的进度条路径映射到渐变色块上，渐变色块用的是这个东西习近平对贺一诚获中央政府任命为澳门特别行政区第五任行政长官表示祝贺。习近平说，长期以来，你秉持爱国爱澳立场，热心服务澳门社会，在担任全国人大常委和澳门立法会主席等多个公职期间尽心尽力，为国家改革开放和现代化建设、为澳门繁荣稳定作出了积极贡献。中央对此是充分肯定的。在这次行政长官选举中，你高票提名、高票当选，充分表明澳门社会对你是广泛认同的。习近平表示，今年是澳门回归祖国20周年。20年来，在何厚铧、崔世安两位行政长官带领下，澳门特别行政区政府团结社会各界人士，全面准确理解和贯彻“一国两制”方针，坚定维护宪法和基本法权威，传承爱国爱澳的核心价值观，促进澳门经济快速增长、民生持续改善、社会稳定和谐，向世界展示了具有澳门特色的“一国两制”成功实践。事实证明，“一国两制”是完全行得通、办得到、得人心的！"];
    for (int i = 0 ; i < 10; i ++) {
        LJXModel * model = [LJXModel new];
        model.userMsg = [NSString stringWithFormat:@"%d--%@",i+1,text[i]];
        model.isOpen = NO;
        [self.dataArray addObject:model];
    }
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}

#pragma mark -TTRefreshCellDelegate
-(void)refreshCellHeght{
    NSIndexSet * indexSet = [NSIndexSet indexSetWithIndex:0];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
