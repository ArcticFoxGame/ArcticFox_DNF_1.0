--=============================================================================--
-- @作者: 白狐剑仙。
-- @邮箱: 1733450036@qq.com
-- @创建时间:   2017-08-01 12:45:25
-- @最后修改来自: 白狐剑仙。
-- @Last Modified time: 2018-01-26 12:00:34
--=============================================================================--
主角_男鬼剑士  = class()
--=============================================================================--
-- ■ 构造函数
--=============================================================================--
function 主角_男鬼剑士:初始化(坐标x,坐标y)

	self.标识类型 = "鬼剑士"
	self.状态 = "静止"
	self.方向 = 1  -- 右
	self.坐标 = {x=坐标x,y=坐标y}
	self.地图坐标 = {x=坐标x,y=坐标y}
	self.地平线 = self.坐标.y
	self.上次位置 = {x=0,y=0}
	self.上次地平线 = 0

	self.id = 1

	self.最后次_右键_按下时间 = 0
	self.最后次_左键_按下时间 = 0
	self.最后次_上键_按下时间 = 0
	self.最后次_下键_按下时间 = 0

	self.最后次_空格_按下时间 = 0
	self.最后次_Z_按下时间 = 0
	self.最后次_X_按下时间 = 0

	self.右键双击 = false
	self.左键双击 = false
	self.上键双击 = false
	self.下键双击 = false

	self.角色属性 =
	{
		名称 = "DNF测试",
		等级 = 1,
		经验值 = 0,

		体力 = 5,
		精神 = 5,
		力量 = 5,
		智力 = 5,
		独立攻击力 = 10,

		MAX_HP =50,
		HP = 50,
		MAX_MP = 5000,
		MP = 5000,

		物理攻击力 = 9,
		魔法攻击力 = 9,
		物理防御力 = 0,
		魔法防御力 = 0,

		物理暴击 = 0,
		魔法暴击 = 0,

		攻击速度 = 10,
		释放速度 = 10,
		移动速度 = 3,

		抗魔 = 0,

		命中率 = 1,
		回避率 = 0,

		HP恢复量 = 1,
		MP恢复量 = 1,

		硬直 = 120,

		僵直度= 1,

		火属性强化 = 0,
		冰属性强化 = 0,
		光属性强化 = 0,
		暗属性强化 = 1,

		火属性抗性 = 0,
		冰属性抗性 = 0,
		光属性抗性 = 0,
		暗属性抗性 = 1,
	}

	self.职业 = "鬼剑士"
	self.转职 = ""

	self.复活币 = 10
	self.金币 = 10000000
	self.S点 = 0

	self.防具天赋精通 = "重甲"
	self.武器 = "钝器"

	self.X轴攻击范围 = 80
	self.Y轴攻击范围 = 30

--动画的播放速率（数值越大播放越慢）
	self.动画帧率 = {
			静止 = 30,
			待机 = 25,
			行走 = 取整(self.角色属性.移动速度 * 3.4),
			普攻一 = self.角色属性.攻击速度,
			普攻二 = self.角色属性.攻击速度,
			普攻三 = self.角色属性.攻击速度,
			跑动 = self.角色属性.移动速度 * 4,
			前刺 = self.角色属性.攻击速度,
			跃击 = self.角色属性.攻击速度,
			跳跃 = 12,
			跳跃上升 = 10,
			被击 = 取整(self.角色属性.硬直/10),
			死亡 = 12,
			拾取 = 22,
			--技能部分
			上挑 = 3,
			鬼斩 = 6,
			格挡 = 12,
			银光落刃 = 12,
			裂波斩_Q = 9,
			裂波斩_下斩 = 8,
			裂波斩_尾 = 10,

			小蹦 = 6,
			十字斩 = 6,
			地裂波动剑 = 4,


	}

	self.击退力量 = 0
	self.击退速度 = 1

	Q_鬼剑士_武器_管理器 = 扩展_资源管理器.创建([[Dat\PAK\角色PAK\男鬼剑士\武器\武器_钝器\club0000.pak]])
    Q_鬼剑士_身体_管理器 = 扩展_资源管理器.创建([[Dat\PAK\角色PAK\男鬼剑士\身体\sm_body0000.pak]])
	Q_鬼剑士_发型_管理器 = 扩展_资源管理器.创建([[Dat\PAK\角色PAK\男鬼剑士\发型\sm_hair0000.pak]])
	Q_鬼剑士_上衣_管理器 = 扩展_资源管理器.创建([[Dat\PAK\角色PAK\男鬼剑士\上衣\sm_coat0000.pak]])
	Q_鬼剑士_下装_管理器 = 扩展_资源管理器.创建([[Dat\PAK\角色PAK\男鬼剑士\下装\sm_pants0000.pak]])
	Q_鬼剑士_鞋子_管理器 = 扩展_资源管理器.创建([[Dat\PAK\角色PAK\男鬼剑士\鞋子\sm_shoes0000.pak]])
	Q_鬼剑士_基础特效_管理器 = 扩展_资源管理器.创建([[Dat\PAK\角色PAK\男鬼剑士\鬼剑士_基础特效.pak]])

	Q_鬼剑士_武器_展示_管理器 = 扩展_资源管理器.创建([[Dat\PAK\角色PAK\男鬼剑士\武器\武器_钝器\club0000.pak]])
    Q_鬼剑士_身体_展示_管理器 = 扩展_资源管理器.创建([[Dat\PAK\角色PAK\男鬼剑士\身体\sm_body0000.pak]])
	Q_鬼剑士_发型_展示_管理器 = 扩展_资源管理器.创建([[Dat\PAK\角色PAK\男鬼剑士\发型\sm_hair0000.pak]])
	Q_鬼剑士_上衣_展示_管理器 = 扩展_资源管理器.创建([[Dat\PAK\角色PAK\男鬼剑士\上衣\sm_coat0000.pak]])
	Q_鬼剑士_下装_展示_管理器 = 扩展_资源管理器.创建([[Dat\PAK\角色PAK\男鬼剑士\下装\sm_pants0000.pak]])
	Q_鬼剑士_鞋子_展示_管理器 = 扩展_资源管理器.创建([[Dat\PAK\角色PAK\男鬼剑士\鞋子\sm_shoes0000.pak]])


	self.身体 = wfox_pak.创建(Q_鬼剑士_身体_管理器,177,false)
	self.武器_A = wfox_pak.创建(Q_鬼剑士_武器_管理器,177,false)
	self.武器_B = wfox_pak.创建(Q_鬼剑士_武器_管理器,210+177,false)
	self.发型 = wfox_pak.创建(Q_鬼剑士_发型_管理器,177,false)
	self.上衣_A = wfox_pak.创建(Q_鬼剑士_上衣_管理器,177,false)
	self.下装_A = wfox_pak.创建(Q_鬼剑士_下装_管理器,177,false)
	self.下装_B = wfox_pak.创建(Q_鬼剑士_下装_管理器,210+177,false)
	self.鞋子_A = wfox_pak.创建(Q_鬼剑士_鞋子_管理器,177,false)
	self.鞋子_B = wfox_pak.创建(Q_鬼剑士_鞋子_管理器,210+177,false)

	self.身体 = wfox_pak.创建(Q_鬼剑士_身体_展示_管理器,177,false)
	self.武器_A = wfox_pak.创建(Q_鬼剑士_武器_展示_管理器,177,false)
	self.武器_B = wfox_pak.创建(Q_鬼剑士_武器_展示_管理器,210+177,false)
	self.发型 = wfox_pak.创建(Q_鬼剑士_发型_展示_管理器,177,false)
	self.上衣_A = wfox_pak.创建(Q_鬼剑士_上衣_展示_管理器,177,false)
	self.下装_A = wfox_pak.创建(Q_鬼剑士_下装_展示_管理器,177,false)
	self.下装_B = wfox_pak.创建(Q_鬼剑士_下装_展示_管理器,210+177,false)
	self.鞋子_A = wfox_pak.创建(Q_鬼剑士_鞋子_展示_管理器,177,false)
	self.鞋子_B = wfox_pak.创建(Q_鬼剑士_鞋子_展示_管理器,210+177,false)


	self.武器_A:置中心点(230,330)
	self.武器_B:置中心点(230,330)
	self.身体:置中心点(230,330)
	self.发型:置中心点(230,330)
	self.上衣_A:置中心点(230,330)
	self.下装_B:置中心点(230,330)
	self.下装_A:置中心点(230,330)
	self.鞋子_A:置中心点(230,330)
	self.鞋子_B:置中心点(230,330)


	self.纸娃娃组 = {}
	self.纸娃娃组_展示 = {}

	table.insert(self.纸娃娃组,{动画 = self.身体 ,层次 = 0,索引 = 1,名称= "默认",位置="身体",编号 ="0000",扩展_资源管理器 = Q_鬼剑士_身体_管理器})
	table.insert(self.纸娃娃组,{动画 = self.武器_A ,层次 = 650,索引 = 1,名称= "默认",位置="武器",编号 ="0000",扩展_资源管理器 = Q_鬼剑士_武器_管理器})
	table.insert(self.纸娃娃组,{动画 = self.武器_B ,层次 = 2600,索引 = 2,名称= "默认",位置="武器",编号 ="0000",扩展_资源管理器 = Q_鬼剑士_武器_管理器})
	table.insert(self.纸娃娃组,{动画 = self.发型 ,层次 = 2000,索引 = 1,名称= "默认",位置="头部",编号 ="0000",扩展_资源管理器 = Q_鬼剑士_发型_管理器})
	table.insert(self.纸娃娃组,{动画 = self.上衣_A ,层次 = 1800,索引 = 1,名称= "默认",位置="上衣",编号 ="0000",扩展_资源管理器 = Q_鬼剑士_上衣_管理器})
	table.insert(self.纸娃娃组,{动画 = self.下装_A ,层次 = 1500,索引 = 1,名称= "默认",位置="下装",编号 ="0000",扩展_资源管理器 = Q_鬼剑士_下装_管理器})
	table.insert(self.纸娃娃组,{动画 = self.下装_B ,层次 = 1300,索引 = 2,名称= "默认",位置="下装",编号 ="0000",扩展_资源管理器 = Q_鬼剑士_下装_管理器})
	table.insert(self.纸娃娃组,{动画 = self.鞋子_A ,层次 = 1400,索引 = 1,名称= "默认",位置="鞋",编号 ="0000",扩展_资源管理器 = Q_鬼剑士_鞋子_管理器})
	table.insert(self.纸娃娃组,{动画 = self.鞋子_B ,层次 = 1200,索引 = 2,名称= "默认",位置="鞋",编号 ="0000",扩展_资源管理器 = Q_鬼剑士_鞋子_管理器})

	table.insert(self.纸娃娃组_展示,{动画 = self.身体 ,层次 = 0,索引 = 1,名称= "默认",位置="身体",编号 ="0000",扩展_资源管理器 = Q_鬼剑士_身体_展示_管理器})
	table.insert(self.纸娃娃组_展示,{动画 = self.武器_A ,层次 = 650,索引 = 1,名称= "默认",位置="武器",编号 ="0000",扩展_资源管理器 = Q_鬼剑士_武器_展示_管理器})
	table.insert(self.纸娃娃组_展示,{动画 = self.武器_B ,层次 = 2600,索引 = 2,名称= "默认",位置="武器",编号 ="0000",扩展_资源管理器 = Q_鬼剑士_武器_展示_管理器})
	table.insert(self.纸娃娃组_展示,{动画 = self.发型 ,层次 = 2000,索引 = 1,名称= "默认",位置="头部",编号 ="0000",扩展_资源管理器 = Q_鬼剑士_发型_展示_管理器})
	table.insert(self.纸娃娃组_展示,{动画 = self.上衣_A ,层次 = 1800,索引 = 1,名称= "默认",位置="上衣",编号 ="0000",扩展_资源管理器 = Q_鬼剑士_上衣_展示_管理器})
	table.insert(self.纸娃娃组_展示,{动画 = self.下装_A ,层次 = 1500,索引 = 1,名称= "默认",位置="下装",编号 ="0000",扩展_资源管理器 = Q_鬼剑士_下装_展示_管理器})
	table.insert(self.纸娃娃组_展示,{动画 = self.下装_B ,层次 = 1300,索引 = 2,名称= "默认",位置="下装",编号 ="0000",扩展_资源管理器 = Q_鬼剑士_下装_展示_管理器})
	table.insert(self.纸娃娃组_展示,{动画 = self.鞋子_A ,层次 = 1400,索引 = 1,名称= "默认",位置="鞋",编号 ="0000",扩展_资源管理器 = Q_鬼剑士_鞋子_展示_管理器})
	table.insert(self.纸娃娃组_展示,{动画 = self.鞋子_B ,层次 = 1200,索引 = 2,名称= "默认",位置="鞋",编号 ="0000",扩展_资源管理器 = Q_鬼剑士_鞋子_展示_管理器})

	self.纸娃娃排序 = function(纸娃娃a, 纸娃娃b) return  纸娃娃a.层次 < 纸娃娃b.层次  end

	table.sort(self.纸娃娃组,self.纸娃娃排序)
	table.sort(self.纸娃娃组_展示,self.纸娃娃排序)

	self.最后按键 = ""

	按键激活 = ""

	self.脚步声 = false
	self.抖动 = 0

	self.命中时间 = 0
	self.上一帧动画 = 0
	右键弹起时间 = 0
	左键弹起时间 = 0

	self.普攻一延时 = 0
	self.普攻二延时 = 0
	self.普攻三延时 = 0

	self.连突刺延时 = 0

	--跳跃设置部分
	self.弹跳力 =  0
	self.跳跃偏移 = 0
	self.跳跃准备时间 = 0
	self.跳跃攻击 = false
	self.开始跳跃攻击 = false
	self.跳跃攻击次数 = 0

	--银光落刃设置部分
	self.落刃计次 = 0 --银光落刃计时
	self.银落模式 = "无波"

	--技能控制设置部分
	self.裂波计次 = 0 --裂波斩计时
	self.小蹦计次 = 0 --崩山击计时

	self.技能特效 = {}

	self.霸体渐隐 = 200
	self.霸体中间值 = 5

	self.霸体 = false
	self.无敌 = false

	self.目标怪物 = nil

	self.保存的精灵 = require ("gge精灵类")(0,0,0,0,0)
	self.保存的精灵_颜色值 = 0
	self.保存精灵显示位置 = {x=0,y=0}
--被攻击信息
	self.掉血特效组 = {}
	self.被攻击信息 = {来源 = "",方式 = "",时间= 0,方向 = 1}
	self.被攻击延时 = 1
	self.被攻击硬直 = 210
	self.被击弹跳力 = 0
	self.被击T力 = 0
	self.反弹 = false

	self.可移动 = true
	self.移动中 = false

	self.死亡倒地 = false

	男鬼剑音效 = 音效_男鬼剑士.创建()
	self.未准备好音效 = require("gge音效类")(Q_目录..[[\Dat\Audio\character_sound\鬼剑士_男\sm_nomana.wav]])

	self.拥有捡取物品 = nil

end


--=============================================================================--
-- ■ 更新纸娃娃
--=============================================================================--
function 主角_男鬼剑士:更新纸娃娃(位置,名称)

	local 临时特效组 = {}

	if (名称 == "空" ) then

		for n=table.getn(self.纸娃娃组),1,-1 do

			if ( self.纸娃娃组[n].位置 == 位置 ) then

				--self.纸娃娃组[n].动画:销毁()
				self.纸娃娃组[n].动画 = nil

				Q_包裹窗口.纸娃娃动画组[n].动画 = nil

				table.remove(Q_包裹窗口.纸娃娃动画组,n)
				table.remove(self.纸娃娃组,n)
			end
		end

	else

		for n=table.getn(self.纸娃娃组),1,-1 do
			if ( self.纸娃娃组[n].位置 == 位置 and self.纸娃娃组[n].名称 == 名称) then
				return
			end
		end

		for n=1,table.getn(Q_鬼剑士装扮) do
			if (Q_鬼剑士装扮[n].位置 == 位置 and Q_鬼剑士装扮[n].名称 == 名称) then  -- 判断位置和时装名称

				for i=1,table.getn(Q_鬼剑士装扮[n].动画状态) do

					local 临时_资源管理器 = {}
					if ( Q_鬼剑士装扮[n].位置 == "上衣") then
						临时_资源管理器 = 扩展_资源管理器.创建([[角色PAK\男鬼剑士\上衣/sm_coat]] .. Q_鬼剑士装扮[n].编号 .. [[.pak]])
					elseif ( Q_鬼剑士装扮[n].位置 == "下装") then
						临时_资源管理器 = 扩展_资源管理器.创建([[角色PAK\男鬼剑士\下装/sm_pants]] .. Q_鬼剑士装扮[n].编号 .. [[.pak]])
					elseif ( Q_鬼剑士装扮[n].位置 == "鞋") then
						临时_资源管理器 = 扩展_资源管理器.创建([[角色PAK\男鬼剑士\鞋子/sm_shoes]] .. Q_鬼剑士装扮[n].编号 .. [[.pak]])
					elseif ( Q_鬼剑士装扮[n].位置 == "头部") then
						临时_资源管理器 = 扩展_资源管理器.创建([[角色PAK\男鬼剑士\发型/sm_hair]] .. Q_鬼剑士装扮[n].编号 .. [[.pak]])
					elseif ( Q_鬼剑士装扮[n].位置 == "胸部") then
						临时_资源管理器 = 扩展_资源管理器.创建([[角色PAK\男鬼剑士\胸部/sm_neck]] .. Q_鬼剑士装扮[n].编号 .. [[.pak]])
					elseif ( Q_鬼剑士装扮[n].位置 == "武器") then
						临时_资源管理器 = 扩展_资源管理器.创建( Q_鬼剑士装扮[n].编号 )
					end

					local 临时特效 = {

						动画 =  wfox_pak.创建(临时_资源管理器,210 * (Q_鬼剑士装扮[n].动画状态[i].索引-1)+210,false) ,
						名称 = Q_鬼剑士装扮[n].名称,
						位置 = Q_鬼剑士装扮[n].位置,
						层次 = Q_鬼剑士装扮[n].动画状态[i].层次,
						索引 = Q_鬼剑士装扮[n].动画状态[i].索引,
						扩展_资源管理器 = 临时_资源管理器
					}

					临时特效.动画:置中心点(230,330)
					table.insert(临时特效组,临时特效)

					临时_资源管理器:销毁()
					临时_资源管理器 = nil
				end

				break
			end
		end

		for n=table.getn(self.纸娃娃组),1,-1 do
			if ( self.纸娃娃组[n].位置 == 位置 ) then
				--self.纸娃娃组[n].动画:销毁()
				self.纸娃娃组[n].动画 = nil
				--self.纸娃娃组[n].扩展_资源管理器:销毁()

				Q_包裹窗口.纸娃娃动画组[n].动画 = nil

				table.remove(Q_包裹窗口.纸娃娃动画组,n)
				table.remove(self.纸娃娃组,n)
			end
		end

		for n=1,table.getn(临时特效组) do
			临时特效组[n].动画.时间累积 = self.身体.时间累积
			临时特效组[n].动画.全局计次 = self.身体.全局计次
			临时特效组[n].动画.当前帧   = self.身体.当前帧

			local 包裹面板纸娃娃 = 复制表(临时特效组[n])

			table.insert(Q_包裹窗口.纸娃娃动画组,包裹面板纸娃娃)
			table.insert(self.纸娃娃组,临时特效组[n])

			if ( 位置 == "武器") then
				self.武器_B  = 临时特效组[n].动画
			end

		end

		table.sort(self.纸娃娃组,self.纸娃娃排序)
		table.sort(Q_包裹窗口.纸娃娃动画组,self.纸娃娃排序)

		Q_包裹窗口:重置纸娃娃()

		临时特效组 = nil

		self:动作更新()

	end

