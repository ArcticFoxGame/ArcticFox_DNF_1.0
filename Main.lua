--=============================================================================--
-- ■ 加载运行库
--=============================================================================--
require ("GGE")--引用头
require ("Script/通用变量")
require ("Script/基础方法")

require ("Sys/游戏初始化/游戏系统初始化")
require ("Sys/游戏初始化/装扮系统初始化")
require ("Sys/游戏初始化/初始化数据系统")

require ("Sys/公用设置/公共方法")
require ("Sys/公用设置/公用_扩充方法")
require ("Sys/公用设置/公用_鼠标类")
require ("Sys/公用设置/公用_系统类")
require ("Sys/公用设置/公用_屏幕类")

require ("Sys/扩展系统/扩展_资源管理器")
require ("Sys/扩展系统/扩展_PAK类")
require ("Sys/扩展系统/扩展_游戏地图")
require ("Sys/扩展系统/扩展_地图物件")
require ("Sys/扩展系统/扩展_三层按钮")
require ("Sys/扩展系统/扩展_精灵文字A")

require ("Sys/主角色类/角色_音效")
require ("Sys/主角色类/主角_男鬼剑士")

require ("Sys/怪物类/怪物_哥布林")

require ("Sys/游戏特效类/特效类")

require ("Sys/格子类/格子_包裹格子")
require ("Sys/格子类/格子_技能格子")

require ("Sys/窗口类/窗口_角色包裹")
require ("Sys/窗口类/窗口_角色技能")

require ("Sys/脚本组/技能数据组")

require ("Sys/脚本组/物品脚本组")
require ("Sys/脚本组/地图脚本组")



--=============================================================================--
-- ■ 初始化
--=============================================================================--
引擎("DNF外传 V0.1",800,600,60,true,false)

--更改图标
local ffi = require("ffi")
ffi.cdef[[
	void* 	LoadImageA(int,const char*,int,int,int,int);
	int 	SendMessageA(int,int,int,void*);
]]
local img = ffi.C.LoadImageA(0,'Dat/UI/图标类/DNF.ico',1,32,32,16)
ffi.C.SendMessageA(引擎.取窗口句柄(),128,0,img)

--全局文字创建
文字 = require("gge文字类")("Dat/simsun.ttc",12,false,false,false)
文字_16号 = require("gge文字类")("Dat/simsun.ttc",16,false,false,false)
Q_文字高度16 = 文字_16号:取高度("A")
Q_目录 = 取运行目录()


层次解决=false
--角色坐标x=0
--角色坐标y=0

--==地图组================
Q_地图事件组 = {}
Q_地图物件组 = {}
Q_事件箱 = {}
Q_地图纹理组 = {}
--==特效组(游戏内调用)=====
Q_游戏特效组 = {}
Q_游戏单帧特效组 = {}   --地图的单帧特效
Q_游戏MOBJ特效组 = {}   --地图和道具的特效
Q_游戏AS特效组 = {}      --攻击的打击特效(包含属性)
Q_屏幕特效组 = {}
Q_屏幕特效组_顶层 = {}
--==特效组(初始化调用)=====
Q_技能数据组 = {}
--==游戏的掉宝和物品组=====
Q_游戏道具组 ={}
Q_缓存纹理组 = {}
Q_怪物掉宝组 = {}
Q_地面物品组 = {}
--==游戏的NPC组===========
Q_游戏NPC组 = {}
Q_屏幕NPC组 = {}
--==所有物件的组==========
Q_屏幕物件组 = {}
Q_屏幕怪物组 = {}
Q_游戏技能组 = {}
--Q_屏幕APC组 = {}
--==风格提示和风格框组====
风格提示组 = {}  --风格框显示,风格提示的必备组
--==NPC点击初始化=========
Q_最后点击NPCID = 0
--==包裹的初始化数据======
Q_鼠标道具 ={id = 0,数量=0}
Q_最后使用道具格子 = {}
Q_最后点击格子id = 0
Q_最后点击包裹子夹 = 0
Q_最后点击格子id_技能 = 0
Q_出售锁定格子 =0
Q_快捷道具格子 = {}
Q_快捷技能格子 = {}
--==系统初始化部分=======
Q_鼠标技能 ={对象 = nil}
Q_画面偏移 = {x=0,y=0}
Q_鼠标坐标 = {x=0,y=0}
Q_屏幕焦点 = true

