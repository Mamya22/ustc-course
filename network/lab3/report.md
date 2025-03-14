# lab3 report
<p align="right">PB22111639 马筱雅</p>

### 实验内容
- **必做**
- **选做1-负载均衡**
- **选做2-`6in4`**

### 1 必做内容
#### 子网划分
**学号后三位：`639`，将高新区路由与西区路由直接相连**，划分方案如下
| 校区            | 子网          |
| --------------- | ------------- |
| 中区-东区路由   | `63.9.1.0/24` |
| 中区-西区路由   | `63.9.4.0/24` |
| 南区            | `63.9.3.0/24` |
| 北区            | `63.9.0.0/24` |
| 东区            | `63.9.2.0/24` |
| 西区            | `63.9.5.0/24` |
| 西区-高新区路由 | `63.9.6.0/24` |
| 高新区          | `63.9.7.0/24` |


#### 路由器接口连接及IP地址分配
<table>
<tr>
    <th>Device </th>
    <th>Interface</th> 
    <th>IP Address </th>
    <th> Mask </th>          
    <th>To Device </th>
    <th>To Interface </th>
</tr>
<tr>
    <th rowspan=4>RouterM Cisco 2811</p>(NM-2FE2W module*1)</th> 
    <td> Fa0/0</td>    
    <td> 63.9.0.1</td> 
    <td rowspan=4> 255.255.255.0 </td>
    <td> SwitchN  </td> 
    <td> Fa0/2        </td>
</tr>
<tr>
    <td> Fa0/1</td>  
    <td> 63.9.1.1</td> 
    <td> RouterE  </td> 
    <td> Fa0/0        </td>
</tr>
<tr>
    <td> Fa1/0</td>    
    <td> 63.9.3.1</td> 
    <td> SwitchS  </td> 
    <td> Fa0/2        </td>
</tr>
<tr>
    <td> Fa1/1</td>    
    <td> 63.9.4.1</td> 
    <td> RouterW  </td> 
    <td> Fa0/1        </td>
</tr>
<tr>
    <th rowspan=3>RouterW Cisco 2811</P>(NM-2FE2W module*1)</th> 
    <td> Fa0/0</td>    
    <td> 63.9.6.1</td> 
    <td rowspan=3> 255.255.255.0 </td>
    <td> RouterG  </td> 
    <td> Fa0/0        </td>
</tr>
<tr>
    <td> Fa0/1</td>    
    <td> 63.9.4.2</td> 
    <td> RouterM  </td> 
    <td> Fa1/1        </td>
</tr>
<tr>
    <td> Fa1/0</td>    
    <td> 63.9.5.1</td> 
    <td> SwitchW  </td> 
    <td> Fa0/2        </td>
</tr>
<tr>
    <th rowspan=2>RouterE Cisco 1841   </th> 
    <td> Fa0/0</td>    
    <td> 63.9.1.2</td> 
    <td rowspan=2>  255.255.255.0       </td>
    <td> RouterM  </td> 
    <td> Fa0/1        </td>
</tr>
<tr>
    <td> Fa0/1</td>    
    <td> 63.9.2.1</td> 
    <td> SwitchE  </td> 
    <td> Fa0/1        </td>
</tr>
<tr>
    <th rowspan=2>RouterG Cisco 1841                       </th> 
    <td> Fa0/0</td>    
    <td> 63.9.6.2</td> 
    <td rowspan=2> 255.255.255.0       </td>
    <td> RouterW  </td> 
    <td> Fa0/0        </td>
</tr>
<tr>
    <td>Fa0/1 </td>     
    <td> 63.9.7.1 </td>  
    <td> SwitchG </td>  
    <td>Fa0/1</td>      
</tr>
</table>