end

--=============================================================================--
-- ■ 更新
--=============================================================================--
function 主角_男鬼剑士:更新()

	if(引擎.取时间戳() - self.命中时间 + 28 < self.角色属性.硬直)then
		return
	end

	if(self.死亡倒地==false)then

		self.上一帧动画 = self.身体:取间隔帧()
		self:动作更新()
	end

	if ( self:是否在攻击状态() == false) then
		self.地平线  = self.坐标.y
	end

	self.上次位置.x = self.坐标.x
	self.上次位置.y = self.坐标.y
	self.上次地平线  = self.地平线

	self.地图坐标.x = self.坐标.x
	self.地图坐标.y = self.坐标.y

	if(self.状态 == "裂波斩_Q")then
		self:裂波斩偏移()
	end

	local A击中,B击中 = false ,false

	if( self.状态 ~= "死亡" ) then

		if (Q_屏幕焦点) then

			if (引擎.按键按下(键_键盘左) ) then
				最后按下 = "左键"
			end

			if (引擎.按键按下(键_键盘右) ) then
				最后按下 = "右键"
			end

			self:技能快捷键触发()

			if ( self:是否在攻击状态() == false and self:是否在跳跃状态() == false and self:是否在被攻击状态() == false and self.状态 ~= "格挡" ) then
				self:移动逻辑()
				self.地平线  = self.坐标.y
			end

			if ( self:是否在跳跃状态() == false and self:是否在被攻击状态() == false and self.状态 ~= "格挡" and self:是否在释放技能状态() == false ) then
				self:普攻逻辑()
			end

			--判定攻击检测
			if( self:是否在攻击状态() ) then
				for n=1,table.getn(Q_屏幕怪物组) do
					if(Q_屏幕怪物组[n].死亡 ~= true) then
						self:攻击判断校正(n)
					end
				end
			end

		end

		if ( self.击退力量 > 0) then
			self.击退力量 = self.击退力量 - self.击退速度
			self:X方向位移(self.击退力量 * self.击退方向 )
		end

		if ( self:是否在被攻击状态() == false  and self.状态 ~= "格挡" ) then
			self:跳跃逻辑()
		end

		self:被攻击打飞逻辑 ()

		if (self.状态 == "格挡") then
			if (引擎.按键按住(self.最后技能按键) == false ) then
				self.状态 = "静止"
			end
		end

		if (self.状态 == "倒地") then

			if(self.角色属性.HP <= 0) then
				self.状态 = "死亡"
				self.死亡倒地 = true

			else
				self.落地时间计次 = self.落地时间计次 + dt

				if (self.落地时间计次 > 0.5) then
					self:改变动作("静止")
				end

			end

		end

		if (self.状态 == "被击中A" or self.状态 == "被击中B") then

			if (self.被攻击信息.方向 == 1) then
				self:X方向位移(1.5)
			else
				self:X方向位移(-1.5)
			end

			if ( 引擎.取时间戳() - self.被攻击信息.时间 > self.被攻击硬直 + 200) then
				self:改变动作("静止")
			end
		end

	else

		if (self.上一帧动画 == 4) then
			self.死亡倒地 = true
		end

	end

	self:技能动作逻辑()


	self:碰撞检测()
	Q_画面偏移.x ,Q_画面偏移.y = 取画面坐标(self.坐标.x,self.坐标.y,Q_地图宽度,Q_地图高度,800,600)

	self.拥有捡取物品 = nil

end

--=============================================================================--
-- ■ 显示影子
--=============================================================================--
function 主角_男鬼剑士:显示影子()

	if ( Q_地图配置.阴影 == "阳光" ) then

		self.身体.影子可视 = true
	    self.身体.影子透明度 = 125
		self.身体.影子y偏移 = self.身体.碎图片精灵:取高度()*0.6

		if(self:是否在跳跃状态())then

			self.身体.影子_跳跃偏移.x = 0
			self.身体.影子_跳跃偏移.y = self.地平线 -  self.坐标.y + self.弹跳力 *3 -10

		else
			self.身体.影子_跳跃偏移.x = 0
			self.身体.影子_跳跃偏移.y = 0
		end

	elseif(Q_地图配置.阴影 == "灯光")then

		self.身体.影子可视 = true
		self.身体.影子透明度 = 25
		self.身体.影子y偏移 = self.身体.碎图片精灵:取高度()*0.6

		if(self:是否在跳跃状态())then

			self.身体.影子_跳跃偏移.x = 0
			self.身体.影子_跳跃偏移.y = self.地平线 -  self.坐标.y + self.弹跳力 *3 -10

		else
			self.身体.影子_跳跃偏移.x = 0
			self.身体.影子_跳跃偏移.y = 0
		end

	else

		self.身体:置颜色(ARGB(50,255,255,255))
		self.发型:置颜色(ARGB(50,255,255,255))
		self.上衣_A:置颜色(ARGB(50,255,255,255))
		self.下装_A:置颜色(ARGB(50,255,255,255))
		self.下装_B:置颜色(ARGB(50,255,255,255))
		self.鞋子_A:置颜色(ARGB(50,255,255,255))
		self.鞋子_B:置颜色(ARGB(50,255,255,255))
		self.武器_A:置颜色(ARGB(50,255,255,255))
		self.武器_B:置颜色(ARGB(50,255,255,255))

		self.身体.影子可视 = false

	end

end

--=============================================================================--
-- ■ 显示
--=============================================================================--
function 主角_男鬼剑士:显示()

	local 抖动值 = 0

	Q_角色地面光环精灵:显示(self.坐标.x + Q_画面偏移.x - 62.5 + (self.方向 * 2.5),self.坐标.y + Q_画面偏移.y - 15)

	self:显示影子()

	if(self.保存的精灵_颜色值 > 0) then
		self.保存的精灵:置混合(混合_单色)
		self.保存的精灵_颜色值 = self.保存的精灵_颜色值 - 5
		self.保存的精灵:置颜色(ARGB(self.保存的精灵_颜色值 ,255,255,255))
		self.保存的精灵:置坐标_高级(self.保存精灵显示位置.x,self.保存精灵显示位置.y,0,self.固定白影,1)
		self.保存的精灵:显示()

	end

	if (self.抖动 >0) then
		self.抖动 = self.抖动 - dt
		抖动值 = 引擎.取随机整数(-3,3)
	else
		self.抖动 = 0
	end

	for n=1,table.getn(self.纸娃娃组) do
		self.纸娃娃组[n].动画:置坐标_高级(self.坐标.x + Q_画面偏移.x + 抖动值 ,self.坐标.y + Q_画面偏移.y + self.跳跃偏移,self.方向,1,0,true)
		--x坐标 y坐标 旋转弧度数 水平缩放系数 垂直缩放系数
		self.纸娃娃组[n].动画:显示()
	end

	文字_描边显示(文字, self.坐标.x - (文字:取宽度(string.format("Lv.%d %s",self.角色属性.等级,self.角色属性.名称))/2) + Q_画面偏移.x  , self.坐标.y - 130 + Q_画面偏移.y + self.跳跃偏移,
					string.format("Lv.%d %s",self.角色属性.等级,self.角色属性.名称), 颜色_白, 颜色_黑)

	self:掉血动画显示()

	--Q_技能进度条:显示()

	if (Q_调试) then
		引擎.画矩形(self.坐标.x + Q_画面偏移.x ,self.坐标.y + Q_画面偏移.y, self.坐标.x + Q_画面偏移.x + 10 * self.方向,self.坐标.y + Q_画面偏移.y - 10,红)
		文字_描边显示(文字, self.坐标.x + (文字:取宽度(string.format("主角坐标:%d %d 状态:%s",self.坐标.x,self.坐标.y,self.状态))/2) - 20 + Q_画面偏移.x  , self.坐标.y + Q_画面偏移.y,
						string.format("主角坐标:%d %d 状态:%s",self.坐标.x,self.坐标.y,self.状态), 颜色_白, 颜色_蓝)

		self.武器_A.包围盒显示 = true
		self.武器_B.包围盒显示 = true
	else
		self.武器_A.包围盒显示 = false
		self.武器_B.包围盒显示 = false
	end

end

--=============================================================================--
-- ■ 被攻击
--=============================================================================--
function 主角_男鬼剑士:被攻击(攻击来源,攻击方式,攻击方向,掉血值,最大掉血值)


	if ( self.角色属性.HP > 0 and self.无敌 == false) then

		self.被攻击信息.方向 = 攻击方向
		self.被攻击信息.来源 = 攻击来源
		self.被攻击信息.方式 = 攻击方式
		self.被攻击信息.时间 = 引擎.取时间戳()
		self.跳跃攻击 = false
		self.跳跃偏移 = 0

		self.技能特效.已经消失 = true

		--Q_技能进度条:消失()

		if(self.动作暂停 ) then
			self:PAK动画继续()
		end

		if (self.状态 ~= "格挡" and self.霸体 == false) then
			if (self.方向 == 攻击方向) then
				self.方向  = - self.方向
			end
		end

		if (self.状态 == "格挡" ) then

			if ( self.方向 ~= 攻击方向) then

				掉血值 = 取整( 掉血值 * 0.4 )  --格挡吸收 60%伤害
				Q_系统:显示AS特效(Q_打击_特效_管理器,"格挡火花",Q_主角.坐标.x+ (Q_主角.方向*112),Q_主角.坐标.y-150,1,"普通",攻击方向,1)
				格挡成功音效:播放()

			else
				self.方向  = - self.方向
				if (引擎.取随机整数(1,2)==1) then
					self:改变动作("被击中A")
				else
					self:改变动作("被击中B")
				end
				男鬼剑音效.被攻击喊叫音效[引擎.取随机整数(1,3)]:播放()
			end

		else
			if (self.霸体 == false )then

				if ( self:是否在跳跃状态() ) then

					self:被打飞(6,3,50)
				else
					if (引擎.取随机整数(1,2)==1) then
						self:改变动作("被击中A")
					else
						self:改变动作("被击中B")
					end
				end

				男鬼剑音效.被攻击喊叫音效[引擎.取随机整数(1,3)]:播放()

			end
		end


		local 临时掉血特效= {
							激活 = true ,
							显示位置x = self.坐标.x ,
							显示位置y = self.坐标.y - 120 +self.跳跃偏移 ,  --默认-120 or 70
							透明度 = 255 ,
							间隔值x = 0.3 ,
							特效大小 = 0.5 ,
							临时值 = 0 ,
							当前值 = 0 ,
							a = 0 ,
							b = 0 ,
							x = 0 ,
							y = 0 ,
							移动消失 = false,
							数字 =掉血值,
							已经消失 = false
							}
		临时掉血特效.类型 = "数字"

		if (掉血值 > 最大掉血值 * 0.8) then
			临时掉血特效.特效大小 = 0.7
		else
		end

		table.insert(self.掉血特效组,临时掉血特效)

		Q_主角.命中时间 = 引擎.取时间戳()

		self.角色属性.HP  = self.角色属性.HP - 掉血值
		if(self.角色属性.HP <= 0) then
			self.角色属性.HP = 0

			if ( self:是否在跳跃状态() == false) then
				self:改变动作("死亡")
			end

			男鬼剑音效.死亡音效:播放()
			self.霸体 = false
			self:霸体效果开关(self.霸体)

		end

		return  true
	end

	return false
end

--=============================================================================--
-- ■ 技能快捷键触发
--=============================================================================--
function 主角_男鬼剑士:技能快捷键触发()


	local 返回值 = 0    -- 1:施放成功  2:未准备好  0:不存在
	local 波动剑触发 = false
	local 十字斩触发 = false
	local 裂波斩触发 = false
	local 月光斩触发 = false
	local 崩山击触发 = false

	if (self:是否在跳跃状态() == true and 引擎.按键按下(键_Z) ) then
		寻找发动技能("银光落刃")
	end

	if (引擎.按键按下(键_Z) and self:是否在跳跃状态() ==false ) then

		if ((self.最后次_右键_按下时间 - self.最后次_下键_按下时间 < 150) and (引擎.取时间戳() - self.最后次_右键_按下时间 < 150)) then
			波动剑触发 = true
		elseif ( (self.最后次_左键_按下时间 - self.最后次_下键_按下时间 < 150) and (引擎.取时间戳() - self.最后次_左键_按下时间 < 150)) then
			波动剑触发 = true
		end

		if ((self.最后次_右键_按下时间 - self.最后次_下键_按下时间 < 150) and (引擎.取时间戳() - self.最后次_右键_按下时间 < 150)) then
			崩山击触发 = true
		elseif ((self.最后次_左键_按下时间 - self.最后次_下键_按下时间 < 150) and (引擎.取时间戳() - self.最后次_左键_按下时间 < 150)) then
			崩山击触发 = true
		end

		if ((self.最后次_左键_按下时间 - self.最后次_上键_按下时间 < 150) and (引擎.取时间戳() - self.最后次_右键_按下时间 < 150)) then
			裂波斩触发 = true
		elseif ((self.最后次_右键_按下时间 - self.最后次_上键_按下时间 < 150) and (引擎.取时间戳() - self.最后次_左键_按下时间 < 150)) then
			裂波斩触发 = true
		end

		if ((self.最后次_右键_按下时间 - self.最后次_左键_按下时间 < 150) and (引擎.取时间戳() - self.最后次_右键_按下时间 < 150)) then
			十字斩触发 = true
		elseif ((self.最后次_左键_按下时间 - self.最后次_右键_按下时间 < 150) and (引擎.取时间戳() - self.最后次_左键_按下时间 < 150)) then
			十字斩触发 = true
		end

		if (波动剑触发 == false and 十字斩触发 == false and 裂波斩触发 == false and 月光斩触发 == false and 崩山击触发 == false and 波动剑触发 == false and 引擎.按键按住(键_键盘上) == false) then
			寻找发动技能("上挑")
			return
		end

	end

	if (引擎.按键按下(键_X) and self.状态 == "前刺攻击" and self.连突刺可用 == true) then
		寻找发动技能("连突刺")
	end

	if (引擎.按键按下(键_X) and self.跳跃攻击次数== 1 and self:是否在释放技能状态() == false) then
		寻找发动技能("空中连斩")
	end

	if (引擎.按键按下(键_X) and self.跳跃攻击次数== 0 and self.跳跃行为 == "后跳" and self:是否在释放技能状态() == false  and self:是否在跳跃状态()==true) then
		寻找发动技能("后跳斩")
	end

	if ( self:是否在释放技能状态() == false ) then

		if (引擎.按键按下(键_键盘右)) then

			if (引擎.取时间戳() - self.最后次_右键_按下时间 < 140) then
				self.右键双击 = true
			else
				self.右键双击 = false
			end
			self.最后次_右键_按下时间  = 引擎.取时间戳()

		end

		if (引擎.按键按下(键_键盘左)) then

			if (引擎.取时间戳() - self.最后次_左键_按下时间 < 140) then
				self.左键双击 = true
			else
				self.左键双击 = false
			end
			self.最后次_左键_按下时间  = 引擎.取时间戳()
		end

		if (引擎.按键按下(键_键盘上)) then

			if (引擎.取时间戳() - self.最后次_上键_按下时间 < 140) then
				self.上键双击 = true
			else
				self.上键双击 = false
			end
			self.最后次_上键_按下时间  = 引擎.取时间戳()
		end

		if (引擎.按键按下(键_键盘下)) then

			if (引擎.取时间戳() - self.最后次_下键_按下时间 < 240) then
				self.下键双击 = true
			else
				self.下键双击 = false
			end
			self.最后次_下键_按下时间  = 引擎.取时间戳()
		end

		if (引擎.按键按下(键_X)) then
			self.最后次_X_按下时间  = 引擎.取时间戳()
		end

		if (引擎.按键按下(键_空格)) then
			self.最后次_空格_按下时间  = 引擎.取时间戳()
		end

		if (引擎.按键按下(键_Z)) then
			self.最后次_Z_按下时间  = 引擎.取时间戳()
		end

		--技能快捷判定
		if (引擎.按键按住(键_键盘上))then
			if (引擎.按键按下(键_Z) ) then
				寻找发动技能("鬼斩")
			end
		end

		if ( (self.下键双击 == true) and 引擎.按键按下(键_X) ) then
			寻找发动技能("格挡")
			self.最后技能按键 = 键_X
			self.下键双击 = false
		end

		if ((引擎.按键按住(键_键盘左) or 引擎.按键按住(键_键盘右)) and 引擎.按键按下(键_Z)) then
			寻找发动技能("三段斩")
		end
		if (引擎.按键按下(键_Z) and 裂波斩触发 == false and 崩山击触发 == false and 十字斩触发 == false and 波动剑触发) then
			寻找发动技能("地裂波动剑")
		end
		if (引擎.按键按下(键_Z) and 波动剑触发 == false and 裂波斩触发 == false and 崩山击触发 == false and 十字斩触发) then
			寻找发动技能("十字斩")
		end
		if (引擎.按键按下(键_Z) and 波动剑触发 == false and 崩山击触发 == false and 十字斩触发 == false and 裂波斩触发) then
			寻找发动技能("裂波斩")
		end

		if (引擎.按键按下(键_Z) and 波动剑触发 == false and 十字斩触发 == false and 裂波斩触发 == false and 崩山击触发) then
			寻找发动技能("崩山击")
		end

	end

end

