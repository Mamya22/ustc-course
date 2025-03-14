# Lab1 Report
<p align= "right">PB22111639 马筱雅</p>

### 问题描述
- **问题背景知识：**
对于一个数据表`T`，准标识符属性集合是指表`T`中可以通过结合外部信息识别表中记录的属性的最小集合。在表`T`中，对于任意所有准标识符属性值都相同的记录集合，称为一个等价类。若`T`的每个等价类大小至少为`k`，则称该表在该属性集上是k匿名的。`Mondrian`算法是一种使用贪心算法对数据进行k匿名的一种方式。
- **问题要求：**
已有`Mondrian`算法的实验框架，本实验需要对实验框架中的确实代码进行补充
实验框架如下
- **问题细化：**
  本实验要求补充代码的位置分别为`mondrian.py`文件中的`anonymize_strict`函数和`anonymize_relaxed`函数，`mondrian_2.py`文件中的`split_categorical`函数
    
    - `anonymize_strict`函数：对数值型数据进行k匿名化，要求每次对数据进行划分时，与中位数相同的数据严格划分到同一个子集。
    - `anonymize_relaxed`函数：对数值型数据进行k匿名，使得每次对数据进行划分时，划分的两个子集中记录数目相同或者相差为1。
    - `split_categorical`函数：对非数值型数据进行k匿名，通过对不同的属性值进行泛化，从而进行划分

### 解决思路
mondrian算法：
首先对传入的数据集进行初始化，使用全局变量QI_LEN记录准标识符个数，GL_K记录k， QI_RANGE记录每个属性对应的范围，QI_ORDER记录每个属性对应的属性值从小到大的顺序（不重复），QI_DICT对每个属性对应的属性值重新进行编号。
接着创建Partition类，low对应属性最小的编号，high对应最大属性值的编号，
如果是relax方式，
首先找到划分的维度，每个维度对应一个准标识符
接着根据划分的维度找到中位数，具体操作为，对该维度对应所有属性值，计算相应频率，接着根据QI_DICT的顺序，从小到大计算频率和，直到找到第i个数，使得该数是中位数。并记录紧邻的下一个属性值，方便进行划分。
找中位数返回了中位数，中位数的下一个值，该维度对应的最大值和最小值
接着对该partition类更新最大最小值为相应的索引编号。
接着划分数据集，找到划分的属性值在字典中对应的位置，该位置左侧的都被划分到左侧，右侧的都被划分到右侧，对于该位置的数目重新划分，直至左右子集数相等或者相差一。
若划分后不满足，说明该维度无法继续划分，置allow=0.
接着对左右子集继续进行划分，直至所有维度都不能再划分，把划分结果添加至RESULT里


对于`anonymize_strict`函数和`anonymize_relaxed`函数，主要分为4个部分
- 选择进行划分的属性
- 对选择的属性进行划分，找到中位数等
- 更新上下限
- 对数据集进行划分
根据文件中的其他函数，choose_dimension函数用来找划分的属性，其返回值为维度，find_median函数用来找到划分的中位数，返回值为一个四元组，分别为中位数、中位数的相邻数字，最大值，最小值。
### 算法流程图
### 分析 (k、qi、datasize)对(GCP、RunTime)的影响
通过对代码的分析，此处的GCP和NCP的值相同
#### K对GCP的影响
<!-- <center class="half">
<img src="../../relax_ndg_k.png" width=250/>
<img src="../../relax_time_k.png" width=250>
</center> -->
<table>
<tr>
<td><center><img src="../../relax_ndg_k.png" width=250/>relax:K对GCP的影响</center></td>
<td><center><img src="../../strict_ndg_k.png" width=260/>strict:K对GCP的影响</center></td>
<!-- <td><center><img src="../../k_ncp2.png.png" width=200/>strict:K对GCP的影响</center></td> -->
</tr>
<tr>
<!-- <td><center><img src="../../relax_ndg_k.png" width=250/>relax:K对GCP的影响</center></td>
<td><center><img src="../../strict_ndg_k.png" width=260/>strict:K对GCP的影响</center></td> -->
<td><center><img src="../../k_ncp2.png" width=250/>Mondrian2:K对GCP的影响</center></td>
</tr>
</table>
为了得到K对GCP的影响，采用控制变量的形式，在datasize和qi相同的情况下，改变k，得到散点图，可以看出对于进阶Mondrian和基础Mondrian中GCP随着K的增大总体呈上升趋势。在基础Mondrian算法中，在一定范围的K内，GCP不变。思考原因可能是，在对每一个维度进行分割时，由于进行按照中位数进行平均分配成两个子集。

