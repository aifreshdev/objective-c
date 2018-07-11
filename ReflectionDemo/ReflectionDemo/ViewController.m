//
//  ViewController.m
//  ReflectionDemo
//
//  Created by Vincent li on 10/1/2018.
//  Copyright © 2018年 Vincent li. All rights reserved.
//

#import "ViewController.h"
#import "PersonModel.h"
#import <objc/runtime.h>

@interface ViewController (){
    NSString *name;
}

@property(nonatomic, strong) NSString *property;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addUIView];
    NSArray *allArgs = [self getVariableNamesByObject: [ViewController class]];
    NSArray *allProperie = [self getPropertieNamesByObject:[ViewController class]];
    
    NSLog(@"%@", allProperie);
    NSLog(@"%@", allArgs);
    NSLog(@"%s", TEST_PREFIX);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addUIView{
    Class viewClass = NSClassFromString(@"UIView");
    UIView *subView = [[viewClass alloc] init];
    subView.backgroundColor = [UIColor redColor];
    subView.frame = CGRectMake(20, 20, 100, 100);
    [self.view addSubview:subView];
}

//show all properties
- (NSArray*)getPropertieNamesByObject:(id)object{
    unsigned int outCount, i;
    
    // 获取注册类的属性列表，第一个参数是类，第二个参数是接收类属性数目的变量
    objc_property_t *properties = class_copyPropertyList([object class], &outCount);
    //定义一个数组来接收获取的属性名
    NSMutableArray *nameArray = [[NSMutableArray alloc] initWithCapacity:outCount];
    for (i = 0; i < outCount; i++) {
        //通过循环来获取单个属性
        objc_property_t property = properties[i];
        //取得属性名
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        //将得到的属性名放入数组中
        [nameArray addObject:propertyName];
        
    }
    free(properties);
    return nameArray;
}

//show all variable
- (NSArray *)getVariableNamesByObject:(id)object{
    unsigned int numIvars = 0;
    //获取类的所有成员变量
    Ivar *ivars = class_copyIvarList(object, &numIvars);
    //定义一个数组来接收获取的属性名
    NSMutableArray *nameArray = [[NSMutableArray alloc] initWithCapacity:numIvars];
    for(int i = 0; i < numIvars; i++) {
        //得到单个的成员变量
        Ivar thisIvar = ivars[i];
        //得到这个成员变量的类型
        const char *type = ivar_getTypeEncoding(thisIvar);
        NSString *stringType =  [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
        //此处判断非object-c类型时跳过
        if (![stringType hasPrefix:@"@"]) {
            continue;
        }
        //得到成员变量名
        NSString *variableName = [NSString stringWithUTF8String:ivar_getName(thisIvar)];
        [nameArray addObject:variableName];
        
        //这个函数可以得到成员变量的值
        //object_getIvar(object, thisIvar)
        
    }
    free(ivars);
    return nameArray;
}

- (void)parseJson {
    NSString *file = [[NSBundle mainBundle] pathForResource:@"Persons" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:file];
    NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
//    for (NSDictionary *model in array) {
//        PersonModel *person = [[PersonModel alloc] initWithNSDictionary:model];
//        NSLog(@"%@, %ld, %@, %@", person.name, (long)person.age, person.city, person.job);
//    }
}

@end