--=============================================================================--
-- ■ 技能动作逻辑
--=============================================================================--
function 主角_男鬼剑士:技能动作逻辑()

	if ( self.状态 == "上挑" ) then

		if (self.上一帧动画 < 2 ) then
			self:X方向位移(self.角色属性.移动速度  * self.方向 * 1.5)
		elseif (self.上一帧动画 == 2 and  self.身体:取间隔帧() == 2 ) then
			self.技能特效 = Q_系统:显示特效(Q_鬼剑士_基础特效_管理器,"上挑",self.坐标.x + self.方向*50,self.坐标.y - 30,1,"普通",self.方向,0.7)
		elseif (self.上一帧动画 == 8 and self.身体:取间隔帧() == 0) then
			self:改变动作("静止")
			self.霸体 = false
			self:霸体效果开关(self.霸体)
		end

	elseif (self.状态 == "鬼斩" ) then

		if (self.上一帧动画 == 2 and self.身体:取间隔帧() == 3 ) then

			Q_系统:显示特效(Q_鬼剑士_基础特效_管理器,"鬼斩a",self.坐标.x,self.坐标.y,1,"普通",self.方向,1)
			self.技能特效 = Q_系统:显示特效(Q_鬼剑士_基础特效_管理器,"鬼斩b",self.坐标.x,self.坐标.y,1,"普通",self.方向,1)

		elseif (self.上一帧动画 == 10 and  self.身体:取间隔帧() == 0 ) then
			self:改变动作("静止")
		end

	elseif (self.状态 == "突刺" ) then

		if (self.上一帧动画 >= 1 and self.上一帧动画 <= 4) then

			self:X方向位移(self.角色属性.移动速度  * self.方向 )
			self.连突刺可用 = false

			if (self.上一帧动画 >=1 and  self.身体:取间隔帧() == 2) then
				--Q_系统:显示特效(Q_鬼剑士_基础特效_管理器, "连突刺影子特效", self.坐标.x + self.方向 * 2, self.坐标.y, 1, "普通", self.方向, 1)
				Q_系统:显示特效(Q_鬼剑士_基础特效_管理器, "连突刺滑动特效", self.坐标.x, self.坐标.y, 1, "普通", self.方向, 1)
			end
		elseif (self.上一帧动画 ==9 and  self.身体:取间隔帧() == 0) then
			self:改变动作("静止")
			self.连突刺可用 = false
		end

	elseif(self.状态 == "银光落刃")then

		Q_系统:显示特效(Q_鬼剑士_基础特效_管理器, "银落刺击", self.坐标.x , self.坐标.y + self.跳跃偏移, 1, "普通", self.方向, 0.9)
		self.落刃计次 = self.落刃计次 + dt
		if(self.落刃计次 > 0.2)then

			if(self.跳跃偏移<0)then
				self:X方向位移(self.角色属性.移动速度 * self.方向 *2)
				self.跳跃偏移 = self.跳跃偏移 + 20
			else
				if(self.银落模式 == "有波")then
					self:改变动作("银光落刃_落地",true)
					self.落刃计次 = 0
				else
					self:改变动作("静止",true)
					self.落刃计次 = 0
					self.跳跃准备时间 = 0
					self.跳跃攻击次数 = 0
					self.跳跃攻击= false
					self.弹跳力 = 0
				end
			end
		end

	elseif(self.状态 == "银光落刃_落地")then

		if(self.落刃计次 == 0)then
			--Q_系统:显示特效(Q_鬼剑士_基础特效_管理器,"银落震地",self.坐标.x,self.坐标.y +15,1,"普通",1,1)
			男鬼剑音效.银落冲击落地音效:播放()
			self.技能特效 = Q_系统:显示特效(Q_鬼剑士_基础特效_管理器,"银落冲击",self.坐标.x,self.坐标.y +8,1,"普通",self.方向,0.8)
		end

		self.落刃计次 = self.落刃计次 + dt
		if (self.落刃计次 > 0.25) then
			self:改变动作("静止")
			self.落刃计次 = 0
			self.跳跃准备时间 = 0
			self.跳跃攻击次数 = 0
			self.跳跃攻击= false
			self.弹跳力 = 0
		end

	elseif (self.状态 == "裂波斩_Q") then

		self.无敌 = true
		if (self.上一帧动画 == 0 and self.身体:取间隔帧() == 0) then
			self.技能特效 = Q_系统:显示特效(Q_鬼剑士_基础特效_管理器, "裂波斩_上斩", self.坐标.x, self.坐标.y, 1, "普通", self.方向, 0.85)
			Q_系统:显示特效(Q_鬼剑士_基础特效_管理器, "裂波斩_尘土", self.坐标.x +45*self.方向, self.坐标.y + 2, 1, "普通", self.方向, 0.85,0.3)
		elseif (self.上一帧动画 == 4 and self.身体:取间隔帧() == 0) then
			if (self.裂波抓到 == true and self.目标怪物 ~= 0) then

				self:改变动作("裂波斩_下斩")
				if(self.裂波计次 == 0)then
					self.技能特效 = Q_系统:显示特效(Q_鬼剑士_基础特效_管理器, "裂波斩_波动", self.坐标.x + self.方向*20, self.坐标.y, 1, "普通", self.方向, 0.83)
					男鬼剑音效.裂波斩下斩音效:播放()

				end

			else
				self:改变动作("静止")
				self.无敌 = false
			end
		end

	elseif (self.状态 == "裂波斩_下斩") then
		self.无敌 = true

		if (self.上一帧动画 == 0 and self.身体:取间隔帧() == 0) then

			Q_系统:显示特效(Q_鬼剑士_基础特效_管理器, "裂波斩_下斩", self.坐标.x, self.坐标.y, 1, "普通", self.方向, 0.88)
			男鬼剑音效.裂波斩下斩喊叫声效:播放()

		elseif (self.上一帧动画 == 5 ) then

			self:改变动作("裂波斩_尾",true)

		end

	elseif(self.状态 == "裂波斩_尾")then
		self.无敌 = true

		if(self.裂波计次 > 0.125 and self.裂波计次 < 0.14)then
			男鬼剑音效.裂波斩旋转音效:播放()
		end

		self.裂波计次 = self.裂波计次 + dt

		if(self.裂波计次 > 1.15)then
			self:改变动作("静止",true)
			self.裂波计次 = 0
			self.无敌 = false
			self.目标怪物 = nil
			self.裂波抓到 = false
		end

	elseif(self.状态 == "崩山击_准备")then

		self.跳跃准备时间 = self.跳跃准备时间+ dt
		if(self.跳跃准备时间>0.1)then
			self:改变动作("崩山击_上升",true)
			self.跳跃准备时间 = 0
		end

	elseif(self.状态 == "崩山击_上升")then

		self:X方向位移(self.角色属性.移动速度 * self.方向 * 1.8)
		if(self.跳跃偏移> -120)then
			self.跳跃偏移 = self.跳跃偏移-8
		else
			self:改变动作("崩山击_落_准备",true)
		end

	elseif(self.状态 == "崩山击_落_准备")then

		if(self.跳跃偏移<-50)then
			self.跳跃偏移 = self.跳跃偏移+8

			if((self.方向 == 1 and 引擎.按键按住(键_键盘左) == false) or(self.方向 == -1 and 引擎.按键按住(键_键盘右) == false) )then
				self:X方向位移(self.角色属性.移动速度 * self.方向 * 2.3)
			end

		else
			self:改变动作("崩山击_落",true)
			男鬼剑音效.崩山击落地音效:播放()
		end

	elseif(self.状态 == "崩山击_落")then

		if(self.跳跃偏移<0)then
			self.跳跃偏移 = self.跳跃偏移+8
		else
			self.跳跃偏移= 0
		end

		if(self.上一帧动画 == 1) then
			self.技能特效 = Q_系统:显示特效(Q_鬼剑士_基础特效_管理器, "崩山击_特效3", self.坐标.x, self.坐标.y, 1, "普通", self.方向, 1)
		end

		if(self.上一帧动画  == 3)then
			self:改变动作("崩山击_落地",true)
		end

	elseif(self.状态 == "崩山击_落地")then

		self.小蹦计次 = self.小蹦计次 + dt

		if(self.小蹦计次 > 0.2)then

			self:改变动作("静止",true)
			self.霸体 = false
			self:霸体效果开关(self.霸体)
			self.跳跃偏移= 0
			self.小蹦计次 = 0
		end

	elseif (self.状态 == "三段斩_1") then

		self:X方向位移( self.角色属性.移动速度 * 1.8 * self.方向)

		if (self.上一帧动画 > 1 and (引擎.按键按下(self.最后技能按键) or 引擎.按键按下(键_Z) and (引擎.按键按下(键_键盘左) or 引擎.按键按下(键_键盘右)))) then
			按键激活 = "三段斩"
		end

		if (self.上一帧动画 <= 10 and self.上一帧动画 > 5) then
			if (引擎.按键按下(键_键盘左) or 引擎.按键按住(键_键盘左)) then
				self.方向 = -1
			end
		end

		if (引擎.按键按下(键_键盘右) or 引擎.按键按住(键_键盘右)) then
			self.方向 = 1
		end

		if (self.上一帧动画 == 1) then

			Q_系统:显示特效(Q_鬼剑士_基础特效_管理器, "三段斩_风A", self.坐标.x - 70 * self.方向, self.坐标.y - 25, 1, "普通", self.方向, 1)
			self.技能特效 = Q_系统:显示特效(Q_鬼剑士_基础特效_管理器, "三段斩_A", self.坐标.x - 25 * self.方向, self.坐标.y + 10, 1, "普通", self.方向, 1)
		elseif (按键激活 == "三段斩") then

			if (self.上一帧动画 == 10) then
				self:改变动作("三段斩_2")
				男鬼剑音效.三段斩二斩音效:播放()
				男鬼剑音效.三段斩喊叫音效[2]:播放()
				按键激活 = ""
			end

		elseif (self.上一帧动画 == 10 and self.身体:取间隔帧() == 0) then
			self:改变动作("静止")
			按键激活 = ""
		end

	elseif (self.状态 == "三段斩_2") then

		self:X方向位移(self.角色属性.移动速度 *2.8 * self.方向)

		if (self.上一帧动画 > 0 and (引擎.按键按下(self.最后技能按键) or 引擎.按键按下(键_Z))) then
			按键激活 = "三段斩2"
		end

		if (self.上一帧动画 <= 5 and self.上一帧动画 >= 4) then
			if (引擎.按键按下(键_键盘左) or 引擎.按键按住(键_键盘左)) then
				self.方向 = -1
			end
		end

		if (引擎.按键按下(键_键盘右) or 引擎.按键按住(键_键盘右)) then
			self.方向 = 1
		end

		if (self.上一帧动画 == 0 and self.身体:取间隔帧() == 1) then

			self.技能特效 = Q_系统:显示特效(Q_鬼剑士_基础特效_管理器, "三段斩_B", self.坐标.x - 22 * self.方向, self.坐标.y - 25, 1, "普通", self.方向, 1)
			Q_系统:显示特效(Q_鬼剑士_基础特效_管理器, "三段斩_风A", self.坐标.x - 100 * self.方向, self.坐标.y - 25, 1, "普通", self.方向, 1)

		elseif (按键激活 == "三段斩2") then

			if (self.上一帧动画 == 5) then
				self:改变动作("三段斩_3")
				男鬼剑音效.三段斩三斩音效:播放()
				男鬼剑音效.三段斩喊叫音效[3]:播放()
				按键激活 = ""
			end

		elseif (self.上一帧动画 == 5 and self.身体:取间隔帧() == 0) then
			self:改变动作("静止")
			按键激活 = ""
		end

	elseif (self.状态 == "三段斩_3") then

		self:X方向位移(self.角色属性.移动速度 * 2.9 * self.方向)

		if (self.上一帧动画 == 0 and self.身体:取间隔帧() == 0) then

			self.技能特效 = Q_系统:显示特效(Q_鬼剑士_基础特效_管理器, "三段斩_C", self.坐标.x, self.坐标.y, 1, "普通", self.方向, 1)
			Q_系统:显示特效(Q_鬼剑士_基础特效_管理器, "三段斩_风B", self.坐标.x - 40 * self.方向, self.坐标.y - 25, 1, "普通", self.方向, 0.8)

		elseif (self.上一帧动画 == 4 and self.身体:取间隔帧() == 0)then
			self:改变动作("静止")
			按键激活 = ""
		end

	elseif (self.状态 == "十字斩_横") then
		if (self.上一帧动画 == 3 and self.身体:取间隔帧() == 4) then
			Q_系统:显示特效( Q_鬼剑士_基础特效_管理器, "十字斩_冲A", self.坐标.x, self.坐标.y, 1, "普通", self.方向, 0.92)
			self.技能特效 = Q_系统:显示特效( Q_鬼剑士_基础特效_管理器, "十字斩_冲B", self.坐标.x, self.坐标.y, 1, "普通", self.方向, 0.92)

		elseif (self.上一帧动画 == 10 and self.身体:取间隔帧() == 0) then
			self:改变动作("十字斩_挑")

			男鬼剑音效.十字斩挑音效:播放()
		end
	elseif (self.状态 == "十字斩_挑") then

		if (self.上一帧动画 == 2 and self.身体:取间隔帧() == 0) then
			self:改变动作("十字斩_冲1")
			男鬼剑音效.十字斩放音效:播放()
		end
	elseif (self.状态 == "十字斩_冲1") then

		if (self.上一帧动画 == 0 and self.身体:取间隔帧() == 1) then
			self:改变动作("十字斩_冲2")

		end
	elseif (self.状态 == "十字斩_冲2") then

		if (self.上一帧动画 == 1 and self.身体:取间隔帧() == 0) then

			self:改变动作("静止")
		end

	elseif ( self.状态 == "地裂波动剑" ) then
		self:X方向位移(self.角色属性.移动速度*0.3  * self.方向 )

		if (self.上一帧动画 == 1 and  self.身体:取间隔帧() == 2 ) then
			self.技能特效 = Q_系统:显示特效(Q_鬼剑士_基础特效_管理器,"地裂A",self.坐标.x,self.坐标.y,1,"普通",self.方向,0.92)
		elseif (self.上一帧动画 == 2 and  self.身体:取间隔帧() == 3 ) then
			self.技能特效 = Q_系统:显示特效(Q_鬼剑士_基础特效_管理器,"地裂B",self.坐标.x,self.坐标.y,1,"普通",self.方向,0.92)

		elseif (self.上一帧动画 == 8 and  self.身体:取间隔帧() == 0 ) then
			self:改变动作("静止")
		end

	elseif (self.状态 == "月光斩_1") then

		if (self.上一帧动画 > 0 and 引擎.按键按下(self.最后技能按键)) then
			按键激活 = "月光斩"
		end
		self:X方向位移(self.角色属性.移动速度 * 0.35 * self.方向)

		if (self.上一帧动画 == 0 and self.身体:取间隔帧() == 0) then
			self.技能特效 = Q_系统:显示特效(Q_鬼剑士_基础特效_管理器, "月光斩_1", self.坐标.x - (2 * self.方向), self.坐标.y - 20, 1, "普通", self.方向, 0.92)

		elseif (按键激活 == "月光斩") then

			if (self.上一帧动画 == 4 and self.身体:取间隔帧() == 0) then

				self:改变动作("月光斩_2")

				按键激活 = ""
			end
		elseif (self.上一帧动画 == 4 and self.身体:取间隔帧() == 0) then
			self:改变动作("静止")

		end

	elseif (self.状态 == "月光斩_2") then

		self:X方向位移(self.角色属性.移动速度 * 0.6 * self.方向)
		if (self.上一帧动画 == 0 and self.身体:取间隔帧() == 0) then
			self.技能特效 = Q_系统:显示特效(Q_鬼剑士_基础特效_管理器, "月光斩_2", self.坐标.x - (5 * self.方向), self.坐标.y - 35, 1, "普通", self.方向, 0.92)
			男鬼剑音效.月光斩挑释放音效:播放()

			Q_系统:显示特效(Q_鬼剑士_基础特效_管理器, "月光斩_3", self.坐标.x + (5 * self.方向), self.坐标.y + 28, 1, "普通", self.方向, 0.86)

		elseif (self.上一帧动画 >= 4 and self.身体:取间隔帧() == 0) then
			self:改变动作("静止")
		end



	end

end


