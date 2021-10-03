# HotSource_app



## 目录

注意: 这只是规范的建议，并没有为任何符合规范的文档定义或强制要求使用术语。

- [段落](#段落)
  - [标题](#标题)
  - [横幅](#横幅)
  - [徽章](#徽章)
  - [简短描述](#简短描述)
  - [长描述](#长描述)
  - [背景](#背景)
  - [安装](#安装)
  - [用法](#用法)
  


## 段落

### 标题



**要求:**

- 标题必须与仓库、文件夹和包管理器名称相匹配——或者用斜体和括号表示的相关副标题。 例如:

  
markdown
  # Standard Readme Style _(standard-readme)_
  

  如果任何文件夹、仓库或包管理器名称不匹配，必须在“长描述”中附注说明原因。

**建议:**

- 应该是有据可循的

### 横幅


**要求:**
- 不能有自己的标题
- 必须链接到当前存储库中的本地映像
- 必须直接出现在标题后面


### 简短描述

使用python 的Ｆlask 框架建構web server ，接收手機傳遞的城市資料後，與資料庫串連後，傳回該城市的過去七天氣溫及heat index。
利用python torch 機器學習，架構預測未來一天天氣的模型，以預測未來的heat index


### 长描述
前期資料處理來自網路上找到的城市座標，與另外找到的城市歷史月均溫交叉比對，得出有歷史高均溫的城市座標 。
這些資料存入資料庫後，將作為之後判斷熱浪機率的基準。yeah~
關於機器學習模型，將由家軒為大家介紹。此機器學習模型使用使用Pytorch機器學習資料庫的linear regression model，選擇MSE作為loss criterion，並使用SGD為模型最佳化方程。
利用nasa 提供的資料來預測未來的溫度與濕度，以進一步得出heat index





### 背景
**状态:** 可选

**要求:**
- 包含动机.
- 包含抽象依赖关系.
- 包含知识来源: `可参见`也很合适.

### 安装
> github link
> 記得安裝所有python 套件

**要求:**
- 说明如何安装的代码块

**子段落:**
- 如果有不寻常的依赖项或依赖项，必须手动安装

**建议:**
-链接到编程语言的必备站点: [npmjs](https://npmjs.com), [godocs](https://godoc.org),等等.
- 包括安装所需的任何系统特定信息.
- 一个`更新`部分对大多数软件包都很有用, 如果用户可以使用多个版本.

###  用法
**状态:** 默认情况下是必需的，文档存储库是可选的.

**要求:**
- 说明常用用法的代码块.
- 如果 CLI 兼容，则代码块指示通用用法.
- 如果可导入，则指示导入功能和用法的代码块.

**建议:**
- `CLI`. 如果 CLI 功能存在，则需要.

**建议:**
- 涵盖可能影响使用的基本选项: 例如，如果是 JavaScript，则涵盖 promises / callbacks，此处为 ES6
- 如果相关，指向一个可运行的文件以获取使用代码