#### 终端设备接口连接及IP地址
<p align="center">
<table >
    <tr>
        <th> Device</th>
        <th> IP Address</th>
        <th> Mask </th>
        <th> Gateway </th>
    </tr>
    <tr>
        <td>PCN</td>
        <td>63.9.0.2</td>
        <td>255.255.255.0</td>
        <td>63.9.0.1</td>
    </tr>
    <tr>
        <td>PCS</td>
        <td>63.9.3.2</td>
        <td>255.255.255.0</td>
        <td>63.9.3.1</td>
    </tr>
    <tr>
        <td>PCW</td>
        <td>63.9.5.2</td>
        <td>255.255.255.0</td>
        <td>63.9.5.1</td>
    </tr>
    <tr>
        <td>PCE</td>
        <td>63.9.2.2</td>
        <td>255.255.255.0</td>
        <td>63.9.2.1</td>
    </tr>
    <tr>
        <td>PCG</td>
        <td>63.9.7.2</td>
        <td>255.255.255.0</td>
        <td>63.9.7.1</td>
    </tr>
</table>

#### 配置结果
![alt text](image.png)

#### 静态路由配置
##### RouterM，中校区路由
对于目的地东校区、西校区和高新校区，RouterM不能直接到达，故需要配置。
- 目标主机为`PCW`和`PCG`，则下一跳地址为`RouterW Fa0/1`的`IP`地址，即`63.9.4.2`。
- 目标主机为`PCE`，则下一跳地址为`RouterE Fa0/0`的`IP`地址，即`63.9.1.2`。
<img src="image-1.png" width=70% align = "middle"></img>

##### RouterW，西校区路由
对于目的地东、南、北校区和高新校区，RouterW不能直接到达，故需要配置。
- 目标主机为`PCG`，则下一跳地址为`RouterG Fa0/1`的`IP`地址，即`63.9.6.2`。
- 目标主机为`PCE`,`PCN`,`PCS`,则下一跳地址为`RouterM Fa1/1`的`IP`地址，即`63.9.4.1`。
<img src="image-4.png" width=70% align = "middle"></img>

##### RouterE，东校区路由
对于目的地西、南、北校区和高新校区，RouterE不能直接到达，故需要配置。
- 目标主机为`PCG`,`PCN`,`PCS`,`PCW`,下一跳地址为`RouterM Fa0/1`的`IP`地址，即`63.9.1.1`。
<img src="image-3.png" width=70% align = "middle"></img>

##### RouterG
对于目的地西、南、北校区和东校区，RouterG不能直接到达，故需要配置。
- 目标主机为`PCE`,`PCN`,`PCS`,`PCW`,下一跳地址为`RouterW Fa0/0`的`IP`地址，即`63.9.6.1`。
<img src="image-5.png" width=70% align = "middle"></img>

##### 具体配置结果如下 
<table>
    <tr>
        <th>Router</th>
        <th>NetWork</th>
        <th>Mask</th>
        <th>Next Hoop</th>
    </tr>
    <tr>
        <td rowspan=3>RouterM</td>
        <td>63.9.2.0 E</td>
        <td rowspan=3>255.255.255.0</td>
        <td>63.9.1.2</td>
    </tr>
    <tr>
        <td>63.9.5.0 W</td>
        <td>63.9.4.2</td>
    </tr>
    <tr>
        <td>63.9.7.0 G</td>
        <td>63.9.4.2</td>
    </tr>
    <tr>
        <td rowspan=4>RouterE</td>
        <td>63.9.0.0 N</td>
        <td rowspan=4>255.255.255.0</td>
        <td>63.9.1.1</td>
    </tr>
    <tr>
        <td>63.9.3.0 S</td>
        <td>63.9.1.1</td>
    </tr>
    <tr>
        <td>63.9.5.0 W</td>
        <td>63.9.1.1</td>
    </tr>
    <tr>
        <td>63.9.7.0 G</td>
        <td>63.9.1.1</td>
    </tr>
    <tr>
        <td rowspan=4>RouterG</td>
        <td>63.9.0.0 N</td>
        <td rowspan=4>255.255.255.0</td>
        <td>63.9.6.1</td>
    </tr>
    <tr>
        <td>63.9.2.0 E</td>
        <td>63.9.6.1</td>
    </tr>
    <tr>
        <td>63.9.3.0 S</td>
        <td>63.9.6.1</td>
    </tr>
    <tr>
        <td>63.9.5.0 W</td>
        <td>63.9.6.1</td>
    </tr>
    <tr>
        <td rowspan=4>RouterW</td>
        <td>63.9.0.0 N</td>
        <td rowspan=4>255.255.255.0</td>
        <td>63.9.4.1</td>
    </tr>
    <tr>
        <td>63.9.2.0 E</td>
        <td>63.9.4.1</td>
    </tr>
    <tr>
        <td>63.9.3.0 S</td>
        <td>63.9.4.1</td>
    </tr>
    <tr>
        <td>63.9.7.0 G</td>
        <td>63.9.6.2</td>
    </tr>