--=============================================================================--
-- ■ 攻击判断校正
--=============================================================================--
function 主角_男鬼剑士:攻击判断校正(n)

	Q_屏幕怪物组[n].来源ID = self.id

	if (self.状态 == "上挑" and self.上一帧动画 >= 3 and self.上一帧动画 < 6 and  math.abs(self.地平线 - Q_屏幕怪物组[n].地平线) <= self.Y轴攻击范围) then

		if(__包围盒碰撞检测(self.武器_B.动画包围盒,Q_屏幕怪物组[n].身体.动画包围盒) or __包围盒碰撞检测(self.技能特效.特效动画.动画包围盒,Q_屏幕怪物组[n].身体.动画包围盒))then
			if( Q_屏幕怪物组[n]:被攻击("鬼剑士",self.状态,1000,true,true,self:伤害计算("上挑",Q_屏幕怪物组[n])) )then
				if ( Q_屏幕怪物组[n].可击飞) then

					if (Q_屏幕怪物组[n].状态 == "倒地") then
						Q_屏幕怪物组[n]:被打飞(4,1,false,false)
					else
						Q_屏幕怪物组[n]:被打飞(9,1,true,false)
					end
					if(self.武器 == "钝器" or self.武器 == "") then
						Q_系统:显示AS特效(Q_打击_特效_管理器,"打击三_钝器",Q_屏幕怪物组[n].坐标.x,Q_屏幕怪物组[n].坐标.y - Q_屏幕怪物组[n]:取素材中心点Y(),1,"普通",self.方向,0.8)
					else
						Q_系统:显示AS特效(Q_打击_特效_管理器,"打击三_刀类new",Q_屏幕怪物组[n].坐标.x,Q_屏幕怪物组[n].坐标.y - Q_屏幕怪物组[n]:取素材中心点Y(),1,"普通",self.方向,0.8)
					end
				end
				self:普攻武器判断(n)
			end
		end
		return
	end

	if (self.状态 == "鬼斩" and self.上一帧动画 >= 3 and self.上一帧动画 < 6 and math.abs(self.地平线 - Q_屏幕怪物组[n].地平线) <= self.Y轴攻击范围 - 10) then
		if(__包围盒碰撞检测(self.技能特效.特效动画.动画包围盒,Q_屏幕怪物组[n].身体.动画包围盒))then
			if( Q_屏幕怪物组[n]:被攻击("鬼剑士",self.状态,1000,true,true,self:伤害计算("鬼斩",Q_屏幕怪物组[n])) )then
				if ( Q_屏幕怪物组[n].可击飞) then
					Q_屏幕怪物组[n]:被打飞(6,5,true,false)
					暗属性击中音效:播放()
					Q_系统:显示AS特效(Q_打击_特效_管理器,"暗属性攻击_1",Q_屏幕怪物组[n].坐标.x,Q_屏幕怪物组[n].坐标.y - Q_屏幕怪物组[n]:取素材中心点Y(),1,"普通",self.方向,1)
					Q_系统:显示AS特效(Q_打击_特效_管理器,"暗属性攻击_2",Q_屏幕怪物组[n].坐标.x,Q_屏幕怪物组[n].坐标.y - Q_屏幕怪物组[n]:取素材中心点Y(),1,"普通",self.方向,1)
				end

			end
		end
		return
	end

	if (self.状态 == "裂波斩_Q" and self.上一帧动画 >= 2 and math.abs(self.地平线 - Q_屏幕怪物组[n].地平线) <= self.Y轴攻击范围 - 8 and __包围盒碰撞检测(self.技能特效.特效动画.动画包围盒,Q_屏幕怪物组[n].身体.动画包围盒)) then
		if (Q_屏幕怪物组[n].状态 == "倒地") then
			return
		end
		if (Q_屏幕怪物组[n]:被攻击("主角", "裂波斩",1000, true,true,self:伤害计算("裂波斩_Q",Q_屏幕怪物组[n]))) then
			self.裂波抓到 = true

			Q_屏幕怪物组[self.目标怪物].跳跃偏移 = -55--self.坐标.y - 40
			Q_屏幕怪物组[self.目标怪物]:改变动作("被受制",true)
			Q_系统:显示AS特效(Q_打击_特效_管理器,"打击三_刀类new",Q_屏幕怪物组[n].坐标.x,Q_屏幕怪物组[n].坐标.y - Q_屏幕怪物组[n]:取素材中心点Y(),1,"普通",self.方向,1) -- -50
		end
		return
	end

	if(self.状态 == "裂波斩_尾" and math.abs(self.地平线 - Q_屏幕怪物组[n].地平线) <= self.Y轴攻击范围 + 15 and __包围盒碰撞检测(self.技能特效.特效动画.动画包围盒,Q_屏幕怪物组[n].身体.动画包围盒))then

		if(self.裂波计次 < 0.8)then
			if(Q_屏幕怪物组[n]:被攻击("主角", self.状态,250,false,false,self:伤害计算("裂波斩_尾",Q_屏幕怪物组[n])))then

				Q_系统:显示AS特效(Q_打击_特效_管理器,"打击一_钝器",Q_屏幕怪物组[n].坐标.x,Q_屏幕怪物组[n].坐标.y - Q_屏幕怪物组[n]:取素材中心点Y(),1,"普通",self.方向,1) -- -35

			end
			男鬼剑音效.裂波斩击中音效:播放()
		end

		if(self.裂波计次 > 0.82)then
			if(Q_屏幕怪物组[n]:被攻击("主角","裂波斩尾",800,false,false,self:伤害计算("裂波斩_尾",Q_屏幕怪物组[n])))then
				Q_系统:显示AS特效(Q_打击_特效_管理器,"打击一_钝器",Q_屏幕怪物组[n].坐标.x,Q_屏幕怪物组[n].坐标.y - Q_屏幕怪物组[n]:取素材中心点Y(),1,"普通",self.方向,1) -- -35
				Q_屏幕怪物组[n]:被打飞(2, 8, true, true)
			end
			男鬼剑音效.裂波斩击中音效:播放()
		end
	end

	if ( self.状态 == "崩山击_落_准备" and math.abs(self.地平线 - Q_屏幕怪物组[n].地平线) <= self.Y轴攻击范围 - 10 ) then

		if( __包围盒碰撞检测(self.武器_B.动画包围盒,Q_屏幕怪物组[n].身体.动画包围盒) )then

			if Q_屏幕怪物组[n]:被攻击("主角",self.状态,100, false,self:伤害计算("崩山击",Q_屏幕怪物组[n])) then
				Q_屏幕怪物组[n]:被打飞(2, 1, true, true)
				self:普攻武器判断(n)
			end

		end
		return
	end

	if (self.状态 == "崩山击_落" ) then

		if( __包围盒碰撞检测(self.武器_A.动画包围盒,Q_屏幕怪物组[n].身体.动画包围盒) and math.abs(self.地平线 - Q_屏幕怪物组[n].地平线) <= self.Y轴攻击范围 - 3)then --武器命中判断

			if Q_屏幕怪物组[n]:被攻击("主角",self.状态,300, false,true,self:伤害计算("崩山击",Q_屏幕怪物组[n])) then
				Q_屏幕怪物组[n]:被打飞(4, 1)
				self:普攻武器判断(n)
			end
		end

		if(self.上一帧动画 > 1 and __包围盒碰撞检测(self.技能特效.特效动画.动画包围盒,Q_屏幕怪物组[n].身体.动画包围盒) and math.abs(self.地平线 - Q_屏幕怪物组[n].地平线) <= self.Y轴攻击范围 - 5)then
			if Q_屏幕怪物组[n]:被攻击("主角",self.状态,500, falsed,true,self:伤害计算("崩山击",Q_屏幕怪物组[n])) then
				Q_屏幕怪物组[n]:被打飞(4, 2, true, false)
				self:普攻武器判断(n)
			end
		end
		return
	end

	if (self.状态 == "崩山击_落地" and math.abs(self.地平线 - Q_屏幕怪物组[n].地平线) <= self.Y轴攻击范围 - 10) then

		if(__包围盒碰撞检测(self.技能特效.特效动画.动画包围盒,Q_屏幕怪物组[n].身体.动画包围盒))then
			if( Q_屏幕怪物组[n]:被攻击("主角",self.状态,500, false,true,self:伤害计算("崩山击_冲击波",Q_屏幕怪物组[n])) ) then
				Q_屏幕怪物组[n]:被打飞(4, 2, true, false)
			end
		end
		return
	end

	if( ((self.状态 == "十字斩_横" and self.上一帧动画 >= 4) or (self.状态 == "十字斩_挑" and self.上一帧动画 >= 2)) and math.abs(self.地平线 - Q_屏幕怪物组[n].地平线) <= self.Y轴攻击范围 - 5 )then

		if(__包围盒碰撞检测(self.技能特效.特效动画.动画包围盒,Q_屏幕怪物组[n].身体.动画包围盒))then
			if(Q_屏幕怪物组[n]:被攻击("鬼剑士", self.状态,500,true,true,self:伤害计算("十字斩_物理",Q_屏幕怪物组[n])))then

				男鬼剑音效.十字斩击中A音效:播放()
				Q_系统:显示AS特效(Q_打击_特效_管理器,"打击三_刀类new",Q_屏幕怪物组[n].坐标.x , Q_屏幕怪物组[n].坐标.y - Q_屏幕怪物组[n]:取素材中心点Y(),1,"普通",self.方向,0.8)

				if (Q_屏幕怪物组[n].状态 == "被攻击_空中_起" or Q_屏幕怪物组[n].状态 == "被攻击_空中_落") then
					Q_屏幕怪物组[n]:被打飞( 4, 0, true, true)
				end
			end
		end
		return
	end

	if( ((self.状态 == "十字斩_冲2" )) and math.abs(self.地平线 - Q_屏幕怪物组[n].地平线) <= self.Y轴攻击范围 - 5 )then

		if(__包围盒碰撞检测(self.技能特效.特效动画.动画包围盒,Q_屏幕怪物组[n].身体.动画包围盒))then
			if(Q_屏幕怪物组[n]:被攻击("鬼剑士",self.状态,500,true,true,self:伤害计算("十字斩_血十字",Q_屏幕怪物组[n])))then

				男鬼剑音效.十字斩击中B音效:播放()
				Q_系统:显示AS特效(Q_打击_特效_管理器,"打击二_刀类new",Q_屏幕怪物组[n].坐标.x ,Q_屏幕怪物组[n].坐标.y - Q_屏幕怪物组[n]:取素材中心点Y(),1,"普通",self.方向,0.8)

				if (Q_屏幕怪物组[n].状态 == "被攻击_空中_起" or Q_屏幕怪物组[n].状态 == "被攻击_空中_落") then
					Q_屏幕怪物组[n]:被打飞( 2, 0, true, true)
				end

			end
		end
		return
	end

	if (self.状态 == "地裂波动剑" and  self.上一帧动画 >= 2 and math.abs(self.地平线 - Q_屏幕怪物组[n].地平线) <= self.Y轴攻击范围 - 3 ) then

		if(__包围盒碰撞检测(self.武器_B.动画包围盒,Q_屏幕怪物组[n].身体.动画包围盒) or __包围盒碰撞检测(self.技能特效.特效动画.动画包围盒,Q_屏幕怪物组[n].身体.动画包围盒))then
			if( Q_屏幕怪物组[n]:被攻击("鬼剑士",self.状态,1000,true,true,self:伤害计算("地裂波动剑",Q_屏幕怪物组[n])) )then
				男鬼剑音效.波动剑击中音效[引擎.取随机整数(1,2)]:播放()
				if ( Q_屏幕怪物组[n].可击飞) then
					Q_屏幕怪物组[n]:被打飞(4,3,true,true)
					Q_系统:显示AS特效(Q_打击_特效_管理器,"打击三_刀类new",Q_屏幕怪物组[n].坐标.x,Q_屏幕怪物组[n].坐标.y - Q_屏幕怪物组[n]:取素材中心点Y(),1,"普通",self.方向,0.65)
				end
			end
		end
		return
	end

	if (self.状态 == "三段斩_1" and self.上一帧动画 >= 2 and math.abs(self.地平线 - Q_屏幕怪物组[n].地平线) <= self.Y轴攻击范围 - 5) then

		if(__包围盒碰撞检测(self.武器_B.动画包围盒,Q_屏幕怪物组[n].身体.动画包围盒) or __包围盒碰撞检测(self.技能特效.特效动画.动画包围盒,Q_屏幕怪物组[n].身体.动画包围盒))then
			if (Q_屏幕怪物组[n]:被攻击("鬼剑士", self.状态,1000,false,true,self:伤害计算("三段斩",Q_屏幕怪物组[n]))) then
				Q_系统:显示AS特效(Q_打击_特效_管理器,"打击二_刀类new",Q_屏幕怪物组[n].坐标.x,Q_屏幕怪物组[n].坐标.y - Q_屏幕怪物组[n]:取素材中心点Y(),1,"普通",self.方向,0.8)
			end
		end
		return
	end

	if (self.状态 == "三段斩_2" and self.上一帧动画 >= 1 and math.abs(self.地平线 - Q_屏幕怪物组[n].地平线) <= self.Y轴攻击范围 - 2) then

		if(__包围盒碰撞检测(self.武器_B.动画包围盒,Q_屏幕怪物组[n].身体.动画包围盒) or __包围盒碰撞检测(self.技能特效.特效动画.动画包围盒,Q_屏幕怪物组[n].身体.动画包围盒))then
			if (Q_屏幕怪物组[n]:被攻击("鬼剑士", self.状态,1000,false,true,self:伤害计算("三段斩",Q_屏幕怪物组[n]))) then
				Q_系统:显示AS特效(Q_打击_特效_管理器,"打击三_刀类new",Q_屏幕怪物组[n].坐标.x,Q_屏幕怪物组[n].坐标.y - Q_屏幕怪物组[n]:取素材中心点Y(),1,"普通",self.方向,0.8)
			end
		end
		return
	end

	if (self.状态 == "三段斩_3" and self.上一帧动画 >= 1 and math.abs(self.地平线 - Q_屏幕怪物组[n].地平线) <= self.Y轴攻击范围 - 10) then

		if(__包围盒碰撞检测(self.武器_B.动画包围盒,Q_屏幕怪物组[n].身体.动画包围盒) or __包围盒碰撞检测(self.技能特效.特效动画.动画包围盒,Q_屏幕怪物组[n].身体.动画包围盒))then
			if (Q_屏幕怪物组[n]:被攻击("鬼剑士", self.状态,1000,false,true,self:伤害计算("三段斩终",Q_屏幕怪物组[n]))) then
				Q_系统:显示AS特效(Q_打击_特效_管理器,"打击一_刀类new",Q_屏幕怪物组[n].坐标.x,Q_屏幕怪物组[n].坐标.y - Q_屏幕怪物组[n]:取素材中心点Y(),1,"普通",self.方向,0.8)
				if (Q_屏幕怪物组[n].状态 ~= "倒地") then
					Q_屏幕怪物组[n]:被打飞( 4, 3, true, true)
				else
					Q_屏幕怪物组[n]:被打飞(3, 1, true, true)
				end
			end
		end
		return
	end

	if (self.状态 == "月光斩_1" and self.上一帧动画 >= 1 and math.abs(self.地平线 - Q_屏幕怪物组[n].地平线) <= self.Y轴攻击范围 - 10) then

		if(__包围盒碰撞检测(self.武器_B.动画包围盒,Q_屏幕怪物组[n].身体.动画包围盒) or __包围盒碰撞检测(self.技能特效.特效动画.动画包围盒,Q_屏幕怪物组[n].身体.动画包围盒))then
			if (Q_屏幕怪物组[n]:被攻击("鬼剑士", self.状态,800,true,true,self:伤害计算("月光斩",Q_屏幕怪物组[n]))) then
				Q_屏幕怪物组[n]:被打飞(1, 1, true, true)
				Q_系统:显示AS特效(Q_打击_特效_管理器,"暗属性攻击_1",Q_屏幕怪物组[n].坐标.x,Q_屏幕怪物组[n].坐标.y - Q_屏幕怪物组[n]:取素材中心点Y(),1,"普通",self.方向,0.8)
				Q_系统:显示AS特效(Q_打击_特效_管理器,"暗属性攻击_2",Q_屏幕怪物组[n].坐标.x,Q_屏幕怪物组[n].坐标.y - Q_屏幕怪物组[n]:取素材中心点Y(),1,"普通",self.方向,0.8)
				暗属性击中音效:播放()
			end
		end
		return
	end

	if (self.状态 == "月光斩_2" and self.上一帧动画 >= 1 and math.abs(self.地平线 - Q_屏幕怪物组[n].地平线) <= self.Y轴攻击范围 - 5) then

		if(__包围盒碰撞检测(self.武器_B.动画包围盒,Q_屏幕怪物组[n].身体.动画包围盒) or __包围盒碰撞检测(self.技能特效.特效动画.动画包围盒,Q_屏幕怪物组[n].身体.动画包围盒))then
			if Q_屏幕怪物组[n]:被攻击("鬼剑士", self.状态,800,true,true,self:伤害计算("月光斩",Q_屏幕怪物组[n])) then
				if( Q_屏幕怪物组[n]:是否在跳跃状态() == false )then
					Q_屏幕怪物组[n]:被打飞(8, 2,true,true)
				else
					Q_屏幕怪物组[n]:被打飞(11, 2,true,true)
				end
				Q_系统:显示AS特效(Q_打击_特效_管理器,"暗属性攻击_1",Q_屏幕怪物组[n].坐标.x,Q_屏幕怪物组[n].坐标.y - Q_屏幕怪物组[n]:取素材中心点Y(),1,"普通",self.方向,0.8)
				Q_系统:显示AS特效(Q_打击_特效_管理器,"暗属性攻击_2",Q_屏幕怪物组[n].坐标.x,Q_屏幕怪物组[n].坐标.y - Q_屏幕怪物组[n]:取素材中心点Y(),1,"普通",self.方向,0.8)
				暗属性击中音效:播放()
			end
		end

		return
	end

	if (self.状态 == "银光落刃" and self.上一帧动画 >= 0 and math.abs(self.地平线 - Q_屏幕怪物组[n].地平线) <= self.Y轴攻击范围 ) then

			if(__包围盒碰撞检测(self.武器_B.动画包围盒,Q_屏幕怪物组[n].身体.动画包围盒))then

				if(Q_屏幕怪物组[n]:被攻击("鬼剑士","银光落刃",1000,true,true,self:伤害计算("银光落刃_落地",Q_屏幕怪物组[n])))then
					if(self.武器 == "钝器" or self.武器 == "") then
						Q_系统:显示AS特效(Q_打击_特效_管理器,"打击一_钝器",Q_屏幕怪物组[n].坐标.x,Q_屏幕怪物组[n].坐标.y - Q_屏幕怪物组[n]:取素材中心点Y(),1,"普通",self.方向,0.8)
					else
						Q_系统:显示AS特效(Q_打击_特效_管理器,"打击一_刀类new",Q_屏幕怪物组[n].坐标.x,Q_屏幕怪物组[n].坐标.y - Q_屏幕怪物组[n]:取素材中心点Y(),1,"普通",self.方向,0.6)
					end
					self:普攻武器判断(n)
				end

			end

		return
	end

	if (self.状态 == "银光落刃_落地" and self.上一帧动画 > 0 and math.abs(self.地平线 - Q_屏幕怪物组[n].地平线) <= self.Y轴攻击范围 * 2) then

		if( __包围盒碰撞检测(self.技能特效.特效动画.动画包围盒 ,Q_屏幕怪物组[n].身体.动画包围盒))then
			if( Q_屏幕怪物组[n]:被攻击("鬼剑士",self.状态,1000,false,true,self:伤害计算("银光落刃_落地",Q_屏幕怪物组[n])) )then

				Q_系统:显示AS特效(Q_打击_特效_管理器,"打击二_钝器",Q_屏幕怪物组[n].坐标.x,Q_屏幕怪物组[n].坐标.y - Q_屏幕怪物组[n]:取素材中心点Y(),1,"普通",self.方向,0.8)

				if(Q_屏幕怪物组[n].可击飞)then
					if(Q_屏幕怪物组[n].状态 ~= "倒地")then
						Q_屏幕怪物组[n]:被打飞(8,3,true,true)
					else
						Q_屏幕怪物组[n]:被打飞(4,1,true,false)
					end
				end
			end
		end
		return
	end


