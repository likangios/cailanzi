//
//  RCAddressSelectView.m
//  Podium
//
//  Created by realcloud on 2019/3/18.
//  Copyright © 2019年 realcloud. All rights reserved.
//

#import "RCAddressSelectView.h"

@interface RCAddressSelectView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong) UIView *bgView;

@property (nonatomic,strong) UIView *mainView;

@property (nonatomic,strong) UIPickerView *picker;

@property (nonatomic,strong) UIButton *cancel;

@property (nonatomic,strong) UIButton *confirm;

@property (nonatomic,copy)   void (^cancelBlock)(void);

@property (nonatomic,copy)   void (^confirmBlock)(id obj);

@property (nonatomic,strong) NSArray  <CityModel *>*dataArray;

@property (nonatomic,assign) NSInteger component_one;

@property (nonatomic,assign) NSInteger component_two;

@property (nonatomic,assign) NSInteger component_three;

@end

@implementation RCAddressSelectView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.component_one = 0;
        self.component_two = 0;
        self.component_three = 0;
        [[RCAreaManager shareInstance] getAreaArray:^(NSArray<CityModel *> *array) {
            _dataArray = [NSArray arrayWithArray:array];
            [self.picker reloadAllComponents];
        }];
        
        [self addSubview:self.bgView];
        [self addSubview:self.mainView];
        [self.mainView addSubview:self.picker];
        [self.mainView addSubview:self.cancel];
        [self.mainView addSubview:self.confirm];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(250);
        }];
        
        [self.picker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(200);
        }];
        [self.cancel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(50);
        }];
        
        [self.confirm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(50);
        }];
    }
    return self;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return self.dataArray.count;
            break;
        case 1:{
            CityModel *model = self.dataArray[self.component_one];
            return model.list.count;
        }
            break;
        case 2:
        {
            CityModel *model = self.dataArray[self.component_one];
            NSArray *array = model.list[self.component_two].list;
            return array.count;
        }
            break;
        default:
            return 0;
            break;
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (component) {
        case 0:{
            CityModel *model = self.dataArray[row];
            return model.name;
        }
            break;
        case 1:
        {
            CityModel *model = self.dataArray[self.component_one];
            CityModel *model2 = model.list[row];
            return model2.name;
        }
            break;
        case 2:
        {
            CityModel *model = self.dataArray[self.component_one];
            CityModel *model2 = model.list[self.component_two];
            CityModel *model3 = model2.list[row];
            return model3.name;
        }
            break;
        default:
            return @"";
            break;
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (component) {
        case 0:
            self.component_one = row;
            self.component_two = 0;
            self.component_three = 0;
            [pickerView selectRow:0 inComponent:1 animated:YES];
            [pickerView selectRow:0 inComponent:2 animated:YES];
            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];
            
            break;
        case 1:
            self.component_two = row;
            self.component_three = 0;
            [pickerView selectRow:0 inComponent:2 animated:YES];
            [pickerView reloadComponent:2];
            break;
        case 2:
            self.component_three = row;
            break;
        default:
            break;
    }
}
- (void)showWithBlock:(void (^)(void))cancel cofirm:(void (^)(id obj))confirm{
    [[UIApplication sharedApplication].delegate.window endEditing:YES];
    [[UIApplication sharedApplication].delegate.window addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.superview);
    }];
    self.cancelBlock = cancel;
    self.confirmBlock = confirm;
    
    self.mainView.transform = CGAffineTransformMakeTranslation(0, 250);
    self.bgView.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.25 animations:^{
        self.mainView.transform = CGAffineTransformIdentity;
        self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.75];
    }];
    
}

- (UIPickerView *)picker{
    if (!_picker) {
        _picker = [[UIPickerView alloc]init];
        _picker.delegate = self;
        _picker.dataSource = self;
    }
    return _picker;
}
- (UIButton *)confirm{
    if (!_confirm) {
        _confirm = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirm setTitle:@"确定" forState:UIControlStateNormal];
        [_confirm setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_confirm addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirm;
}
- (UIButton *)cancel{
    if (!_cancel) {
        _cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancel setTitle:@"取消" forState:UIControlStateNormal];
        [_cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancel addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancel;
}
- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [UIView new];
        _mainView.backgroundColor = [UIColor whiteColor];
    }
    return _mainView;
}
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }
    return _bgView;
}
- (void)confirmClick{
    CityModel *model1 = self.dataArray[self.component_one];
    CityModel *model2 = self.dataArray[self.component_one].list[self.component_two];
    CityModel *model3 = self.dataArray[self.component_one].list[self.component_two].list[self.component_three];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (model3 == nil) {
        [dic setObject:@(0)  forKey:@"provinceId"];
        [dic setObject:@""  forKey:@"provinceName"];
        
        [dic setObject:model1.id  forKey:@"cityId"];
        [dic setObject:model1.name  forKey:@"cityName"];
        if (model2) {
            [dic setObject:model2.id  forKey:@"countyId"];
            [dic setObject:model2.name  forKey:@"countyName"];
        }
        else{
            [dic setObject:@(0)  forKey:@"countyId"];
            [dic setObject:@""  forKey:@"countyName"];
        }

    }
    else{
        [dic setObject:model1.id  forKey:@"provinceId"];
        [dic setObject:model1.name  forKey:@"provinceName"];
        [dic setObject:model2.id  forKey:@"cityId"];
        [dic setObject:model2.name  forKey:@"cityName"];
        [dic setObject:model3.id  forKey:@"countyId"];
        [dic setObject:model3.name  forKey:@"countyName"];
    }
    if (self.confirmBlock) {
        self.confirmBlock(dic);
    }
    [self hiddenSelf];
}
- (void)cancelClick{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    [self hiddenSelf];
}
- (void)hiddenSelf{
    [UIView animateWithDuration:0.25 animations:^{
        self.mainView.transform = CGAffineTransformTranslate(self.mainView.transform, 0, 250);
        self.bgView.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