</table>

#### 静态路由高新区连通性测试
通过一下图片可知，当连接`63.9.3.2`和`63.9.2.2`，即南区主机和东区主机时，均能成功到达。

<img src="image-6.png" width=70% align = "middle"></img>



#### 动态配置RIP
每个图片包含`show ip route`和`show ip protocols`两条命令
##### RouterM
- `show ip route`指令可以看出该路由和所有子网相连，其中表明哪些子网是直接相连，哪些子网通过其他端口和IP地址相连，例如，要到达`63.9.2.0`要通过`63.9.1.2`。
- `show ip protocols`指令可以看出动态路由协议为`RIP`，包含四个接口，并且正在为 `63.0.0.0` 网络提供接口，从`63.9.1.2` 和 `63.9.4.2` 两个网关学习到路由。
- 其他路由器信息与此类似。
<img src="image-7.png" width=70% align = "center"></img>

#### RouterW
<img src="image-8.png" width=70% align = "middle"></img>

#### RouterE
<img src="image-9.png" width=70% align = "middle"></img>

#### RouterG
<img src="image-10.png" width=70% align = "middle"></img>

#### 连通性测试
<img src="image-11.png" width=70% align = "middle"></img>

### 2 选做1-负载均衡
- 建立冗余链路，将高新区路由`RouterG`和东区`RouterE`路由相连。同时为新的端口分配新的`IP`地址，其中`RouterG Eth0/1/0`的`IP`为`63.9.8.1`，与此相连的`RouterE`的端口`IP`为`63.9.8.2` 。
<img src="image-15.png" width=70% align = "middle"></img>

- 可以看出，从高新校区网络到南区网络和北区网络，可以通过`RouterW`和`RouterE`中转，从而实现负载均衡。从下图可看出，从`RouterM`到高新区网络，可以通过`63.9.4.2`和`63.9.1.2`，从而存在两条路径。
<img src="image-14.png" width=70% align = "middle"></img>

#### 结果
##### 到北校区两条路径
可以看出，从高新区主机`63.9.7.2`到北区主机`63.9.0.2`，连续两次`tracert`，跳转的`IP`地址不同，即存在两条不同的路径。

<img src="image-12.png" width=70% align = "middle"></img>

可以看出，从高新区主机`63.9.7.2`到北区主机`63.9.3.2`，连续两次`tracert`，一次先跳转`63.9.6.1`，一次先跳转`63.9.8.2`，跳转的`IP`地址不同，即存在两条不同的路径。
<img src="image-13.png" width=70% align = "middle"></img>

### 3 选做2：6in64

采用**自动分配`ipv6`**的地址
- 为`PCW`的子网分配`ipv6`地址，为`639:1::/64`
- 为`PCE`的子网分配`ipv6`地址，为`639:2::/64`
#### 连通结果
下图展示了从不同主机连接对方主机的结果及其各自的IP地址
#### PCW
<img src="image-16.png" width=70% align = "middle"></img>

#### PCE
<img src="image-17.png" width=70% align = "middle"></img>

#### show ipv6 config
##### RouterE
可以看出，包含`Tunnel`部分的信息为，`C`连接路由，网络`1639::/64`通过`Tunnel0`接口连接，目标地址为`1639::2/128`
<img src="image-18.png" width=70% align = "middle"></img>

##### RouterW
可以看出，包含`Tunnel`部分的信息为，`C`连接路由，网络`1639::/64`通过`Tunnel0`接口连接，目标地址为`1639::1/128`，表示目标为西校区。
<img src="image-19.png" width=70% align = "middle"></img>

##### RouterM
`RouterM`未配置`ipv6`。
<img src="image-20.png" width=70% align = "middle"></img>