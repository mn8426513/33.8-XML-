//
//  ViewController.m
//  33.8-XML的解析
//
//  Created by Mac on 14-10-31.
//  Copyright (c) 2014年 MN. All rights reserved.
//

#import "ViewController.h"
#import "Video.h"

#import "UIImageView+WebCache.h"

@interface ViewController ()<NSXMLParserDelegate>

@property (nonatomic,strong) NSMutableArray *dataList;

@property (nonatomic,strong) NSMutableString *elementString;


@end

@implementation ViewController
    //  NSXMLParser 这个用来专门解析XML的类
    //  SAX 只能读不能改，实用在手机上
    //  DOM 适合使用在服务器端
    //  NSXMLParser 解析的具体步骤：1.通过这个方法 [NSXMLParser alloc] initWithData:data] 来创建一个parser对象；2.设置parser的代理；3.开始解析 [parser parser];  4.然后实现代理方法进行解析

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    
    // 为一个UIImageView设置网络上加载的图片，这个第三方库文件非常好用，不建议自己去写这个图片加载的程序，最好是用这个库来写网络上加载的图片，非常好用的，而且还还建议看看源代码是怎么写的。
    
//    [[UIImageView alloc] setImageWithURL:url placeholderImage:nil];
    
    
    [self loadData];
}


- (void)loadData{
    
    NSString *string = [NSString stringWithFormat: @"http://www.duitang.com/album/58375208/"];
    
    NSURL *url = [NSURL URLWithString:string];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:4];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if(connectionError){
           
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"连接失败" message:@"网络很不给力啊" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:@"重新加载", nil];
                [alert show];
              }];
          }else{
               
              NSString *string = [[NSString alloc] initWithData:data encoding:4];
              NSLog(@"%@",string);
              
              NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
              
              parser.delegate = self ;
              
              [parser parse];
          }
    }];
    
}

#pragma mark - XML解析的代理方法
#pragma mark 1.开始解析
-(void)parserDidStartDocument:(NSXMLParser *)parser{
    
    //文件开始解析，进行一些初始化的操作
    if(self.dataList ==nil){
        self.dataList = [NSMutableArray array];
    }else {
        [self.dataList removeAllObjects];
    }
    if(self.elementString == nil){
        self.elementString = [[NSMutableString alloc] init];
    }else{
        // 清空可变字符串不要设置成nil,使用setString只是清空内容,下次不会再次实例化
        [self.elementString setString:@""];
    }
}

static Video *video;

#pragma mark 2. 所有开始一个节点:<element>
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    if([elementName isEqualToString:@"video"]){
         video = [[Video alloc] init];
    }else{
        // 每开始一个新节点之前都清空elementString
        // 避免上一次的结果被重复拼接,例如拼完名字是"abc",再拼长度就会变成"vda1234"
        [self.elementString setString:@""];
    }
    
}

#pragma mark 3. 查找内容,可能会重复多次
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    // 来回拼接
    [self.elementString appendString:string];
}


#pragma mark 4. 节点结束 </element>
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    // 利用KVC 既简单又方便
    if([elementName isEqualToString:@"video"]){
       [self.dataList addObject:video];
    }else if(![elementName isEqualToString:@"videos"]){
        [video setValue:self.elementString forKey:elementName];
     }


}


#pragma mark 5. 文档结束
-(void)parserDidEndDocument:(NSXMLParser *)parser{
    
    // 在iOS开发中用一个可变对象给不可变对象赋值时,使用copy是一个好习惯
    self.VideoList = [self.dataList copy];

}

#pragma mark 6. 出错处理
-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
  
       NSLog(@"%@", parseError.localizedDescription);

}

@end