--普攻命中逻辑
	if(self.状态 == "普攻一" and self.上一帧动画 >= 2 and math.abs(self.地平线 - Q_屏幕怪物组[n].地平线) <= self.Y轴攻击范围 )then

		if(__包围盒碰撞检测(self.武器_B.动画包围盒,Q_屏幕怪物组[n].身体.动画包围盒))then

			if( Q_屏幕怪物组[n]:被攻击("鬼剑士",self.状态,1000,true,true,self:伤害计算(0,Q_屏幕怪物组[n])) )then
				self:普攻武器判断(n)
			end
		end
	end

	if(self.状态 == "普攻二" and self.上一帧动画 >= 2 and math.abs(self.地平线 - Q_屏幕怪物组[n].地平线) <= self.Y轴攻击范围 )then

		if(__包围盒碰撞检测(self.武器_B.动画包围盒,Q_屏幕怪物组[n].身体.动画包围盒))then

			if( Q_屏幕怪物组[n]:被攻击("鬼剑士",self.状态,1000,true,true,self:伤害计算(0,Q_屏幕怪物组[n])) )then
				self:普攻武器判断(n)
			end
		end
	end

	if(self.状态 == "普攻三" and self.上一帧动画 >= 2 and math.abs(self.地平线 - Q_屏幕怪物组[n].地平线) <= self.Y轴攻击范围 - 5 )then

		if(__包围盒碰撞检测(self.武器_B.动画包围盒,Q_屏幕怪物组[n].身体.动画包围盒) or __包围盒碰撞检测(self.身体.动画包围盒,Q_屏幕怪物组[n].身体.动画包围盒))then

			if( Q_屏幕怪物组[n]:被攻击("鬼剑士",self.状态,1000,true,true,self:伤害计算(0,Q_屏幕怪物组[n])) )then
				self:普攻武器判断(n)
			end
		end
	end

	if(self.状态 == "前刺攻击" and self.上一帧动画 >= 2 and math.abs(self.地平线 - Q_屏幕怪物组[n].地平线) <= self.Y轴攻击范围 -15 )then

		if(__包围盒碰撞检测(self.武器_B.动画包围盒,Q_屏幕怪物组[n].身体.动画包围盒))then

			if( Q_屏幕怪物组[n]:被攻击("鬼剑士",self.状态,1000,true,true,self:伤害计算(0,Q_屏幕怪物组[n])) )then
				self:普攻武器判断(n)
			end
		end
	end

	if(self.状态 == "突刺" and self.上一帧动画 >= 2 and math.abs(self.地平线 - Q_屏幕怪物组[n].地平线) <= self.Y轴攻击范围 -10 )then

		if(__包围盒碰撞检测(self.武器_B.动画包围盒,Q_屏幕怪物组[n].身体.动画包围盒))then

			if( Q_屏幕怪物组[n]:被攻击("鬼剑士",self.状态,1000,true,true,self:伤害计算(0,Q_屏幕怪物组[n])) )then
				self:普攻武器判断(n)
			end
		end
	end

	if(self.跳跃攻击 and self.上一帧动画 >= 2 and math.abs(self.地平线 - Q_屏幕怪物组[n].地平线) <= self.Y轴攻击范围 - 5 )then

		if(__包围盒碰撞检测(self.武器_B.动画包围盒,Q_屏幕怪物组[n].身体.动画包围盒))then

			if( Q_屏幕怪物组[n]:被攻击("鬼剑士","跳跃攻击",1000,true,true,self:伤害计算(0,Q_屏幕怪物组[n])) )then
				self:普攻武器判断(n)
			end
		end
	end

end

--=============================================================================--
-- ■ 伤害计算 --0 为物理伤害，1为魔法伤害 技能伤害另算
--=============================================================================--
function 主角_男鬼剑士:伤害计算(类型,本次怪物目标)

	local 本次命中值 = 0
	local 最终伤害  = 0
	local 基础伤害  = 0

	local 保底伤害 = 0


	if (类型 == 0) then

		保底伤害 = 取整(self.角色属性.物理攻击力/3) + 引擎.取随机整数(1,3)
		基础伤害 = math.ceil( (self.角色属性.物理攻击力  - 本次怪物目标.属性.物理防御力) * 引擎.取随机小数(0.9 ,1))

		if ( 基础伤害 <= 0 ) then

			最终伤害 = 保底伤害
			基础伤害 = 保底伤害

		else
			基础伤害 = 保底伤害  + 基础伤害
			最终伤害 = 取整( 基础伤害 * 引擎.取随机小数(0.8,1.3) )
		end

		if (引擎.取随机整数(1,100) <= self.角色属性.物理暴击) then -- 出现暴击
			最终伤害 = 取整( 最终伤害 * 引擎.取随机小数(1.1,1.8) )
		end

	elseif (类型 == 1) then

		保底伤害 = 取整(self.角色属性.魔法攻击力/3) + 引擎.取随机整数(1,3)
	    基础伤害 = math.ceil( (self.角色属性.魔法攻击力  - 本次怪物目标.属性.魔法防御力) * 引擎.取随机小数(0.9 ,1))

		if ( 基础伤害 <= 0 ) then

			最终伤害 = 保底伤害
			基础伤害 = 保底伤害

		else
			基础伤害 = 保底伤害  + 基础伤害
			最终伤害 = 取整( 基础伤害 * 引擎.取随机小数(0.8,1.3) )
		end

		if (引擎.取随机整数(1,100) <= self.角色属性.魔法暴击) then -- 出现暴击
			最终伤害 = 取整( 最终伤害 * 引擎.取随机小数(1.1,1.8) )
		end

	elseif (类型 == "上挑") then

		保底伤害 = 取整( ((self.角色属性.物理攻击力*1.2) + (self.角色属性.物理攻击力*0.09)/3) ) + 引擎.取随机整数(1,3)
	    基础伤害 = math.ceil((self.角色属性.物理攻击力*1.2) + (self.角色属性.物理攻击力*0.09) - 本次怪物目标.属性.物理防御力)

		最终伤害,基础伤害 = self:技能伤害逻辑(基础伤害,最终伤害,保底伤害)

	elseif (类型 == "鬼斩") then

		保底伤害 = 取整( (self.角色属性.魔法攻击力*2.6)/3 ) + 引擎.取随机整数(1,3)
	    基础伤害 = math.ceil((self.角色属性.魔法攻击力*2.6) - 本次怪物目标.属性.魔法防御力)

		最终伤害,基础伤害 = self:技能伤害逻辑(基础伤害,最终伤害,保底伤害)

	elseif (类型 == "银光落刃_落地") then

		保底伤害 = 取整( (self.角色属性.物理攻击力*1.35)/3) + 引擎.取随机整数(1,3)
	    基础伤害 = math.ceil((self.角色属性.物理攻击力*1.35) - 本次怪物目标.属性.物理防御力)

		最终伤害,基础伤害 = self:技能伤害逻辑(基础伤害,最终伤害,保底伤害)

	elseif (类型 == "银光落刃") then

		保底伤害 = 取整( (self.角色属性.物理攻击力*1.85)/3) + 引擎.取随机整数(1,3)
	    基础伤害 = math.ceil((self.角色属性.物理攻击力*1.85) - 本次怪物目标.属性.物理防御力)

		最终伤害,基础伤害 = self:技能伤害逻辑(基础伤害,最终伤害,保底伤害)

	elseif (类型 == "裂波斩_Q") then

		保底伤害 = 取整( (self.角色属性.魔法攻击力*0.95)/3) + 引擎.取随机整数(1,3)
	    基础伤害 = math.ceil( (self.角色属性.魔法攻击力*0.95) - 本次怪物目标.属性.魔法防御力)

		最终伤害,基础伤害 = self:技能伤害逻辑(基础伤害,最终伤害,保底伤害)

	elseif (类型 == "裂波斩_尾") then

		保底伤害 = 取整( (self.角色属性.魔法攻击力*1.14 + self.角色属性.魔法攻击力*0.08)/3 ) + 引擎.取随机整数(1,3)
	    基础伤害 = math.ceil( (self.角色属性.魔法攻击力*1.14 + self.角色属性.魔法攻击力*0.08) - 本次怪物目标.属性.魔法防御力)

		最终伤害,基础伤害 = self:技能伤害逻辑(基础伤害,最终伤害,保底伤害)

	elseif (类型 == "崩山击") then

		保底伤害 = 取整( (self.角色属性.物理攻击力*1.25)/3 ) + 引擎.取随机整数(1,3)
	    基础伤害 = math.ceil((self.角色属性.物理攻击力*1.25) - 本次怪物目标.属性.物理防御力)

		最终伤害,基础伤害 = self:技能伤害逻辑(基础伤害,最终伤害,保底伤害)

	elseif (类型 == "崩山击_冲击波") then

		保底伤害 = 取整( (self.角色属性.物理攻击力*1.35)/3 ) + 引擎.取随机整数(1,3)
	    基础伤害 = math.ceil((self.角色属性.物理攻击力*1.35) - 本次怪物目标.属性.物理防御力)

		最终伤害,基础伤害 = self:技能伤害逻辑(基础伤害,最终伤害,保底伤害)

	elseif (类型 == "十字斩_物理") then

		保底伤害 = 取整( (self.角色属性.物理攻击力*0.9)/3 ) + 引擎.取随机整数(1,3)
	    基础伤害 = math.ceil((self.角色属性.物理攻击力*0.9) - 本次怪物目标.属性.物理防御力)

		最终伤害,基础伤害 = self:技能伤害逻辑(基础伤害,最终伤害,保底伤害)

	elseif (类型 == "十字斩_血十字") then

		保底伤害 = 取整( (self.角色属性.魔法攻击力*1.49) + (self.角色属性.魔法攻击力 * 0.11)/3 ) + 引擎.取随机整数(1,3)
	    基础伤害 = math.ceil( (self.角色属性.魔法攻击力*1.49) + (self.角色属性.魔法攻击力 * 0.11) - 本次怪物目标.属性.魔法防御力)

		最终伤害,基础伤害 = self:技能伤害逻辑(基础伤害,最终伤害,保底伤害)


	elseif (类型 == "地裂波动剑") then

		保底伤害 = 取整( self.角色属性.魔法攻击力 + (self.角色属性.魔法攻击力 * 0.07)/3 ) + 引擎.取随机整数(1,3)
	    基础伤害 = math.ceil( self.角色属性.魔法攻击力 + (self.角色属性.魔法攻击力 * 0.07) - 本次怪物目标.属性.魔法防御力)

		最终伤害,基础伤害 = self:技能伤害逻辑(基础伤害,最终伤害,保底伤害)

	elseif (类型 == "三段斩") then

		保底伤害 = 取整( (self.角色属性.物理攻击力 * 1.42) + (self.角色属性.物理攻击力 * 0.12)/3 ) + 引擎.取随机整数(1,3)
	    基础伤害 = math.ceil( (self.角色属性.物理攻击力 * 1.42) + (self.角色属性.物理攻击力 * 0.12) - 本次怪物目标.属性.物理防御力)

		最终伤害,基础伤害 = self:技能伤害逻辑(基础伤害,最终伤害,保底伤害)


	elseif (类型 == "三段斩终") then

		保底伤害 = 取整( (self.角色属性.物理攻击力 * 1.52)/3 ) + 引擎.取随机整数(1,3)
	    基础伤害 = math.ceil( (self.角色属性.物理攻击力) - 本次怪物目标.属性.物理防御力)

		最终伤害,基础伤害 = self:技能伤害逻辑(基础伤害,最终伤害,保底伤害)

	elseif (类型 == "月光斩") then

		保底伤害 = 取整( (self.角色属性.魔法攻击力*2.22) + (self.角色属性.魔法攻击力 * 0.18)/4 ) + 引擎.取随机整数(1,3)
	    基础伤害 = math.ceil( (self.角色属性.魔法攻击力*2.22) + (self.角色属性.魔法攻击力 * 0.18) - 本次怪物目标.属性.魔法防御力)

		最终伤害,基础伤害 = self:技能伤害逻辑(基础伤害,最终伤害,保底伤害)


	end

	return 最终伤害,基础伤害
end

--=============================================================================--
-- ■ 伤害计算 --0 为物理伤害，1为魔法伤害 技能伤害另算
--=============================================================================--
function 主角_男鬼剑士:技能伤害逻辑(基础伤害,最终伤害,保底伤害)

		if ( 基础伤害 <= 0 ) then

			最终伤害 = 保底伤害
			基础伤害 = 保底伤害

		else
			基础伤害 = 保底伤害  + 基础伤害
			最终伤害 = 取整( 基础伤害 * 引擎.取随机小数(0.8,1.3) )
		end

		if (引擎.取随机整数(1,100) <= self.角色属性.物理暴击) then -- 出现暴击
			最终伤害 = 取整( 最终伤害 * 引擎.取随机小数(1.3,2.1) )
		end

	return 最终伤害,基础伤害
end

--=============================================================================--
-- ■ 普攻武器判断
--=============================================================================--
function 主角_男鬼剑士:普攻武器判断(n)

	if(self.武器 == "钝器" or self.武器 == "") then
		男鬼剑音效.普攻钝器击中音效[引擎.取随机整数(1,2)]:播放()
	elseif(self.武器 == "短剑") then
		男鬼剑音效.普攻短剑击中音效[引擎.取随机整数(1,3)]:播放()
	elseif(self.武器 == "太刀") then
		男鬼剑音效.普攻太刀击中音效[引擎.取随机整数(1,2)]:播放()
	elseif(self.武器 == "巨剑") then
	elseif(self.武器 == "光剑") then
	end

	if(self.状态 == "普攻一" or self.状态 == "普攻二" or self.状态 == "普攻三" or self.状态 == "前刺攻击" or self.状态 == "突刺" or self.跳跃攻击 == true)then

		if(self.武器 == "钝器"or self.武器 == "") then

			if (self.状态 == "普攻一") then
				Q_系统:显示AS特效(Q_打击_特效_管理器,"打击一_钝器",Q_屏幕怪物组[n].坐标.x,Q_屏幕怪物组[n].坐标.y - Q_屏幕怪物组[n]:取素材中心点Y(),1,"普通",self.方向,0.8) -- -50
			elseif(self.状态 == "普攻二" )then
				Q_系统:显示AS特效(Q_打击_特效_管理器,"打击二_钝器",Q_屏幕怪物组[n].坐标.x,Q_屏幕怪物组[n].坐标.y - Q_屏幕怪物组[n]:取素材中心点Y(),1,"普通",self.方向,0.8)
			elseif(self.状态 == "普攻三" or self.跳跃攻击)then
				Q_系统:显示AS特效(Q_打击_特效_管理器,"打击三_钝器",Q_屏幕怪物组[n].坐标.x,Q_屏幕怪物组[n].坐标.y - Q_屏幕怪物组[n]:取素材中心点Y(),1,"普通",self.方向,0.8)
			elseif(self.状态 == "前刺攻击" )then
				Q_系统:显示AS特效(Q_打击_特效_管理器,"打击一_钝器",Q_屏幕怪物组[n].坐标.x,Q_屏幕怪物组[n].坐标.y - Q_屏幕怪物组[n]:取素材中心点Y(),1,"普通",self.方向,0.8)
			elseif(self.状态 == "突刺" )then
				Q_系统:显示AS特效(Q_打击_特效_管理器,"打击一_钝器",Q_屏幕怪物组[n].坐标.x,Q_屏幕怪物组[n].坐标.y - Q_屏幕怪物组[n]:取素材中心点Y(),1,"普通",self.方向,0.8)
			end
		else

			if (self.状态 == "普攻一" ) then
				Q_系统:显示AS特效(Q_打击_特效_管理器,"打击一_刀类new",Q_屏幕怪物组[n].坐标.x,Q_屏幕怪物组[n].坐标.y - Q_屏幕怪物组[n]:取素材中心点Y(),1,"普通",self.方向,0.8)
			elseif(self.状态 == "普攻二" )then
				Q_系统:显示AS特效(Q_打击_特效_管理器,"打击二_刀类new",Q_屏幕怪物组[n].坐标.x,Q_屏幕怪物组[n].坐标.y - Q_屏幕怪物组[n]:取素材中心点Y(),1,"普通",self.方向,0.8)
			elseif(self.状态 == "普攻三" or self.跳跃攻击)then
				Q_系统:显示AS特效(Q_打击_特效_管理器,"打击三_刀类new",Q_屏幕怪物组[n].坐标.x,Q_屏幕怪物组[n].坐标.y - Q_屏幕怪物组[n]:取素材中心点Y(),1,"普通",self.方向,0.8)
			elseif(self.状态 == "前刺攻击" )then
				Q_系统:显示AS特效(Q_打击_特效_管理器,"打击二_刀类new",Q_屏幕怪物组[n].坐标.x,Q_屏幕怪物组[n].坐标.y - Q_屏幕怪物组[n]:取素材中心点Y(),1,"普通",self.方向,0.8)
			elseif(self.状态 == "突刺" )then
				Q_系统:显示AS特效(Q_打击_特效_管理器,"打击二_刀类new",Q_屏幕怪物组[n].坐标.x,Q_屏幕怪物组[n].坐标.y - Q_屏幕怪物组[n]:取素材中心点Y(),1,"普通",self.方向,0.8)
			end
		end

		if ( Q_屏幕怪物组[n].可击退 and Q_屏幕怪物组[n]:是否在跳跃状态()  == false and Q_屏幕怪物组[n].跳跃被攻击 == false ) then
			if(self.状态 == "突刺")then
				Q_屏幕怪物组[n]:被击退(14,1)
			else
				Q_屏幕怪物组[n]:被击退(8,1)
			end
		end

		if (Q_屏幕怪物组[n].可击飞) then
			if (self.状态 == "普攻三" ) then
				if (Q_屏幕怪物组[n].状态 == "倒地") then
					Q_屏幕怪物组[n]:被打飞(4,1,false,false)
				else
					Q_屏幕怪物组[n]:被打飞(7,1,true,true)
				end

				return
			end

			if (self.跳跃攻击) then
				Q_屏幕怪物组[n]:被打飞(3,2,false,false)
				if(self.武器 == "钝器" or self.武器 == "") then
					Q_系统:显示AS特效(Q_打击_特效_管理器,"打击一_钝器",Q_屏幕怪物组[n].坐标.x,Q_屏幕怪物组[n].坐标.y - Q_屏幕怪物组[n]:取素材中心点Y(),1,"普通",self.方向,0.8)
				else
					Q_系统:显示AS特效(Q_打击_特效_管理器,"打击三_刀类new",Q_屏幕怪物组[n].坐标.x ,Q_屏幕怪物组[n].坐标.y - Q_屏幕怪物组[n]:取素材中心点Y(),1,"普通",self.方向,0.8)
				end

				return
			end

			if (Q_屏幕怪物组[n]:是否在跳跃状态() or Q_屏幕怪物组[n].状态 == "倒地") then
				Q_屏幕怪物组[n].跳跃被攻击 = true
				Q_屏幕怪物组[n].跳跃被攻击延迟 = 0
				return
			end
		end
	end
end