Q_屏幕抖动 = {时间 = 0,频率 = 0,幅度 =  0,计次 = 0}

Q_屏幕黑遮罩 = require("gge精灵类")(0,0,0,800,600)
Q_屏幕黑遮罩:置颜色(颜色_黑)
Q_屏幕遮罩时间 = 255

Q_调试 = false

Q_音效 = 60

物件排序方法 = function(物件a, 物件b)
	if(物件a.地平线 == 物件b.地平线) then
		return 物件a.物件ID < 物件b.物件ID
	else
		return 物件a.地平线 < 物件b.地平线
	end
end


初始化技能数据组()

初始化数据库系统()

游戏初始化()

加入屏幕物件组(Q_主角)

--Q_地图:加载地图("洛兰_D")

--Q_地图:加载地图("斯顿雪域")

Q_地图:加载地图("艾尔文防线")

Q_画面偏移.x ,Q_画面偏移.y = 取画面坐标(Q_主角.坐标.x,Q_主角.坐标.y,Q_地图宽度,Q_地图高度,960,600)

--=============================================================================--
-- ■ 更新
--=============================================================================--
function 更新函数(dt_,x,y)--帧率,鼠标x,鼠标y
	dt = dt_
	Q_鼠标坐标.x,Q_鼠标坐标.y = 引擎.取鼠标坐标()
	if (Q_游戏鼠标.模式 ~= "出售" and Q_游戏鼠标.模式 ~= "购买"  and Q_游戏鼠标.模式 ~= "分解") then
		Q_游戏鼠标.模式 = "普通"
	end
		Q_屏幕:更新()
		Q_地图:更新()

		for n=1,table.getn(Q_屏幕物件组) do
			Q_屏幕物件组[n]:更新()
		end

		for n=1,table.getn(Q_地图物件组) do
			Q_地图物件组[n]:更新()
		end

		for n=table.getn(Q_屏幕物件组),1,-1 do
			if ( Q_屏幕物件组 and (Q_屏幕物件组[n].标识类型 == "屏幕特效" or Q_屏幕物件组[n].标识类型 == "地面掉落物"  or  Q_屏幕物件组[n].标识类型 == "屏幕怪物" ) and Q_屏幕物件组[n].已经消失 ) then
				table.remove(Q_屏幕物件组,n,1)
			end
		end

		for n=table.getn(Q_屏幕特效组),1,-1 do
			if (Q_屏幕特效组[n].已经消失) then
				table.remove(Q_屏幕特效组,n,1)
			end
		end

	Q_游戏鼠标:更新()

	if (引擎.按键按下(键_F1)) then
		Q_调试 = not Q_调试
	end

	if (引擎.按键按下(键_空格)) then

		Q_系统:增加怪物("哥布林",Q_主角.坐标.x,Q_主角.坐标.y,1)
		--Q_主角.角色属性.HP = Q_主角.角色属性.HP - 5

	end

end

--=============================================================================--
-- ■ 显示
--=============================================================================--
function 渲染函数(x,y)--鼠标x,鼠标y
	引擎.渲染开始()
	引擎.渲染清除(0xFF272822)

	table.sort(Q_屏幕物件组,物件排序方法)
	Q_地图:显示()

	for n=1,table.getn(Q_屏幕物件组) do
		Q_屏幕物件组[n]:显示()
	end

	Q_地图:显示顶层()

	Q_屏幕:显示()

	Q_游戏鼠标:显示()
	文字_描边显示(文字,5,10,"空格键增加怪物哥布林,其余为DNF基本按键",颜色_蓝,颜色_黑)

	引擎.渲染结束()
end



--=============================================================================--
-- ■ 追加函数
--=============================================================================--
function 屏幕获得焦点 ()
	Q_屏幕焦点 = true
	--引擎.垂直同步(true)
	return false
end
function 屏幕失去焦点 ()
	Q_屏幕焦点 = false
	--引擎.垂直同步(false)
	return false
end
local function 退出函数()
	return true
end
local function 退出函数()
	return true
end
引擎.置获得焦点函数(屏幕获得焦点)
引擎.置失去焦点函数(屏幕失去焦点)
引擎.置退出函数(退出函数)