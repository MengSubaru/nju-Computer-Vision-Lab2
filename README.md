南京大学《计算机视觉》课程第二次实验——基于**梯度**和基于**方向滤波器**的**边缘检测**任务与基于**颜色**和基于**纹理**的**图像分割**任务的实现，任务要求见`assignment.pdf`。

具体来说：
+    **边缘检测**的任务实现在`./EdgeDetection/solutions`目录下：
     +    基于**梯度**的实现在[edgeGradient.m](./EdgeDetection/solutions/edgeGradient.m)中；
     +    基于**方向滤波器**的实现在[edgeOrientedFilters.m](./EdgeDetection/solutions/edgeOrientedFilters.m)中。
+    **图像分割**的代码耦合度比较高，需要实现的模块分散在`./ImageSegmentation`目录下，包括[compareSegmentations.m](./ImageSegmentation/compareSegmentations.m)、[createTextons.m](./ImageSegmentation/createTextons.m)、[extractTextonHists.m](./ImageSegmentation/extractTextonHists.m)、[quantizeFeats.m](./ImageSegmentation/quantizeFeats.m)与[segmentMain.m](./ImageSegmentation/segmentMain.m)。


测试步骤：
1.  安装MATLAB，确保有能运行matlab文件的环境支持；
2.  运行`./EdgeDetection/evaluateSegmentation.m`脚本文件进行边界检测的两个函数的测试，结果会储存在`./EdgeDetection/results`目录下；
3.  运行`./ImageSegmentation/segmentMain.m`脚本文件进行图片分割的测试，基于颜色的分割结果和基于纹理的分割结果会在运行过程中与原图一起显示出来；
4.  需要注意的是，图片分割的测试脚本可能需要一分钟左右的时间，请耐心等待。