--=============================================================================--
-- ■ 是否在攻击状态
--=============================================================================--
function 主角_男鬼剑士:是否在攻击状态()

	if( self.状态 == "普攻一"    or self.状态 == "普攻二"  or  self.状态 == "普攻三" or  self.状态 == "普攻一尾" or self.状态 == "普攻二尾"  or  self.状态 == "普攻三尾" or self.状态 == "普攻四尾"
		or self.状态 == "前刺攻击" or self.跳跃攻击 or self.状态 == "上挑"or self.状态 == "鬼斩" or self.状态 == "银光落刃" or self.状态 == "银光落刃_落地" or self.状态 == "突刺"
		or self.状态 == "裂波斩_Q"or self.状态 == "裂波斩_下斩"or self.状态 == "裂波斩_尾"
		or self.状态 == "三段斩_1" or self.状态 == "三段斩_2" or self.状态 == "三段斩_3"
		or self.状态 == "十字斩_横" or self.状态 == "十字斩_挑" or self.状态 == "十字斩_冲1" or self.状态 == "十字斩_冲2"
		or self.状态 == "地裂波动剑"
		or self.状态 == "月光斩_1" or self.状态 == "月光斩_2"
		or self.状态 == "崩山击_准备" or self.状态 == "崩山击_上升"or self.状态 == "崩山击_落_准备" or self.状态 == "崩山击_落" or self.状态 == "崩山击_落地") then

		self.抖动 = 0
		self.抖动值 = 0

		return true
	end

	return false

end

--=============================================================================--
-- ■ 是否在攻击状态
--=============================================================================--
function 主角_男鬼剑士:是否在释放技能状态()

	if( self.状态 =="上挑" or self.状态 == "鬼斩" or self.状态 == "格挡" or self.状态 == "突刺"
		or self.状态 == "裂波斩_上斩" or self.状态 == "裂波斩_下斩"or self.状态 == "裂波斩_尾"
		or self.状态 == "银光落刃" or self.状态 == "银光落刃_落地"
		or self.状态 == "三段斩_1" or self.状态 == "三段斩_2" or self.状态 == "三段斩_3"
		or self.状态 == "十字斩_横" or self.状态 == "十字斩_挑" or self.状态 == "十字斩_冲1" or self.状态 == "十字斩_冲2"
		or self.状态 == "地裂波动剑"
		or self.状态 == "月光斩_1" or self.状态 == "月光斩_2"
		or self.状态 == "崩山击_准备" or self.状态 == "崩山击_上升" or self.状态 == "崩山击_落_准备" or self.状态 == "崩山击_落" or self.状态 == "崩山击_落地") then

		self.抖动 = 0
		self.抖动值 = 0

		return true
	end

	return false

end

--=============================================================================--
-- ■ 是否在跳跃状态
--=============================================================================--
function 主角_男鬼剑士:是否在跳跃状态()

	if( self.状态 == "跳跃_准备"    or self.状态 == "跳跃_上升"  or  self.状态 == "跳跃_下落"  or self.状态 == "跳跃_落地"  or self.状态 == "跳跃_上升_顶" or
		self.状态 == "被攻击_空中_起" or self.状态 == "被攻击_空中_落"  ) then

		self.抖动 = 0
		self.抖动值 = 0

		return true
	end

	return false

end

--=============================================================================--
-- ■ 是否在被攻击状态
--=============================================================================--
function 主角_男鬼剑士:是否在被攻击状态()

	if( self.状态 == "被击中A" or self.状态 == "被击中B" or self.状态 == "倒地") then
		return true
	end

	return false
end

--=============================================================================--
-- ■ 发动技能
--=============================================================================--
function 主角_男鬼剑士:发动技能(技能动作,按键值)

	if (Q_地图配置.类型 == "安全区" ) then
		return false
	end

	self.最后技能按键 = 按键值

	if (技能动作 == "后跳" and self.角色属性.HP > 0  and self:是否在跳跃状态() == false and self.状态 ~="倒地" and self.状态 ~="前刺攻击" ) then

		if (self:是否在攻击状态()) then
			self.固定白影 = self.方向
			self.保存的精灵:置纹理(self.身体.pak信息组[self.身体.当前帧].图片)
			self.保存的精灵:置区域(0,0,self.身体.pak信息组[self.身体.当前帧].图片:取宽度(),self.身体.pak信息组[self.身体.当前帧].图片:取高度())
			self.保存的精灵_颜色值 = 255
			self.保存的精灵:置中心 (self.身体.中心点.x, self.身体.中心点.y)
			self.保存精灵显示位置.x = self.身体.临时位置.x
			self.保存精灵显示位置.y = self.身体.临时位置.y
		end

		self.跳跃行为 = "后跳"
		self.弹跳力 = 3

		男鬼剑音效.跳跃起跳喊叫音效:播放()
		跳跃起跳音效:播放()
		self.地平线  = self.坐标.y
		self:改变动作("跳跃_上升")

		return true
	end

	if (技能动作 == "上挑" and self.角色属性.HP > 0  and self:是否在跳跃状态() == false and self.状态 ~="倒地" and self.状态 ~="前刺攻击" and self:是否在释放技能状态() == false) then

		if ( self:是否在攻击状态() ) then
			self.固定白影 = self.方向
			self.保存的精灵:置纹理(self.身体.pak信息组[self.身体.当前帧].图片)
			self.保存的精灵:置区域(0,0,self.身体.pak信息组[self.身体.当前帧].图片:取宽度(),self.身体.pak信息组[self.身体.当前帧].图片:取高度())
			self.保存的精灵_颜色值 = 255
			self.保存的精灵:置中心 (self.身体.中心点.x, self.身体.中心点.y)
			self.保存精灵显示位置.x = self.身体.临时位置.x
			self.保存精灵显示位置.y = self.身体.临时位置.y
		end
		self:改变动作("上挑")
		男鬼剑音效.鬼斩技能喊叫[2]:播放()
		男鬼剑音效.上挑技能音效:播放()
		self.霸体 = true
		self:霸体效果开关(self.霸体)

		return true
	end

	if (技能动作 == "银光落刃" and self.角色属性.HP > 0 and self:是否在跳跃状态() == true  and self.状态 ~="倒地" and self:是否在释放技能状态() == false and self.跳跃攻击 == false) then

		if(self.跳跃偏移>-60)then
			self.银落模式 = "无波"
		else
			self.银落模式 = "有波"
		end
		if(self.跳跃偏移 < -20)then
			男鬼剑音效.银落冲击下落音效:播放()
			self:改变动作("银光落刃",true)
		end
		self.可移动 =false
		self.跳跃攻击= false
		return true
	end

	if (技能动作 == "连突刺" and self.角色属性.HP > 0 and self:是否在跳跃状态() == false  and self.状态 ~="倒地" and self.状态 =="前刺攻击" and self.连突刺可用 == true and self:是否在释放技能状态() == false) then
		self.连突刺延时 = 0
		self.连突刺可用 = false
		self:改变动作("突刺")
		男鬼剑音效.连突刺技能音效:播放()

		return true
	elseif(技能动作 == "连突刺" and self.状态 ~="前刺攻击")then
		return false
	end

	if (技能动作 == "后跳斩" and self.角色属性.HP > 0 and self:是否在跳跃状态() == true and self.状态 ~= "倒地" and self.状态 ~= "前刺攻击" and self:是否在释放技能状态() == false and self.跳跃攻击 == false) then

		if (self.跳跃攻击次数 == 0) then
			self.跳跃攻击= true
			self.跳跃攻击次数  = 1

			self.开始跳跃攻击 = false
			if (self.状态 == "跳跃_上升" ) then
				self.跳跃攻击下落 = false
			end

			男鬼剑音效.跳跃攻击喊叫音效[引擎.取随机整数(1,2)]:播放()
			if(self.武器 == "钝器" or self.武器 == "")then
				男鬼剑音效.普攻钝器挥舞音效[引擎.取随机整数(1,2)]:播放()
			elseif(self.武器 == "短剑" )then
				男鬼剑音效.普攻短剑挥舞音效[引擎.取随机整数(1,3)]:播放()
			elseif(self.武器 == "太刀" )then
				男鬼剑音效.普攻太刀挥舞音效[引擎.取随机整数(1,3)]:播放()
			elseif(self.武器 == "巨剑" )then
			elseif(self.武器 == "光剑" )then
			end
		end

		return true
	end

	if (技能动作 == "空中连斩" and self.角色属性.HP > 0 and self:是否在跳跃状态() == true and self.状态 ~= "倒地" and self:是否在释放技能状态() == false and self.跳跃攻击 == false) then

		if (self.跳跃攻击次数 == 1) then
			self.跳跃攻击= true
			self.跳跃攻击次数  = 2

			self.开始跳跃攻击 = false
			if (self.状态 == "跳跃_上升" ) then
				self.跳跃攻击下落 = false
			end

			男鬼剑音效.跳跃攻击喊叫音效[引擎.取随机整数(1,2)]:播放()
			if(self.武器 == "钝器" or self.武器 == "")then
				男鬼剑音效.普攻钝器挥舞音效[引擎.取随机整数(1,2)]:播放()
			elseif(self.武器 == "短剑" )then
				男鬼剑音效.普攻短剑挥舞音效[引擎.取随机整数(1,3)]:播放()
			elseif(self.武器 == "太刀" )then
				男鬼剑音效.普攻太刀挥舞音效[引擎.取随机整数(1,3)]:播放()
			elseif(self.武器 == "巨剑" )then
			elseif(self.武器 == "光剑" )then
			end
		end

		return true
	end

	if (技能动作 == "裂波斩" and self.角色属性.HP > 0 and self:是否在跳跃状态() == false and self.状态 ~= "倒地" and self.状态 ~= "前刺攻击" and self:是否在释放技能状态() == false) then

		if ( self:是否在攻击状态() ) then
			self.固定白影 = self.方向
			self.保存的精灵:置纹理(self.身体.pak信息组[self.身体.当前帧].图片)
			self.保存的精灵:置区域(0,0,self.身体.pak信息组[self.身体.当前帧].图片:取宽度(),self.身体.pak信息组[self.身体.当前帧].图片:取高度())
			self.保存的精灵_颜色值 = 255
			self.保存的精灵:置中心 (self.身体.中心点.x, self.身体.中心点.y)
			self.保存精灵显示位置.x = self.身体.临时位置.x
			self.保存精灵显示位置.y = self.身体.临时位置.y
		end
		self:改变动作("裂波斩_Q",true)
		男鬼剑音效.裂波斩上斩音效:播放()
		return true
	end

	if(技能动作 == "崩山击" and self.角色属性.HP > 0 and self:是否在跳跃状态() == false and self.状态 ~= "倒地" and self.状态 ~= "前刺攻击" and self:是否在释放技能状态() == false)then

		self.霸体 = true
		self:霸体效果开关(self.霸体)
		self:改变动作("崩山击_准备",true)
		return true
	end

	if (技能动作 == "三段斩" and self.角色属性.HP > 0 and self:是否在跳跃状态() == false and self.状态 ~= "倒地" and self.状态 ~= "前刺攻击" and self:是否在释放技能状态() == false) then
		if ( self:是否在攻击状态() ) then
			self.保存的精灵:置纹理(self.身体.pak信息组[self.身体.当前帧].图片)
			self.保存的精灵:置区域(0,0,self.身体.pak信息组[self.身体.当前帧].图片:取宽度(),self.身体.pak信息组[self.身体.当前帧].图片:取高度())
			self.保存的精灵_颜色值 = 255
			self.保存的精灵:置中心 (self.身体.中心点.x, self.身体.中心点.y)
			self.保存精灵显示位置.x = self.身体.临时位置.x
			self.保存精灵显示位置.y = self.身体.临时位置.y
		end

		self:改变动作( "三段斩_1")
		男鬼剑音效.三段斩喊叫音效[1]:播放()
		男鬼剑音效.三段斩一斩音效:播放()

		return true
	end

	if (技能动作 == "十字斩" and self.角色属性.HP > 0 and self:是否在跳跃状态() == false and self.状态 ~= "倒地" and self.状态 ~= "前刺攻击" and self:是否在释放技能状态() == false) then
		self:改变动作("十字斩_横")
		男鬼剑音效.十字斩喊叫音效:播放()
		男鬼剑音效.十字斩挑音效:播放()

		return true
	end

	if (self.角色属性.HP > 0 and  self:是否在释放技能状态() == false and self:是否在跳跃状态() == false   and self.状态 ~="倒地" and self.状态 ~= "格挡" ) then

		if ( 技能动作 == "鬼斩" ) then

			self:改变动作("鬼斩")
			男鬼剑音效.鬼斩技能喊叫[1]:播放()

		elseif ( 技能动作 == "格挡" ) then

			self:改变动作("格挡")
			男鬼剑音效.格挡起手音效:播放()

		elseif (技能动作 == "崩山击") then
			self:改变动作("小蹦_1")
			self.霸体 = true
			self:霸体效果开关(self.霸体)

		elseif (技能动作 == "裂波斩")then

			self:改变动作("裂波斩_Q")
			男鬼剑音效.裂波斩上斩音效:播放()

		elseif (技能动作 == "三段斩") then

			self:改变动作("三段斩_1")
			男鬼剑音效.三段斩喊叫音效[1]:播放()
			男鬼剑音效.三段斩一斩音效:播放()

		elseif(技能动作 == "十字斩")then

			self:改变动作("十字斩一")
			男鬼剑音效.十字斩挑音效:播放()

		elseif ( 技能动作 == "地裂波动剑" ) then
			self:改变动作("地裂波动剑")
			男鬼剑音效.波动剑释放音效:播放()
			--Q_技能进度条:发动(0.2,"地裂波动剑")

		elseif (技能动作 == "月光斩") then
			self:改变动作("月光斩_1")
			男鬼剑音效.月光斩下释放音效:播放()
			男鬼剑音效.月光斩起释放音效:播放()



		end

		return true
	end

	return false
end

--=============================================================================--
-- ■ 普攻逻辑
--=============================================================================--
function 主角_男鬼剑士:普攻逻辑()

	if ( self.状态 == "普攻一"  or self.状态 == "普攻二"  or  self.状态 == "普攻三"  or
		self.状态 == "普攻一尾" or self.状态 == "普攻二尾"  or  self.状态 == "普攻三尾" ) then
		if (引擎.按键按住(键_键盘下) and 引擎.按键按下(键_C)) then
			寻找发动技能("后跳")
		end
	end

	if ( 引擎.按键按下(键_X) ) then

		if (self.拥有捡取物品 ~= nil and self:是否在攻击状态() == false  and self:是否在跳跃状态() == false  and
			self:是否在被攻击状态() == false and self.状态 ~= "格挡" and 引擎.按键按住(键_X) == true) then  --物品拾取部分

			self:改变动作("拾取")
			self.可移动 = false

			return
		end
		if ( self.状态== "鬼斩" or  self.状态== "上挑" or self.状态 == "裂波斩_尾") then
			return
		end

		if ( self.状态 == "跑动" ) then
			self:改变动作("前刺攻击")
		else
			if ( self.状态 ~= "普攻一"  and self.状态 ~= "普攻二"  and  self.状态 ~= "普攻三"  and
				self.状态 ~= "普攻一尾" and self.状态 ~= "普攻二尾"  and  self.状态 ~= "普攻三尾" and self.状态 ~= "前刺攻击" and self.状态 ~= "突刺") then

				self:改变动作("普攻一")
				self.普攻二激活 = false
				self.普攻三激活 = false

				self.普攻一延时 = 0
				self.普攻二延时 = 0
				self.普攻三延时 = 0

			elseif ( self.状态 == "普攻一"  ) then

				self.普攻二激活 = true

				if (self.上一帧动画 <= 9 and  self.身体:取间隔帧() >= 4) then
					self:改变动作("普攻二")
				end

			elseif ( self.状态 == "普攻二"  ) then

				self.普攻三激活 = true

				if (self.上一帧动画 <= 10 and  self.身体:取间隔帧() >= 5) then
					self:改变动作("普攻三")
				end

			elseif ( self.状态 == "拾取") then

			end
		end

	end

	if ( self.状态 == "普攻一") then

		if (self.上一帧动画 == 9 and  self.身体:取间隔帧() == 0) then

			if ( self.普攻二激活 ) then
				self:改变动作("普攻二")

			else

				self:改变动作("普攻一尾")

			end

		end

	end

	if ( self.状态 == "普攻二") then

		if ( 引擎.按键按住(键_键盘右) or 引擎.按键按住(键_键盘左)) then
			self:X方向位移(self.角色属性.移动速度  * self.方向 * 0.5)
		end

		if (self.上一帧动画 == 2 ) then
			self:X方向位移(self.角色属性.移动速度  * self.方向 * 1.5)

		elseif (self.上一帧动画 == 10 and  self.身体:取间隔帧() == 0) then

			if ( self.普攻三激活 ) then
				self:改变动作("普攻三")
			else
				self:改变动作("普攻二尾")
			end

		end

	end

	if ( self.状态 == "普攻三") then

		if ( 引擎.按键按住(键_键盘右) or 引擎.按键按住(键_键盘左)) then
			self:X方向位移(self.角色属性.移动速度  * self.方向 * 0.5)
		end

		if (self.上一帧动画 <= 2 ) then

			self:X方向位移(self.角色属性.移动速度  * self.方向 * 1.5)

		elseif (self.上一帧动画 == 8 and  self.身体:取间隔帧() == 0) then

			self:改变动作("普攻三尾")

		end

	end

	if ( self.状态 == "普攻一尾") then
		self.普攻一延时= self.普攻一延时 + dt
		if (self.普攻一延时 >=  0.1) then
			self.普攻一延时 = 0
			self:改变动作("静止")
		end

		if (引擎.按键按下(键_X) ) then
			self:改变动作("普攻二")
		end

	end

	if ( self.状态 == "普攻二尾") then
		self.普攻二延时= self.普攻二延时 + dt
		if (self.普攻二延时 >=  0.1) then
			self.普攻二延时 = 0
			self:改变动作("静止")
		end

		if (引擎.按键按下(键_X) ) then
			self:改变动作("普攻三")
		end

	end

	if ( self.状态 == "普攻三尾") then
		self.普攻三延时= self.普攻三延时 + dt
		if (self.普攻三延时 >=  0.2) then
			self.普攻三延时 = 0
			self:改变动作("静止")
		end

	end

	if ( self.状态 == "前刺攻击") then

		if (self.上一帧动画 >= 1 and self.上一帧动画 <= 4) then

			self:X方向位移(self.角色属性.移动速度  * self.方向 )

			self.连突刺延时= self.连突刺延时 + dt
			if (self.连突刺延时 >=  0.3) then
				self.连突刺延时 = 0
				self.连突刺可用 = true

			end

		elseif (self.上一帧动画 ==9 and  self.身体:取间隔帧() == 0) then

			self:改变动作("静止")
			self.连突刺可用 = false

		end

	end

	if ( self.状态 == "拾取" ) then

		if (self.上一帧动画 == 1 and self.身体:取间隔帧() == 1 and self.拥有捡取物品 ~= nil) then
			self:改变动作("静止")
			if(self.拥有捡取物品 ~= nil) then
				--[[if(self.拥有捡取物品.物品.总类 == "装备" and Q_包裹窗口:取物品数(1) <  32) then
					Q_包裹窗口:增加物品new(1,self.拥有捡取物品.物品,self.拥有捡取物品.数量,true,self.拥有捡取物品.物品.物品id)
					self.拥有捡取物品.已经消失 = true
					Q_全局音效.拾取道具音效:播放()
				elseif(self.拥有捡取物品.物品.总类 == "消耗品" and Q_包裹窗口:取物品数(2) <  32) then
					Q_包裹窗口:增加物品new(2,self.拥有捡取物品.物品,self.拥有捡取物品.数量,true,self.拥有捡取物品.物品.物品id)
					self.拥有捡取物品.已经消失 = true
					Q_全局音效.拾取道具音效:播放()
				elseif(self.拥有捡取物品.物品.总类 == "装扮" and Q_包裹窗口:取装扮物品数() <  28) then
					Q_包裹窗口:增加装扮物品new(self.拥有捡取物品.物品,self.拥有捡取物品.物品.物品id)
					self.拥有捡取物品.已经消失 = true
					Q_全局音效.拾取道具音效:播放()
				elseif(self.拥有捡取物品.物品.总类 == "金币") then
					Q_系统:增加金币(self.拥有捡取物品.数量)
					self.拥有捡取物品.已经消失 = true
				end--]]
			end
		end

	end

