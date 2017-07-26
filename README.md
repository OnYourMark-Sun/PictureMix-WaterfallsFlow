# PictureMix-WaterfallsFlow
TableView简写瀑布流
![iamge](http://images2017.cnblogs.com/blog/922169/201707/922169-20170726155637437-2138696224.png)
![image](http://images2017.cnblogs.com/blog/922169/201707/922169-20170726155643250-685618472.png)

在VC中创建三个tableView，三个数据源数组，三个CGFloat对象记录tableView添加image之后的高度变化，每次添加图片到数组 给高度最低的一个（高度相同给第一个）；

cellforRow的计算以为是如此，在插入数组图片的同时也可以记录一个数组装cell的高度

UIImage *image = [UIImage imageNamed:imageName];
    imageView.image = image;
    
    // 给imageView设置大小
    // 宽度是屏幕的 1/3
    float width = CGRectGetWidth([[UIScreen mainScreen] bounds]) / 3;

    // 根据比例算出高度
    float height = image.size.height * width / image.size.width;
    
    
    
    