#### K对RunTime的影响
<!-- <center class="half">
<img src="../../relax_ndg_k.png" width=250/>
<img src="../../relax_time_k.png" width=250>
</center> -->
<table>
<tr>
<td><center><img src="../../relax_time_k.png" width=250/>relax:K对RunTime的影响</center></td>
<td><center><img src="../../strict_time_k.png" width=260/>strict:K对RunTime的影响</center></td>
<!-- <td><center><img src="../../k_ncp2.png.png" width=200/>strict:K对GCP的影响</center></td> -->
</tr>
<tr>
<!-- <td><center><img src="../../relax_ndg_k.png" width=250/>relax:K对GCP的影响</center></td>
<td><center><img src="../../strict_ndg_k.png" width=260/>strict:K对GCP的影响</center></td> -->
<td><center><img src="../../k_time2.png" width=250/>Mondrian2:K对RunTime的影响</center></td>
</tr>
</table>
在datasize和qi相同的情况下，改变k，得到运行时间的散点图，可以看出，随着K的增加，运行时间呈现出减少趋势，并且随着K的增加，时间减小的速度变慢。考虑原因可能是，Mondrian算法按照不同维度对切割到的子集按照按中位数划分，K越小，为了满足K匿名，需要划分更多次，把子集划分的更小，从而使得时间更长。

#### DataSize对GCP的影响
<!-- <center class="half">
<img src="../../relax_ndg_k.png" width=250/>
<img src="../../relax_time_k.png" width=250>
</center> -->
<table>
<tr>
<td><center><img src="../../relax_ndg_datasize.png" width=250/>relax:DataSize对GCP的影响</center></td>
<td><center><img src="../../strict_ndg_datasize.png" width=260/>strict:DataSize对GCP的影响</center></td>
<!-- <td><center><img src="../../k_ncp2.png.png" width=200/>strict:K对GCP的影响</center></td> -->
</tr>
<tr>
<!-- <td><center><img src="../../relax_ndg_k.png" width=250/>relax:K对GCP的影响</center></td>
<td><center><img src="../../strict_ndg_k.png" width=260/>strict:K对GCP的影响</center></td> -->
<td><center><img src="../../ncp_datasize2.png" width=250/>Mondrian2:DataSize对GCP的影响</center></td>
</tr>
</table>
可以看出随着DataSize的增大，GCP变小，对于relax下的例外

#### DataSize对RunTime的影响
<!-- <center class="half">
<img src="../../relax_ndg_k.png" width=250/>
<img src="../../relax_time_k.png" width=250>
</center> -->
<table>
<tr>
<td><center><img src="../../relax_time_datasize.png" width=250/>relax:DataSize对RunTime的影响</center></td>
<td><center><img src="../../strict_time_datasize.png" width=260/>strict:DataSize对RunTime的影响</center></td>
<!-- <td><center><img src="../../k_ncp2.png.png" width=200/>strict:K对GCP的影响</center></td> -->
</tr>
<tr>
<!-- <td><center><img src="../../relax_ndg_k.png" width=250/>relax:K对GCP的影响</center></td>
<td><center><img src="../../strict_ndg_k.png" width=260/>strict:K对GCP的影响</center></td> -->
<td><center><img src="../../datasize_time2.png" width=250/>Mondrian2:DataSize对RunTime的影响</center></td>
</tr>
</table>

#### qi对GCP的影响
<!-- <center class="half">
<img src="../../relax_ndg_k.png" width=250/>
<img src="../../relax_time_k.png" width=250>
</center> -->
<table>
<tr>
<td><center><img src="../../relax_ndg_qi.png" width=250/>relax:qi对GCP的影响</center></td>
<td><center><img src="../../strict_ndg_qi.png" width=260/>strict:qi对GCP的影响</center></td>
<!-- <td><center><img src="../../k_ncp2.png.png" width=200/>strict:K对GCP的影响</center></td> -->
</tr>
<tr>
<!-- <td><center><img src="../../relax_ndg_k.png" width=250/>relax:K对GCP的影响</center></td>
<td><center><img src="../../strict_ndg_k.png" width=260/>strict:K对GCP的影响</center></td> -->
<td><center><img src="../../ncp_qi2.png" width=250/>Mondrian2:qi对GCP的影响</center></td>
</tr>
</table>