end

--=============================================================================--
-- ■ 动作更新
--=============================================================================--
function 主角_男鬼剑士:动作更新()

	if (self.状态 ==  "静止") then

		self:pak动画更新(self.动画帧率.静止,177,180)--177,180
		self.可移动 = true
		self.跳跃偏移 = 0

	elseif  (self.状态 ==  "待机") then

		self:pak动画更新(self.动画帧率.待机,91,96)
		self.可移动 = true
		self.跳跃偏移 = 0

	elseif ( self.状态 == "行走" ) then

		self:pak动画更新(self.动画帧率.行走,181,188)

		if (self.脚步声 and 草地行走音效:是否播放() == false and Q_地图配置.地面 == "草地") then
			草地行走音效:播放()
		elseif(self.脚步声 and 雪地行走音效[1]:是否播放() == false and 雪地行走音效[2]:是否播放() == false and 雪地行走音效[3]:是否播放() == false and Q_地图配置.地面 == "雪地")then
			雪地行走音效[引擎.取随机整数(1,3)]:播放()
		end

	elseif ( self.状态 == "跑动" ) then

		self:pak动画更新(self.动画帧率.跑动,106,113)

		if (self.脚步声 and (self.上一帧动画 == 3 or self.上一帧动画 == 7 )and  草地跑动音效:是否播放() == false and Q_地图配置.地面 == "草地") then
			草地跑动音效:播放()
		elseif(self.脚步声 and (self.上一帧动画 == 3 or self.上一帧动画 == 7 )and 雪地跑动音效[1]:是否播放() == false and 雪地跑动音效[2]:是否播放() == false and 雪地跑动音效[3]:是否播放() == falxse and Q_地图配置.地面 == "雪地")then
			雪地跑动音效[引擎.取随机整数(1,3)]:播放()
		end

	elseif ( self.状态 == "普攻一" ) then
		self:pak动画更新(self.动画帧率.普攻一,1,10)

	elseif ( self.状态 == "普攻一尾" ) then
		self:pak动画更新(self.动画帧率.普攻一,10,10)

	elseif ( self.状态 == "普攻二" ) then
		self:pak动画更新(self.动画帧率.普攻二,11,21)

	elseif ( self.状态 == "普攻二尾" ) then
		self:pak动画更新(self.动画帧率.普攻二,21,21)

	elseif ( self.状态 == "普攻三" ) then
		self:pak动画更新(self.动画帧率.普攻三,34,42)

	elseif ( self.状态 == "普攻三尾" ) then
		self:pak动画更新(self.动画帧率.普攻三,42,42)

	elseif (self.状态 ==  "前刺攻击") then
		self:pak动画更新(self.动画帧率.前刺,114,123)
	elseif (self.状态 ==  "突刺") then
		self:pak动画更新(self.动画帧率.前刺,114,123)

	elseif (self.状态 ==  "跳跃_准备") then
		self:pak动画更新(self.动画帧率.跳跃,126,126)

	elseif (self.状态 ==  "跳跃_上升") then

		if (self.跳跃行为 == "后跳") then

			if(self.跳跃攻击 ) then
				if (self.开始跳跃攻击 == false ) then
					self.开始跳跃攻击 = true
					self:PAK动画重置()
				end
				self:pak动画更新(self.动画帧率.跃击,134,139)
			else
				self:pak动画更新(self.动画帧率.跳跃,132,132)
			end

		else

			if(self.跳跃攻击 ) then
				if (self.开始跳跃攻击 == false ) then
					self.开始跳跃攻击 = true
					self:PAK动画重置()
				end
				self:pak动画更新(self.动画帧率.跃击,134,139)
			else
				self:pak动画更新(self.动画帧率.跳跃上升,127,127)
			end

		end

	elseif (self.状态 ==  "跳跃_上升_顶") then

		if (self.跳跃行为 == "后跳") then

			if(self.跳跃攻击 ) then
				if (self.开始跳跃攻击 == false ) then
					self.开始跳跃攻击 = true
					self:PAK动画重置()
				end
				self:pak动画更新(self.动画帧率.跃击,134,139)
			else
				self:pak动画更新(self.动画帧率.跳跃,132,132)
			end


		else

			if(self.跳跃攻击 ) then
				if (self.开始跳跃攻击 == false ) then
					self.开始跳跃攻击 = true
					self:PAK动画重置()
				end
				self:pak动画更新(self.动画帧率.跃击,134,139)
			else
				self:pak动画更新(self.动画帧率.跳跃上升,128,128)
			end

		end

	elseif (self.状态 ==  "跳跃_下落") then

		if (self.跳跃行为 == "后跳") then

			if(self.跳跃攻击 ) then
				if (self.开始跳跃攻击 == false ) then
					self.开始跳跃攻击 = true
					self:PAK动画重置()
				end
				self:pak动画更新(self.动画帧率.跃击,134,139)
			else
				self:pak动画更新(self.动画帧率.跳跃,132,132)
			end

		else

			if(self.跳跃攻击 ) then
				if (self.开始跳跃攻击 == false ) then
					self.开始跳跃攻击 = true
					self:PAK动画重置()
				end
				self:pak动画更新(self.动画帧率.跃击,134,139)
			else
				self:pak动画更新(self.动画帧率.跳跃,131,131)
			end
		end

	elseif (self.状态 ==  "跳跃_落地") then

		self:pak动画更新(self.动画帧率.跳跃,133,133)

	elseif (self.状态 ==  "被击中A") then
		self:pak动画更新(self.动画帧率.被击,99,99)

	elseif (self.状态 ==  "被击中B") then
		self:pak动画更新(self.动画帧率.被击,100,100)

	elseif (self.状态 ==  "倒地") then
		self:pak动画更新(self.动画帧率.死亡,104,104)

	elseif (self.状态 ==  "被攻击_空中_起") then
		self:pak动画更新(self.动画帧率.死亡,101,101)

	elseif (self.状态 ==  "被攻击_空中_落") then
		self:pak动画更新(self.动画帧率.死亡,102,102)

	elseif (self.状态 ==  "死亡") then
		self:pak动画更新(self.动画帧率.死亡,100,104)

	elseif (self.状态 ==  "拾取") then
		self:pak动画更新(self.动画帧率.拾取,158,159)


--技能动作部分
	elseif (self.状态 ==  "上挑") then
		self:pak动画更新(self.动画帧率.上挑,34,42)

	elseif (self.状态 ==  "鬼斩") then
		self:pak动画更新(self.动画帧率.鬼斩,140,150)

	elseif (self.状态 ==  "格挡") then
		self:pak动画更新(self.动画帧率.格挡,124,124)

	elseif (self.状态 ==  "银光落刃") then
		self:pak动画更新(self.动画帧率.银光落刃,139,139)
	elseif (self.状态 ==  "银光落刃_落地") then
		self:pak动画更新(self.动画帧率.银光落刃,158,159)

	elseif (self.状态 == "崩山击_准备") then
		self:pak动画更新( 4, 126, 126)
	elseif (self.状态 == "崩山击_上升") then
		self:pak动画更新(4, 127, 127)
	elseif (self.状态 == "崩山击_落_准备") then
		self:pak动画更新(4, 206, 206)
	elseif (self.状态 == "崩山击_落") then
		self:pak动画更新(12, 206, 210)
	elseif (self.状态 == "崩山击_落地") then
		self:pak动画更新(10, 210, 210)

	elseif (self.状态 == "裂波斩_Q") then
		self:pak动画更新(self.动画帧率.裂波斩_Q, 200, 204)
	elseif (self.状态 == "裂波斩_下斩") then
		self:pak动画更新(self.动画帧率.裂波斩_下斩, 205, 210)
	elseif (self.状态 == "裂波斩_尾")then
		self:pak动画更新(self.动画帧率.裂波斩_尾, 210, 210)

	elseif (self.状态 == "三段斩_1") then
		self:pak动画更新( 2, 11, 21)
	elseif (self.状态 == "三段斩_2") then
		self:pak动画更新( 6, 189, 194)
	elseif (self.状态 == "三段斩_3") then
		self:pak动画更新( 6, 195, 199)

	elseif (self.状态 == "十字斩_横") then
		self:pak动画更新(3, 11, 21)
	elseif (self.状态 == "十字斩_挑") then
		self:pak动画更新(self.动画帧率.十字斩, 200, 202)
	elseif (self.状态 == "十字斩_冲1") then
		self:pak动画更新(self.动画帧率.十字斩, 202, 203)
	elseif (self.状态 == "十字斩_冲2") then
		self:pak动画更新(self.动画帧率.十字斩, 203, 204)

	elseif (self.状态 ==  "地裂波动剑") then
		self:pak动画更新(self.动画帧率.地裂波动剑,43,51)

	elseif (self.状态 == "月光斩_1") then
		self:pak动画更新( 12, 195, 199)
	elseif (self.状态 == "月光斩_2") then
		self:pak动画更新( 12, 200, 204)

	end


end

--=============================================================================--
-- ■ 随机喊叫
--=============================================================================--
function 主角_男鬼剑士:随机喊叫(挥舞声音)

	男鬼剑音效.普攻喊叫音效[引擎.取随机整数(1,3)]:播放()


	if( 挥舞声音 == nil) then
		if(self.武器 == "钝器" or self.武器 == "")then
			男鬼剑音效.普攻钝器挥舞音效[引擎.取随机整数(1,2)]:播放()
		elseif(self.武器 == "短剑" )then
			男鬼剑音效.普攻短剑挥舞音效[引擎.取随机整数(1,3)]:播放()
		elseif(self.武器 == "太刀" )then
			男鬼剑音效.普攻太刀挥舞音效[引擎.取随机整数(1,3)]:播放()
		elseif(self.武器 == "巨剑" )then
		elseif(self.武器 == "光剑" )then
		end
	end

end
--=============================================================================--
-- ■ 跳跃中位置移动
--=============================================================================--
function 主角_男鬼剑士:跳跃中位置移动()

	if (self.跳跃行为 == "后跳") then

		if ( self.方向 == 1) then
			self.坐标.x = self.坐标.x - self.角色属性.移动速度 * 1.5
		else
			self.坐标.x = self.坐标.x + self.角色属性.移动速度 * 1.5
		end

	else

		if ( 引擎.按键按住(键_键盘右)  ) then
			if (self.跳跃攻击  == false and self.跳跃攻击次数 == 0)then
				self.方向 = 1
			end
			self.坐标.x = self.坐标.x + self.角色属性.移动速度 * 1.8
		end

		if ( 引擎.按键按住(键_键盘左) ) then
			if (self.跳跃攻击  == false and self.跳跃攻击次数 == 0)then
				self.方向 = -1
			end

			self.坐标.x = self.坐标.x - self.角色属性.移动速度 * 1.8

		end

		if ( 引擎.按键按住(键_键盘上) ) then

			local 下次y = self.地平线 -  self.角色属性.移动速度 * 0.5

			local  不可移动 = false

			if (不可移动== false ) then
				self.坐标.y = self.坐标.y -  self.角色属性.移动速度 * 0.5
				self.地平线 = self.地平线 -  self.角色属性.移动速度 * 0.5
			end

		end

		if ( 引擎.按键按住(键_键盘下) ) then

			local 下次y = self.地平线 +  self.角色属性.移动速度 * 0.5

			local  不可移动 = false

			if (不可移动== false ) then
				self.坐标.y = self.坐标.y + self.角色属性.移动速度 * 0.5
				self.地平线 = self.地平线 +  self.角色属性.移动速度 * 0.5
			end
		end

	end

end
--=============================================================================--
-- ■ 跳跃逻辑
--=============================================================================--
function 主角_男鬼剑士:跳跃逻辑()

	if (引擎.按键按下(键_C)  and  self:是否在跳跃状态() == false and self:是否在攻击状态()== false ) then

		self.地平线  = self.坐标.y

		if ( 引擎.按键按住( 键_键盘下)) then
			寻找发动技能("后跳")

		else
			男鬼剑音效.跳跃起跳喊叫音效:播放()
			跳跃起跳音效:播放()
			self.跳跃行为 = "普跳"

			self:改变动作("跳跃_准备")

		end
	end

	if ( self.状态 == "跳跃_准备"  ) then
		self.跳跃准备时间 = self.跳跃准备时间 + dt

		if ( self.跳跃准备时间 > 0.15) then
			self:改变动作("跳跃_上升")
			self.跳跃准备时间 = 0

			if (self.跳跃行为 == "后跳") then
				self.弹跳力 = 3
			else
				self.弹跳力 = 5.5
			end

		end
	end

	if ((self.状态 == "跳跃_上升" or self.状态 == "跳跃_下落"  or self.状态 == "跳跃_上升_顶" )and 引擎.按键按下(键_X) and self.跳跃行为 == "普跳" and self.跳跃攻击==false ) then

		if (self.跳跃攻击次数 == 0) then
			self.跳跃攻击= true
			self.跳跃攻击次数  = 1

			self.开始跳跃攻击 = false
			if (self.状态 == "跳跃_上升" ) then
				self.跳跃攻击下落 = false
			end

			男鬼剑音效.跳跃攻击喊叫音效[引擎.取随机整数(1,2)]:播放()
			if(self.武器 == "钝器" or self.武器 == "")then
				男鬼剑音效.普攻钝器挥舞音效[引擎.取随机整数(1,2)]:播放()
			elseif(self.武器 == "短剑" )then
				男鬼剑音效.普攻短剑挥舞音效[引擎.取随机整数(1,3)]:播放()
			elseif(self.武器 == "太刀" )then
				男鬼剑音效.普攻太刀挥舞音效[引擎.取随机整数(1,3)]:播放()
			elseif(self.武器 == "巨剑" )then
			elseif(self.武器 == "光剑" )then
			end
		end
	end

	if ( self.跳跃攻击 ) then

		if (self.上一帧动画 == 5 ) then

			self.跳跃攻击= false
			self.开始跳跃攻击 = false
			self:PAK动画重置()

		end

	end

	if ( self.状态 == "跳跃_上升"  or self.状态 == "跳跃_上升_顶"   or self.跳跃攻击下落 == false) then

		if (self.跳跃行为 == "后跳") then
			self.弹跳力 = self.弹跳力 - dt *14
		else
			self.弹跳力 = self.弹跳力 - dt * 15
		end

		if (self.弹跳力 > 0) then

			self.跳跃偏移 = self.跳跃偏移 - self.弹跳力*2
			if (self.弹跳力 < 3 )then
				self:改变动作("跳跃_上升_顶")
			end
		else

			self:改变动作("跳跃_下落")
			self.跳跃攻击下落 = true
		end
		self:跳跃中位置移动()
	end

	if ( self.状态 == "跳跃_下落") then

		if (self.跳跃行为 == "后跳") then
			self.弹跳力 = self.弹跳力 + dt * 15
		else
			self.弹跳力 = self.弹跳力 + dt * 12
		end

		self.跳跃偏移 = self.跳跃偏移 + self.角色属性.移动速度 * 0.5

		if ( self.跳跃偏移  < 0 ) then

			self.跳跃偏移 = self.跳跃偏移+ self.弹跳力 * 1.7

		else
			self.跳跃偏移 = 0
			self:改变动作("跳跃_落地")

			跳跃落地音效:播放()


		end
		self:跳跃中位置移动()
	end

	if ( self.状态 == "跳跃_落地" ) then

		if (self.跳跃行为 == "后跳") then

			self:改变动作("静止")
			self.跳跃攻击= false
			self.跳跃准备时间 = 0
			self.跳跃攻击次数 = 0
			self.弹跳力 = 0

		else

			self.跳跃准备时间 = self.跳跃准备时间 + dt

			if (self.跳跃准备时间 > 0.15) then

				self:改变动作("静止")
				self.跳跃攻击= false
				self.跳跃准备时间 = 0
				self.跳跃攻击次数 = 0
				self.弹跳力 = 0
				self.银光落刃= false
			end

		end

	end