#### qi对RunTime的影响
<!-- <center class="half">
<img src="../../relax_ndg_k.png" width=250/>
<img src="../../relax_time_k.png" width=250>
</center> -->
<table>
<tr>
<td><center><img src="../../relax_time_qi.png" width=250/>relax:qi对RunTime的影响</center></td>
<td><center><img src="../../strict_time_qi.png" width=260/>strict:qi对RunTime的影响</center></td>
<!-- <td><center><img src="../../k_ncp2.png.png" width=200/>strict:K对GCP的影响</center></td> -->
</tr>
<tr>
<!-- <td><center><img src="../../relax_ndg_k.png" width=250/>relax:K对GCP的影响</center></td>
<td><center><img src="../../strict_ndg_k.png" width=260/>strict:K对GCP的影响</center></td> -->
<td><center><img src="../../qi_time2.png" width=250/>Mondrian2:qi对RunTime的影响</center></td>
</tr>
</table>
93it [00:41,  2.21it/s]
Epoch 0, Train loss: 46.76912795856435, Test loss:, 13.466712474822998, Average NDCG: 0.7117510848416662
93it [00:41,  2.24it/s]
Epoch 1, Train loss: 13.34979506461851, Test loss:, 7.220352857343612, Average NDCG: 0.7155828256659867
93it [00:41,  2.24it/s]
Epoch 2, Train loss: 7.384699688162855, Test loss:, 5.214704482786117, Average NDCG: 0.7191078553249574
93it [00:42,  2.21it/s]
Epoch 3, Train loss: 5.195153251771004, Test loss:, 4.137957288372901, Average NDCG: 0.7239024825593068
93it [00:41,  2.23it/s]
Epoch 4, Train loss: 4.0668882657122865, Test loss:, 3.6030730470534293, Average NDCG: 0.72644833719799
93it [00:41,  2.24it/s]
Epoch 5, Train loss: 3.426344771539011, Test loss:, 3.307954126788724, Average NDCG: 0.7310039861512252
93it [00:41,  2.24it/s]
Epoch 6, Train loss: 3.0676314548779557, Test loss:, 3.321019511069021, Average NDCG: 0.7315413899592782
93it [00:42,  2.21it/s]
Epoch 7, Train loss: 2.933911205619894, Test loss:, 3.5244647802845126, Average NDCG: 0.7375621248702944
93it [00:42,  2.19it/s]
Epoch 8, Train loss: 2.930710636159425, Test loss:, 3.680315729110472, Average NDCG: 0.7361276114396031
93it [00:42,  2.21it/s]
Epoch 9, Train loss: 2.9648329852729716, Test loss:, 3.4106990868045437, Average NDCG: 0.739000492491135
93it [00:41,  2.24it/s]
Epoch 10, Train loss: 2.837087097988334, Test loss:, 2.9089854109671807, Average NDCG: 0.7386018121978655
93it [00:41,  2.24it/s]
Epoch 11, Train loss: 2.5027850494589856, Test loss:, 2.573655201542762, Average NDCG: 0.7456134174048454
93it [00:41,  2.24it/s]
Epoch 12, Train loss: 2.2235727604999336, Test loss:, 2.4462573605199016, Average NDCG: 0.7467798097789171
93it [00:40,  2.29it/s]
Epoch 13, Train loss: 2.0620842518345004, Test loss:, 2.3468083604689567, Average NDCG: 0.7534509774625897
93it [00:41,  2.22it/s]
Epoch 14, Train loss: 1.9637415498815558, Test loss:, 2.321166150031551, Average NDCG: 0.7520684379683205
93it [00:41,  2.22it/s]
Epoch 15, Train loss: 1.9082737635540705, Test loss:, 2.2810119967306814, Average NDCG: 0.7575773037715131
93it [00:41,  2.23it/s]
Epoch 16, Train loss: 1.8587169467761953, Test loss:, 2.272740087201518, Average NDCG: 0.7569860986063305
93it [00:42,  2.17it/s]
Epoch 17, Train loss: 1.8279514235834922, Test loss:, 2.2538503408432007, Average NDCG: 0.7621456819708952
93it [00:41,  2.22it/s]
Epoch 18, Train loss: 1.8128413948961484, Test loss:, 2.2759561730969335, Average NDCG: 0.760060992991243
93it [00:41,  2.22it/s]
Epoch 19, Train loss: 1.8090377853762718, Test loss:, 2.297852543092543, Average NDCG: 0.7631236897249295