end
--=============================================================================--
-- ■ 移动逻辑
--=============================================================================--
function 主角_男鬼剑士:移动逻辑()

	if(not self.可移动 ) then
		return
	end

	if (引擎.按键按下(键_键盘上)) then
		self.最后按键 = "键盘上"
	end

	if (引擎.按键按下(键_键盘下)) then
		self.最后按键 = "键盘下"
	end

	if (引擎.按键按下(键_键盘左)) then
		self.最后按键 = "键盘左"
	end

	if (引擎.按键按下(键_键盘右)) then
		self.最后按键 = "键盘右"
	end

	if (引擎.按键按住(键_键盘上)) then

		if (引擎.按键按住(键_键盘下) and self.最后按键 == "键盘下") then
			self:移动开始("下")
		else
			self:移动开始("上")
		end

		if (引擎.按键按住(键_键盘左) ) then
			self:移动开始("左")
		elseif (引擎.按键按住(键_键盘右)) then
			self:移动开始("右")
		end

	elseif (引擎.按键按住(键_键盘下) ) then

		if (引擎.按键按住(键_键盘上) and self.最后按键 == "键盘上") then
			self:移动开始("上")
		else
			self:移动开始("下")
		end

		if (引擎.按键按住(键_键盘左) ) then
			self:移动开始("左")
		elseif (引擎.按键按住(键_键盘右)) then
			self:移动开始("右")
		end

	elseif (引擎.按键按住(键_键盘左)) then

		if (引擎.按键按住(键_键盘右) and self.最后按键 == "键盘右") then
			self:移动开始("右")
		else
			self:移动开始("左")
		end

		if (引擎.按键按住(键_键盘上) ) then
			self:移动开始("上")
		elseif (引擎.按键按住(键_键盘下) ) then
			self:移动开始("下")
		end

	elseif (引擎.按键按住(键_键盘右) ) then

		if (引擎.按键按住(键_键盘左) and self.最后按键 == "键盘左") then
			self:移动开始("左")
		else
			self:移动开始("右")
		end

		if (引擎.按键按住(键_键盘上) ) then
			self:移动开始("上")
		elseif (引擎.按键按住(键_键盘下) ) then
			self:移动开始("下")
		end
	end

	--判定是否在未按键的状态下
	if (引擎.按键按住(键_键盘上)  == false and 引擎.按键按住(键_键盘下)  == false and 引擎.按键按住(键_键盘左) == false and 引擎.按键按住(键_键盘右) == false  and self.状态~="银光落刃_落地") then
		self.最后按键=""
		if(Q_地图配置.类型 ~= "地下城" )then
			self:改变动作("静止",true)
		elseif(Q_地图配置.类型 == "地下城"  and Q_地图.怪物剩余数量 ~= 0)then
			self:改变动作("待机",true)
		else
			self:改变动作("静止",true)
		end
	end

	if (引擎.按键弹起(键_键盘左) and self.状态~="银光落刃_落地") then

		if(引擎.按键按住(键_键盘右)) then
			最后按下 = "右键"
		else
			左键弹起时间 = 引擎.取时间戳()
			--self:改变动作("静止")
			最后按下=""
		end

	end

	if (引擎.按键弹起(键_键盘右)  and self.状态~="银光落刃_落地") then

		if(引擎.按键按住(键_键盘左)) then
			最后按下 = "左键"
		else
			右键弹起时间 = 引擎.取时间戳()
			--self:改变动作("静止")
			最后按下=""
		end

	end

end
--=============================================================================--
-- ■ 移动开始
--=============================================================================--
function 主角_男鬼剑士:移动开始(方向)

	local 下次y = self.坐标.y
	local 下次x = self.坐标.x

	if (方向 == "上") then

		if (self.状态 == "跑动") then
			if(self.角色属性.移动速度<2) then
				下次y = self.坐标.y - (self.角色属性.移动速度+4)
			elseif(self.角色属性.移动速度==2) then
				下次y = self.坐标.y - (self.角色属性.移动速度+1.3)
			else
				下次y = self.坐标.y - (self.角色属性.移动速度)
			end
		elseif( self.状态 == "行走") then
			if(self.角色属性.移动速度<2) then
				下次y = self.坐标.y - (self.角色属性.移动速度+3)
			elseif(self.角色属性.移动速度==2) then
				下次y = self.坐标.y - (self.角色属性.移动速度+1.0)
			else
				下次y = self.坐标.y - self.角色属性.移动速度+ 0.3
			end
		else
			self:改变动作("行走")
		end
		self.坐标.y = 下次y

	elseif (方向 == "下") then

		if (self.状态 == "跑动") then
			if(self.角色属性.移动速度<2) then
				下次y = self.坐标.y + (self.角色属性.移动速度-4)
			elseif(self.角色属性.移动速度==2) then
				下次y = self.坐标.y + (self.角色属性.移动速度-1.3)
			else
				下次y = self.坐标.y + (self.角色属性.移动速度)
			end
		elseif (self.状态 == "行走") then
			if(self.角色属性.移动速度<2) then
				下次y = self.坐标.y + (self.角色属性.移动速度-3)
			elseif(self.角色属性.移动速度==2) then
				下次y = self.坐标.y + (self.角色属性.移动速度-1.0)
			else
				下次y = self.坐标.y + self.角色属性.移动速度-0.3
			end
		else
			self:改变动作("行走")
		end
		self.坐标.y = 下次y

	elseif (方向 == "左") then

		self.方向 = -1

		if (引擎.取时间戳() - 左键弹起时间 < 100 ) then
			左键弹起时间 = 引擎.取时间戳()
			self:改变动作("跑动",true)
			if(self.角色属性.移动速度<2) then
				下次x = self.坐标.x - (self.角色属性.移动速度+4) * 1.5
			elseif(self.角色属性.移动速度==2) then
				下次x = self.坐标.x - (self.角色属性.移动速度+1.5) * 1.3
			else
				下次x = self.坐标.x - (self.角色属性.移动速度) * 1.5
			end
		else
			self:改变动作("行走",true)
			if(self.角色属性.移动速度<2) then
				下次x = self.坐标.x - (self.角色属性.移动速度+4)
			elseif(self.角色属性.移动速度==2) then
				下次x = self.坐标.x - (self.角色属性.移动速度+1.3) * 1.3
			else
				下次x = self.坐标.x - self.角色属性.移动速度+0.3
			end
		end
		self.坐标.x = 下次x

	elseif (方向 == "右") then

		self.方向 = 1

		if (引擎.取时间戳() - 右键弹起时间 < 100) then
			右键弹起时间 = 引擎.取时间戳()
			self:改变动作("跑动",true)
			if(self.角色属性.移动速度<2) then
				下次x = self.坐标.x + (self.角色属性.移动速度+4) * 1.5
			elseif(self.角色属性.移动速度==2) then
				下次x = self.坐标.x + (self.角色属性.移动速度+1.5) * 1.3
			else
				下次x = self.坐标.x + (self.角色属性.移动速度) * 1.5
			end
		else
			self:改变动作( "行走",true)
			if(self.角色属性.移动速度<2) then
				下次x = self.坐标.x + (self.角色属性.移动速度+4)
			elseif(self.角色属性.移动速度==2) then
				下次x = self.坐标.x + (self.角色属性.移动速度+1.3) * 1.3
			else
				下次x = self.坐标.x + self.角色属性.移动速度+0.3
			end
		end
		self.坐标.x = 下次x
	end
	self.移动中 = true

end
--=============================================================================--
-- ■ 被击退
--=============================================================================--
function 主角_男鬼剑士:被击退(力量,速度,力量方向)

	self.击退力量 = 力量* 0.8
	self.击退速度 = 速度
	self.击退方向 = 力量方向

end
--=============================================================================--
-- ■ 被攻击打飞逻辑
--=============================================================================--
function 主角_男鬼剑士:被攻击打飞逻辑()

	if (self.状态 == "被攻击_空中_起") then

		self.被击弹跳力 = self.被击弹跳力 - dt * 20

		if (self.被击弹跳力 > 0) then

			self.跳跃偏移 = self.跳跃偏移 - self.被击弹跳力

			self:X方向位移(-self.方向 * self.被击T力)
		else

			self:改变动作("被攻击_空中_落")

		end

	end

	if (self.状态 == "被攻击_空中_落") then

		self.被击弹跳力 = self.被击弹跳力 + dt * 50

		if (self.跳跃偏移 < 0 )then
			self.跳跃偏移 = self.跳跃偏移 + self.被击弹跳力
			self:X方向位移(-self.方向 * self.被击T力+ 0.5 )

		else

			if (self.反弹 == false) then

				self:被打飞(4,2,10)

				self.反弹 = true

				--角色摔落音效:播放()
				--for n=1,引擎.取随机整数(1,3) do
				--	粒子特效(self.坐标.x+引擎.取随机整数(-20,20),self.坐标.y,"落地灰层" .. 引擎.取随机整数(1,3))
				--end

			else

				self:改变动作("倒地")
				self.落地时间计次 = 0
				--for n=1,引擎.取随机整数(1,3) do
					--粒子特效(self.坐标.x+引擎.取随机整数(-20,20),self.坐标.y,"落地灰层" .. 引擎.取随机整数(1,3))
				--end

			end
		end
	end

end
--=============================================================================--
-- ■ 被打飞
--=============================================================================--
function 主角_男鬼剑士:被打飞(力量,T力,地平线偏移)

	if (self.状态 ~="被攻击_空中_起") then
		self:改变动作("被攻击_空中_起")
		self.被击弹跳力 = 力量
		self.被击T力 = T力
		self.反弹 = false
		--self.坐标.y  = self.坐标.y  - 地平线偏移
	end

end

--=============================================================================--
-- ■ X方向位移
--=============================================================================--
function 主角_男鬼剑士:裂波斩偏移()

	if(self.目标怪物 ~= nil)then

		if(self.方向 == 1)then

			if(Q_屏幕怪物组[self.目标怪物].坐标.x > self.坐标.x + 120)then
				--Q_屏幕怪物组[self.目标怪物]:被击退(-10,1)
				Q_屏幕怪物组[self.目标怪物]:X方向位移(-10)
			elseif( Q_屏幕怪物组[self.目标怪物].坐标.x < self.坐标.x + 110 ) then
				Q_屏幕怪物组[self.目标怪物]:X方向位移(10)

			end


		else --Q_屏幕怪物组[self.目标怪物].坐标.x

			if(Q_屏幕怪物组[self.目标怪物].坐标.x < self.坐标.x - 120)then
				Q_屏幕怪物组[self.目标怪物]:X方向位移(10)
			elseif( Q_屏幕怪物组[self.目标怪物].坐标.x > self.坐标.x - 110 ) then
				Q_屏幕怪物组[self.目标怪物]:X方向位移(-10)

			end

		end

	end

end

--=============================================================================--
-- ■ X方向位移
--=============================================================================--
function 主角_男鬼剑士:X方向位移(位移)

	self.坐标.x = self.坐标.x + 位移

end

--=============================================================================--
-- ■ 改变动作
--=============================================================================--
function 主角_男鬼剑士:改变动作(动作,唯一)

	if ( 唯一 ~= nil ) then

		if (self.状态 ~= 动作) then
			self.状态 = 动作

			self:PAK动画重置()

			self:动作更新()
		end

	else
		self.状态 = 动作
		if ( self.跳跃攻击 and (动作 == "跳跃_下落" or 动作 == "跳跃_上升_顶") ) then
		else
			self:PAK动画重置()
			self.上一帧动画 = 0
		end

		self:动作更新()

	end

	if( 动作 == "普攻一" or 动作 == "普攻二" or 动作 == "普攻三" or 动作 == "前刺攻击") then
		self:随机喊叫()
	end

end
--=============================================================================--
-- ■ pak动画更新
--=============================================================================--
function 主角_男鬼剑士:pak动画更新(帧率,开始帧,结束帧)


	for n=1,table.getn(self.纸娃娃组) do
		self.纸娃娃组[n].动画:更新(帧率,210 * (self.纸娃娃组[n].索引 -1) + 开始帧,210 * (self.纸娃娃组[n].索引 -1) + 结束帧)
	end

end
--=============================================================================--
-- ■ 霸体效果开关
--=============================================================================--
function 主角_男鬼剑士:霸体效果开关(开关)

	for n=1,table.getn(self.纸娃娃组) do
		self.纸娃娃组[n].动画.边线可视 = 开关
	end

end
--=============================================================================--
-- ■ PAK动画重置
--=============================================================================--
function 主角_男鬼剑士:PAK动画重置()

	for n=1,table.getn(self.纸娃娃组) do
		self.纸娃娃组[n].动画:重置()
	end

end

--=============================================================================--
-- ■ 碰撞检测
--=============================================================================--
function 主角_男鬼剑士:碰撞检测()

	if (self.上次位置.x ~= self.坐标.x or self.上次位置.y ~= self.坐标.y )then

		for n = 1, #Q_地图.矩形_障碍层 do

			if(Q_地图.矩形_障碍层[n].包围盒:检查点(self.坐标.x + Q_画面偏移.x, self.坐标.y + Q_画面偏移.y)) then
				--Y轴移动判断
				if(self.上次位置.y ~= self.坐标.y) then

					if(Q_地图.矩形_障碍层[n].包围盒:检查点(self.坐标.x + self.角色属性.移动速度 * self.方向 + Q_画面偏移.x, self.上次位置.y + Q_画面偏移.y ) == false) then

						self.坐标.y = self.上次位置.y

						if (引擎.按键按住 (键_键盘左) or 引擎.按键按住 (键_键盘右)) then
							break
						end

						if (self.移动中) then

							if (self.方向 == -1 ) then
								if(Q_地图:是否可行(self.坐标.x - self.角色属性.移动速度, self.坐标.y) == true) then

									self.坐标.x = self.坐标.x - self.角色属性.移动速度

								end

							else
								if(Q_地图:是否可行(self.坐标.x + self.角色属性.移动速度, self.坐标.y) == true) then
									self.坐标.x = self.坐标.x + self.角色属性.移动速度
								end
							end
						end
					else

						self.坐标.x = self.上次位置.x
						self.坐标.y = self.上次位置.y
						self.地平线 = self.上次地平线

					end

					break
				end
				--X轴移动判断
				if (self.上次位置.x ~= self.坐标.x) then

					if (Q_地图.矩形_障碍层[n].包围盒:检查点(self.上次位置.x + Q_画面偏移.x, self.坐标.y + self.角色属性.移动速度 ) == false) then

						self.坐标.x = self.上次位置.x

						if (self.移动中) then

							if(Q_地图:是否可行(self.坐标.x, self.坐标.y - self.角色属性.移动速度)) then

								self.坐标.y = self.坐标.y - self.角色属性.移动速度

							end

							if(Q_地图:是否可行( self.坐标.x, self.坐标.y + self.角色属性.移动速度)) then

								self.坐标.y = self.坐标.y + self.角色属性.移动速度

							end

						end

						break
					else

						self.坐标.x = self.上次位置.x
						self.坐标.y = self.上次位置.y
					end
				end

				break
			end
		end

		if (Q_地图:是否可行(self.坐标.x, self.坐标.y) == false) then
			self.坐标.x = self.上次位置.x
			self.坐标.y = self.上次位置.y
		end
	end

end
--=============================================================================--
-- ■ 掉血动画显示
--=============================================================================--
function 主角_男鬼剑士:掉血动画显示()

	for n=1, table.getn(self.掉血特效组) do

		if(self.掉血特效组[n].透明度 < 10) then
			table.remove(self.掉血特效组,n)
			break
		end

	end

	for n=1, table.getn(self.掉血特效组) do

		if(self.掉血特效组[n].已经消失==false )then

			if (self.掉血特效组[n].激活) then

				self.掉血特效组[n].当前值 = self.掉血特效组[n].当前值 + self.掉血特效组[n].间隔值x

				if (self.掉血特效组[n].当前值 >= 3 or self.掉血特效组[n].当前值 <= 0) then
					self.掉血特效组[n].间隔值x = -self.掉血特效组[n].间隔值x
				end

				if (self.掉血特效组[n].类型 == "数字") then

					self.掉血特效组[n].a = self.掉血特效组[n].当前值 *15 * self.掉血特效组[n].特效大小
					self.掉血特效组[n].b = self.掉血特效组[n].当前值 * 13 * self.掉血特效组[n].特效大小
					self.掉血特效组[n].x = self.掉血特效组[n].当前值 * string.len(tostring (self.掉血特效组[n].数字)) * 8  * self.掉血特效组[n].特效大小
					self.掉血特效组[n].y = self.掉血特效组[n].当前值 * 7 *self.掉血特效组[n]. 特效大小

				elseif (self.掉血特效组[n].类型 == "文字") then
					self.掉血特效组[n].a = self.掉血特效组[n].当前值 * 65 * self.掉血特效组[n].特效大小
					self.掉血特效组[n].b = self.掉血特效组[n].当前值 * 65 * self.掉血特效组[n].特效大小
					self.掉血特效组[n].x = self.掉血特效组[n].当前值 * 16 * self.掉血特效组[n].特效大小
					self.掉血特效组[n].y = self.掉血特效组[n].当前值 * 15 *self.掉血特效组[n]. 特效大小

				end

				if (self.掉血特效组[n].间隔值x < 0 and self.掉血特效组[n].当前值 * self.掉血特效组[n].特效大小 <=1) then
					self.掉血特效组[n].激活 = false
					self.掉血特效组[n].移动消失 = true
				end

			end

			if (self.掉血特效组[n].移动消失) then

				self.掉血特效组[n].临时值 = self.掉血特效组[n].临时值 + 1
				self.掉血特效组[n].y = self.掉血特效组[n].y + 3

				if (self.掉血特效组[n].临时值 > 10) then
					self.掉血特效组[n].透明度 = self.掉血特效组[n].透明度 - 30
				end

			end

			if (self.掉血特效组[n].透明度 > 10) then
				if (self.掉血特效组[n].类型 == "数字") then
					Q_掉血文字动画:显示(self.掉血特效组[n].数字,
								 self.掉血特效组[n].显示位置x - self.掉血特效组[n].x + Q_画面偏移.x ,
								  self.掉血特效组[n].显示位置y - self.掉血特效组[n].y + Q_画面偏移.y ,
								  self.掉血特效组[n].a,
								  self.掉血特效组[n].b,
								  self.掉血特效组[n].透明度,
								  true)
				elseif (self.掉血特效组[n].类型 == "文字") then

					if (self.掉血特效组[n].文字 == "MISS") then
						MISS精灵:置颜色(ARGB(self.掉血特效组[n].透明度,255,255,255))

						MISS精灵:显示_高级(self.掉血特效组[n].显示位置x - self.掉血特效组[n].x + Q_画面偏移.x ,
												 self.掉血特效组[n].显示位置y - self.掉血特效组[n].y + Q_画面偏移.y ,
												 0,
												 self.掉血特效组[n].a/65,
												 self.掉血特效组[n].b/65)
					end

				end

			else

				self.掉血特效组[n].移动消失 = false
				self.掉血特效组[n].已经消失 = true

			end

		end

	end

end
--=============================================================================--
-- ■ 销毁
--=============================================================================--
function 主角_男鬼剑士:销毁()

	for n=table.getn(self.纸娃娃组),1,-1 do

		self.纸娃娃组[n].扩展_资源管理器:销毁()
		self.纸娃娃组[n].扩展_资源管理器 = nil
		self.纸娃娃组[n].动画:销毁()
		self.纸娃娃组[n].动画 = nil

		table.remove(self.纸娃娃组,n)

	end

	self.纸娃娃组 = nil
	self.纸娃娃组 = {}

	鬼剑士音效:销毁()

end

