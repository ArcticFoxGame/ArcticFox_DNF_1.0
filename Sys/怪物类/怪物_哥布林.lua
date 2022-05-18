--=============================================================================--
-- @作者: 白狐剑仙。
-- @邮箱: 1733450036@qq.com
-- @创建时间:   2017-08-01 12:45:25
-- @最后修改来自: 白狐剑仙。
-- @Last Modified time: 2017-11-18 01:03:31
--=============================================================================--
怪物_哥布林  = class()
--=============================================================================--
-- ■ 构造函数
--=============================================================================--
function 怪物_哥布林:初始化(坐标x,坐标y,id,智能,类别,更换名称)

	self.id = id
	self.标识类型 = "屏幕怪物"

	Q_怪物_哥布林_管理器 = 扩展_资源管理器.创建([[Dat\PAK\怪物PAK\monster\怪物_哥布林.pak]])

	self.身体 = wfox_pak.创建(Q_怪物_哥布林_管理器,1,true)
	self.武器 = wfox_pak.创建(Q_怪物_哥布林_管理器,18,true)
	self.身体:置中心点(100,150)
	self.武器:置中心点(100,150)

	self.方向 = -1  -- 右
	self.坐标 = {x=坐标x,y=坐标y}
	self.上次位置 = {x=0,y=0}
	self.上次地平线 = 0
	self.怪物_目标点   = {x=self.坐标.x,y=self.坐标.y}

	self.模型大小 = 1

	self.上一帧动画 = 0

	self.状态 = "静止"

	self.动画帧率 = {
			静止 = 16,
			行走 = 20,
			被击中A = 16 ,
			被击中B = 16 ,
			死亡 = 14,
			攻击 = 14
	}

	self.属性 = {
		名称 = "哥布林",
		等级 = 1,
		HP = 3000,
		MAXHP = 1000,
		物理攻击力 = 5,
		魔法攻击力 = 0,
		物理防御力 = 3,
		魔法防御力 = 1.5


	}

	self.攻击有效 = false

	self.硬直时间 = 100

	self.击退力量 = 0
	self.击退速度 = 0

	self.智能等级 = 智能
	self.移动优先 = ""
	self.移动间隔 = 1
	self.速度 = 1
	self.怪物_攻击频率 = 1.1
	self.攻击频率计次  = 0
	self.攻击X范围  = 60
	self.攻击Y范围  = 25

	self.AI计次 = 0
	self.AI时间 = 引擎.取时间戳()

	self.移动中 = false

	self.跳跃偏移 = 0

--死亡无敌判定初始化
	self.无敌 = false
	self.可击飞 = true
	self.可击退 = true
	self.死亡 = false
	self.死亡倒地 = false
	self.死亡消失 = false
	--self.死亡时间 = 0
	self.死亡时间计次  = 0

--音效初始化
	self.攻击音效 =  require("BASS类")(Q_目录.. [[\Dat\Audio\monster_sound\哥布林\gbn_thw.wav]])
	self.击中音效 =  require("BASS类")(Q_目录.. [[\Dat\Audio\monster_sound\通用\hit_slash_04.wav]])

	self.被攻击喊叫音效 = {}
	self.被攻击喊叫音效[1] = require("BASS类")(Q_目录.. [[\Dat\Audio\monster_sound\哥布林\gbn_dmg_01.wav]])
	self.被攻击喊叫音效[2] = require("BASS类")(Q_目录.. [[\Dat\Audio\monster_sound\哥布林\gbn_dmg_02.wav]])
	self.被攻击喊叫音效[3] = require("BASS类")(Q_目录.. [[\Dat\Audio\monster_sound\哥布林\gbn_dmg_03.wav]])
	self.被攻击喊叫音效[4] = require("BASS类")(Q_目录.. [[\Dat\Audio\monster_sound\哥布林\gbn_dmg_04.wav]])

	self.死亡音效 = {}
	self.死亡音效[1] = require("BASS类")(Q_目录.. [[\Dat\Audio\monster_sound\哥布林\gbn_die_01.wav]])
	self.死亡音效[2] = require("BASS类")(Q_目录.. [[\Dat\Audio\monster_sound\哥布林\gbn_die_02.wav]])

	self.弧度 = 0
	self.摔落偏移 = 30
	self.摔落特效X偏移 = 80
	self.摔落特效Y偏移 = 0
	self.摔落特效大小 = 1.2

	self.地平线  = self.坐标.y

	self.落地时间计次 = 0

	self.记忆打飞 = {力度=0,弹力=0}
	self.跳跃被攻击 = false
	self.跳跃被攻击延迟 = 0
	self.被击弹跳力 = 0

	self.掉血特效组 = {}
	self.来源ID = 1
	self.被攻击信息 = {}
	self.被攻击信息[self.来源ID] = {来源 = "",方式 = "",时间= 0}
	self.被攻击延时 = 1
	self.被攻击硬直 = 200

	self.顶部显示 = string.format("Lv.%d %s", self.属性.等级,self.属性.名称)
	self.顶部显示宽度 = 文字:取宽度(self.顶部显示)
	self.顶部显示偏移 = 80
	self.字体={x=35,y=120,图片宽度=0.8,图片高度=1.2} --为方便写入这里



--防止拉取导致坐标跳出障碍外
	self.不可移动怪物_目标点 = false

--掉宝配置
	self.掉宝物品组 = {}
	self.掉宝配置 =
	{
		"金币 1\15 10",
		"生锈的铁剑 1\35 1",
	}
	if (self.掉宝配置 ~= nil) then
		--self.掉宝物品组 = 取怪物掉宝(self.标识,self.掉宝配置)
	end

end

--=============================================================================--
-- ■ 更新
--=============================================================================--
function 怪物_哥布林:更新()


	if(self.死亡消失)then
		return
	end

	if(引擎.取时间戳() - self.被攻击信息[self.来源ID].时间 < self.硬直时间)then
		return
	end

	if(self.死亡倒地==false)then
		self.上一帧动画 = self.身体:取间隔帧()
		self:动作更新()
	end

	self:碰撞检测()

	self.上次位置.x = self.坐标.x
	self.上次位置.y = self.坐标.y
	self.上次地平线  = self.地平线

	if(self.属性.HP <=0 and self:是否在被攻击状态() == false and self:是否在跳跃状态() == false and self.状态 ~= "被受制") then
		self:死亡判断()
	end

	if ((self.状态 ~= "死亡" and self.状态 ~= "倒地死亡")) then

		self:AI处理()

		if ( self.状态 ~= "倒地" and self:是否在被攻击状态() == false and self:是否在跳跃状态() == false and self.状态 ~= "攻击" ) then

			if (  Q_主角.坐标.x > self.坐标.x  ) then
				self.方向 = 1
			else
				self.方向 = -1
			end

		end

		if (self.跳跃被攻击 ) then
			self.跳跃被攻击延迟 = self.跳跃被攻击延迟 + dt
			if (self.跳跃被攻击延迟 > 0.1) then
				self.跳跃被攻击延迟 = 0
				self.跳跃被攻击 = false
			end
		end

		if (self.状态 == "攻击" )then

			if(math.abs(self.地平线 - Q_主角.地平线) < self.攻击Y范围 and	__包围盒碰撞检测(self.武器.动画包围盒,Q_主角.身体.动画包围盒))then
				self:攻击判断校正()
			end

			if (self.身体:取间隔帧() == 3 and self.上一帧动画 == 2) then
				self.攻击音效:播放()
			end

			if (self.身体:取间隔帧() == 0 and self.上一帧动画 == 4) then
				self:改变动作("静止")
				self.攻击有效 = false
			end
		end


		if (self.击退力量 > 0) then
			self.击退力量 = self.击退力量 - self.击退速度
			if (Q_主角.方向 ~= self.方向) then
				self:X方向位移(self.击退力量 * -self.方向 )
			end
		end


		self:被攻击打飞逻辑 ()

		if (self.状态 == "倒地" ) then

			if(引擎.取随机整数(2,2) == 2)then
				self.落地时间计次 = self.落地时间计次 + dt
				if(self.落地时间计次 > 0.45)then
					self:改变动作("蹲伏")
					self.落地时间计次 = 0
				end
			else
				self.落地时间计次 = self.落地时间计次 + dt
				if (self.落地时间计次 > 0.35) then
					self:改变动作("静止")
					self.落地时间计次 = 0
				end
			end

		end

		if(self.状态 == "蹲伏") then
			self.无敌 = true
			self.落地时间计次 = self.落地时间计次 + dt
			if (self.落地时间计次 > 0.35) then
				self:改变动作("静止")
				self.无敌 = false
				self.落地时间计次 = 0
			end
		end

		if (math.abs( self.怪物_目标点.x - self.坐标.x) > self.速度 or math.abs(self.怪物_目标点.y - self.坐标.y) > self.速度) then

			if (self:是否在被攻击状态() == false and self:是否在跳跃状态() == false and self.状态 ~= "倒地" and self.状态 ~= "攻击") then
				self:移动逻辑()
				self.无敌 = false
			end

		else
			if (self:是否在被攻击状态() == false and self.状态 ~= "倒地" and self.状态 ~= "攻击") then
				self:改变动作("静止",true )
				self.无敌 = false
			end
		end

		if (self.状态 == "被击中A" or self.状态 == "被击中B") then
			if ( 引擎.取时间戳() - self.被攻击信息[self.来源ID].时间 - 50 > self.被攻击硬直) then
				self.落地时间计次 = self.落地时间计次 + dt
				if (self.落地时间计次 > 0.35) then
					self:改变动作("静止")
					--self.无敌 = false
					self.落地时间计次 = 0
				end
			end
		elseif (self.状态 ==  "被受制") then
			if (  Q_主角.坐标.x > self.坐标.x  ) then
				self.方向 = 1
			else
				self.方向 = -1
			end
		end

	else--判断死亡状态
		if ((self.上一帧动画 >= 4 and self.状态 == "倒地死亡") or self.状态 == "死亡") then
			self.死亡倒地 = true
		end
	end

end

--=============================================================================--
-- ■ AI处理
--=============================================================================--
function 怪物_哥布林:AI处理()

	local 移动中间值 = 0
	local 寻找X最小范围 = 0
	local 寻找X最大范围 = 0
	local 寻找Y最小范围 = 0
	local 寻找Y最大范围 = 0
	local 不可通行 = false

	if (self.智能等级 == 1) then
		移动中间值 = 8
		self.移动间隔 = 2000
		寻找X最小范围 = -200
		寻找X最大范围 = 200
		寻找Y最小范围 = -150
		寻找Y最大范围 = 150

	elseif (self.智能等级 == 2) then
		移动中间值 = 6
		self.移动间隔 = 1500
		寻找X最小范围 = -150
		寻找X最大范围 = 150
		寻找Y最小范围 = -100
		寻找Y最大范围 = 100

	elseif (self.智能等级 == 3) then
		移动中间值 = 4
		self.移动间隔 = 1200
		寻找X最小范围 = -100
		寻找X最大范围 = 100
		寻找Y最小范围 = -50
		寻找Y最大范围 = 50

	elseif (self.智能等级 == 4) then
		移动中间值 = 2
		self.移动间隔 = 100
		寻找X最小范围 = -50
		寻找X最大范围 = 50
		寻找Y最小范围 = -50
		寻找Y最大范围 = 50

	end

	if ( self.状态 == "静止") then

		if (引擎.取时间戳 () - self.AI时间 > self.移动间隔) then
			--print(引擎.取时间戳())

			if (引擎.取随机整数 (1, 10) > 移动中间值) then

				if (self.地平线 > 430 or self.地平线 < 280) then
					self.怪物_目标点.y =    Q_主角.地平线  + 引擎.取随机整数(寻找Y最小范围,寻找Y最大范围)
				else
					self.怪物_目标点.y =    Q_主角.地平线  + 引擎.取随机整数(寻找Y最小范围,寻找Y最大范围)
				end

				if (self.坐标.x  < 100 or  self.坐标.x  > Q_地图宽度 - 200) then
					self.怪物_目标点.x =    Q_主角.坐标.x
				else
					self.怪物_目标点.x =    Q_主角.坐标.x + 引擎.取随机整数(寻找X最小范围,寻找X最大范围)
				end

			end

			self.AI时间 = 引擎.取时间戳 ()

		end

	end

	if (self:是否在被攻击状态() == false and self.状态 ~= "倒地" and self.状态 ~= "攻击") then

			if ( math.abs( Q_主角.坐标.x - self.坐标.x) < self.攻击X范围  and  math.abs(self.地平线 - Q_主角.地平线)< self.攻击Y范围 ) then

				self.攻击频率计次 = self.攻击频率计次 + dt

				if (self.攻击频率计次 > self.怪物_攻击频率) then

					self:停止()
					self:改变动作("攻击")
					self.攻击频率计次 = 0

				end

			end

	end

end

--=============================================================================--
-- ■ 移动逻辑
--=============================================================================--
function 怪物_哥布林:移动逻辑()

	if (math.abs(self.怪物_目标点.x  - self.坐标.x) > self.速度 and self.移动优先 ~= "Y") then

		if ( self.怪物_目标点.x > self.坐标.x) then

			self:改变动作("行走",true)
			self:X方向位移(self.速度 )

		elseif ( self.怪物_目标点.x < self.坐标.x) then

			self:改变动作("行走",true)
			self:X方向位移(-self.速度 )

		else
			self:停止()
			self.坐标.x = self.怪物_目标点.x
		end
	end

	if (math.abs(self.怪物_目标点.y  - self.坐标.y) > self.速度) then

		if ( self.怪物_目标点.y  > self.坐标.y ) then

			self:改变动作("行走",true)
			self:Y方向位移(self.速度 )

		elseif ( self.怪物_目标点.y  < self.坐标.y ) then

			self:改变动作("行走",true)
			self:Y方向位移(-self.速度 )

		else
			self.坐标.y = self.怪物_目标点.y
			self.地平线 = self.坐标.y
			self:停止()
		end

	else

		self.移动优先 = ""
		self:停止()

	end

	self.移动中 = true

end


--=============================================================================--
-- ■ 被攻击打飞逻辑
--=============================================================================--
function 怪物_哥布林:被攻击打飞逻辑()

	if (self.死亡)then
		return
	end

	if (self.状态 == "被攻击_空中_起" and self.死亡 == false) then

		if (self.跳跃被攻击 == false ) then
			self.被击弹跳力 = self.被击弹跳力 - dt * 25
		else
			--self.被击弹跳力 = self.被击弹跳力 - dt * 25
		end

		if (self.被击弹跳力 > 0) then
			if (self.跳跃被攻击 == false ) then
				self.跳跃偏移 = self.跳跃偏移 - self.被击弹跳力
				--self.坐标.y = self.坐标.y - self.被击弹跳力
				self:X方向位移(-self.方向 * self.被击力量)
			end
		else
			self:改变动作("被攻击_空中_落")
		end

	end

	if (self.状态 == "被攻击_空中_落") then

		if (self.跳跃被攻击 == false ) then
			self.被击弹跳力 = self.被击弹跳力 + dt *30
		else
			self.被击弹跳力 = self.被击弹跳力* 0.7
		end

		if (self.跳跃偏移 < 0) then

			if (self.跳跃被攻击 == false ) then
				self.跳跃偏移 = self.跳跃偏移 + self.被击弹跳力
				--self.坐标.y = self.坐标.y + self.被击弹跳力
				self:X方向位移(-self.方向 * self.被击力量)
			end
		else

			if (self.反弹 == false) then
				self:被打飞(4,1 ,false,false)
				self.反弹 = true
			else
				self:改变动作("倒地")
				self.落地时间计次 = 0
			end
		end
	end
end


--=============================================================================--
-- ■ 显示影子
--=============================================================================--
function 怪物_哥布林:显示影子()

	if ( Q_地图配置.阴影 == "阳光" ) then

		self.身体.影子可视 = true
		self.身体.影子透明度 = 80
		self.身体.影子y偏移 = self.身体.碎图片精灵:取高度()*0.6*self.模型大小

		if(self:是否在跳跃状态())then
			self.身体.影子_跳跃偏移.x = 0
			self.身体.影子_跳跃偏移.y =   self.地平线 -  self.坐标.y + self.被击弹跳力 *3 -20
		else
			self.身体.影子_跳跃偏移.x = 0
			self.身体.影子_跳跃偏移.y = 0
		end

	else
		self.身体:置颜色(ARGB(50,255,255,255))
		self.武器:置颜色(ARGB(50,255,255,255))
	end

end

--=============================================================================--
-- ■ 显示
--=============================================================================--
function 怪物_哥布林:显示()

	if ( self.死亡消失 ) then
		return
	end

	if (self.死亡 and self.死亡倒地 and self.死亡消失 == false) then

		self.身体:置颜色(颜色_白)
		self.武器:置颜色(颜色_白)
		self.身体:置混合(混合_单色)
		self.武器:置混合(混合_单色)

		self.死亡时间计次 = self.死亡时间计次 + dt

		if (self.死亡时间计次 > 0.25) then
			self.死亡音效[引擎.取随机整数(1,2)]:播放()
			--test物理 = 特效_物理行为类.创建("死亡破碎",400,200,300,10,1)
			self.死亡消失 = true
		end

	end

	if (self.死亡消失 == false) then

		self:显示影子()

		if (self.死亡 == false ) then
			self.身体:置颜色(颜色_白)
			self.武器:置颜色(颜色_白)
		end
		self.身体:置坐标_高级(self.坐标.x + Q_画面偏移.x ,self.坐标.y + Q_画面偏移.y + self.跳跃偏移 ,self.方向*self.模型大小,self.模型大小,self.弧度)
		self.武器:置坐标_高级(self.坐标.x + Q_画面偏移.x ,self.坐标.y + Q_画面偏移.y + self.跳跃偏移 ,self.方向*self.模型大小,self.模型大小,self.弧度)

		self.身体:显示()
		self.武器:显示()

	end

	self:掉血动画显示()

	if (Q_调试) then
		self.身体.包围盒显示 = true
		self.武器.包围盒显示 = true
		引擎.画矩形(self.坐标.x + Q_画面偏移.x ,self.坐标.y + Q_画面偏移.y, self.坐标.x + Q_画面偏移.x + 10 * self.方向,self.坐标.y + Q_画面偏移.y - 10,红)
	else
		self.身体.包围盒显示 = false
		self.武器.包围盒显示 = false
	end

end


--=============================================================================--
-- ■ 被攻击
--=============================================================================--
function 怪物_哥布林:被攻击(攻击来源,攻击方式,被攻击延时,是否启用硬直,是否播放声音,掉血值,最大掉血值)

	if(self.无敌 == false)then

		self.被攻击延时 = 被攻击延时

		if (攻击来源 == self.被攻击信息[self.来源ID].来源 and 攻击方式==self.被攻击信息[self.来源ID].方式 and 引擎.取时间戳() - self.被攻击信息[self.来源ID].时间 < self.被攻击延时 ) then
			return  false
		end

		self.AI时间 = 引擎.取时间戳 ()

		self.被攻击信息[self.来源ID].来源 = 攻击来源
		self.被攻击信息[self.来源ID].方式 = 攻击方式
		self.被攻击信息[self.来源ID].时间 = 引擎.取时间戳()

		if (攻击方式 == "裂波斩" and Q_主角.目标怪物 == nil) then
			Q_主角.目标怪物 = self.id
			self:改变动作("被受制")
		end

		if (self:是否在跳跃状态() == false and self.状态 ~= "倒地" and self.状态 ~= "蹲伏") then

			self:停止()

			if (引擎.取随机整数(1,2)==1) then
				self:改变动作("被击中A")
			else
				self:改变动作("被击中B")
			end
		end

		if(是否播放声音 == true)then
			self.被攻击喊叫音效[引擎.取随机整数(1,4)]:播放()
		end

		local 临时掉血特效= {
							激活 = true ,
							显示位置x = self.坐标.x ,
							显示位置y = self.坐标.y - 70 ,
							透明度 = 255 ,
							间隔值x = 0.3 ,
							特效大小 = 0.7,
							临时值 = 0 ,
							当前值 = 0 ,
							a = 0 ,
							b = 0 ,
							x = 0 ,
							y = 0 ,
							移动消失 = false,
							数字 = 掉血值,
							已经消失 = false
						}
		临时掉血特效.类型 = "数字"


		if (掉血值 > 最大掉血值 * 0.8) then
			临时掉血特效.特效大小 = 0.7
		else
		end


		table.insert(self.掉血特效组,临时掉血特效)

		if (是否启用硬直 == nil or 是否启用硬直  ) then
			Q_主角.命中时间 = 引擎.取时间戳()
		end

		self.属性.HP  = self.属性.HP  - 掉血值

		return  true
	end
	return false
end


--=============================================================================--
-- ■ 掉落物品
--=============================================================================--
function 怪物_哥布林:死亡判断()

	if (self.死亡) then
		return
	end

	if(self.属性.HP <= 0) then
		self.属性.HP = 0
			if( self.状态 == "倒地")then
				self:改变动作("死亡")
				self.状态 = "死亡"
				self.死亡 = true
			else
				self:改变动作("倒地死亡")
				self.状态 = "倒地死亡"
				self.死亡 = true
			end
			--self:掉落物品()
	end

end

--=============================================================================--
-- ■ 掉落物品
--=============================================================================--
function 怪物_哥布林:掉落物品()

	--引擎.置随机种子()

	local 临时掉宝  = {}

	for n=1,#self.掉宝物品组 do

		if (self.掉宝物品组[n] ~= "") then

			local 最大几率 = self.掉宝物品组[n].最大几率

			local 随机结果 = 引擎.取随机整数 (1,最大几率)

			if (随机结果 <= self.掉宝物品组[n].最小几率) then	 -- 掉宝成功

				临时掉宝 = {
					物品道具 = self.掉宝物品组[n].物品道具,
					掉落数量 = self.掉宝物品组[n].掉落数量
				}
				if (临时掉宝.物品道具.总类== "金币"  ) then
					临时掉宝.掉落数量 = math.ceil( 临时掉宝.掉落数量 * 引擎:取随机小数(0.8,1.2) )
				end
				Q_系统:掉落物品(临时掉宝.物品道具,self.坐标.x,self.坐标.y,临时掉宝.掉落数量)

			end
		end
	end
end

--=============================================================================--
-- ■ 攻击判断校正
--=============================================================================--
function 怪物_哥布林:攻击判断校正()

	if ( self.状态 == "攻击"  and self.上一帧动画 >= 2 and  self.上一帧动画 < 5 and self.攻击有效 == false ) then

		if( Q_主角:被攻击("怪物" .. self.id ,self.状态,self.方向,self:伤害计算(0,Q_主角) ))then

			self.攻击有效 = true

			if (Q_主角.状态 == "格挡" ) then
				Q_主角:被击退(6,1,self.方向)
			else
				Q_系统:显示AS特效(Q_打击_特效_管理器,"打击一_钝器",Q_主角.坐标.x,Q_主角.坐标.y-50,1,"普通",self.方向,0.8)
				self.击中音效:播放()
			end
		end

		return
	end

end

--=============================================================================--
-- ■ 伤害计算 --0 为物理伤害，1为魔法伤害 技能伤害另算
--=============================================================================--
function 怪物_哥布林:伤害计算(类型,本次怪物目标)

	local 本次命中值 = 0
	local 最终伤害  = 0
	local 基础伤害  = 0

	local 保底伤害 = 0


	if (类型 == 0) then

		保底伤害 = 取整(self.属性.物理攻击力/3) + 引擎.取随机整数(1,3)
		基础伤害 = math.ceil( (self.属性.物理攻击力  - 本次怪物目标.角色属性.物理防御力) * 引擎.取随机小数(0.9 ,1))

		if ( 基础伤害 <= 0 ) then

			最终伤害 = 保底伤害
			基础伤害 = 保底伤害

		else
			基础伤害 = 保底伤害  + 基础伤害
			最终伤害 = 取整( 基础伤害 * 引擎.取随机小数(0.8,1.3) )
		end

		--if (引擎.取随机整数(1,100) <= self.角色属性.物理暴击) then -- 出现暴击
		--	最终伤害 = 取整( 最终伤害 * 引擎.取随机小数(1.1,1.8) )
		--end

	elseif (类型 == 1) then

		保底伤害 = 取整(self.角色属性.魔法攻击力/3) + 引擎.取随机整数(1,3)
	    基础伤害 = math.ceil( (self.角色属性.魔法攻击力  - 本次怪物目标.角色属性.魔法防御力) * 引擎.取随机小数(0.9 ,1))

		if ( 基础伤害 <= 0 ) then

			最终伤害 = 保底伤害
			基础伤害 = 保底伤害

		else
			基础伤害 = 保底伤害  + 基础伤害
			最终伤害 = 取整( 基础伤害 * 引擎.取随机小数(0.8,1.3) )
		end

		--if (引擎.取随机整数(1,100) <= self.角色属性.魔法暴击) then -- 出现暴击
		--	最终伤害 = 取整( 最终伤害 * 引擎.取随机小数(1.1,1.8) )
		--end


	end

	return 最终伤害,基础伤害
end


--=============================================================================--
-- ■ 动作更新
--=============================================================================--
function 怪物_哥布林:动作更新()

	if (self.状态 ==  "静止") then

		self:pak动画更新(self.动画帧率.静止,1,1)
		if(self.跳跃被攻击 == true)then
			self.跳跃偏移 = 0
		--else
		end

	elseif (self.状态 ==  "行走") then

		self:pak动画更新(self.动画帧率.行走,12,17)
		--if(self.跳跃被攻击 == true)then
			self.跳跃偏移 = 0
		--else
		--end


	elseif (self.状态 ==  "攻击") then

		self:pak动画更新(self.动画帧率.攻击,1,5)

	elseif (self.状态 ==  "被攻击_空中_起") then

		if (self.跳跃被攻击 ) then
			self:pak动画更新(self.动画帧率.被击中A,7,7)
		else
			self:pak动画更新(self.动画帧率.被击中A,8,8)
		end

	elseif (self.状态 ==  "被攻击_空中_落") then

		if (self.跳跃被攻击 ) then
			self:pak动画更新(self.动画帧率.被击中A,7,7)
		else
			self:pak动画更新(self.动画帧率.被击中B,9,9)
		end

	elseif (self.状态 ==  "被击中A") then

		self:pak动画更新(self.动画帧率.被击中A,6,6)

	elseif (self.状态 ==  "被击中B") then

		self:pak动画更新(self.动画帧率.被击中B,7,7)

	elseif (self.状态 ==  "倒地") then

		if (self.跳跃被攻击 ) then
			self:pak动画更新(self.动画帧率.死亡,10,10)
		else
			self:pak动画更新(self.动画帧率.死亡,10,10)
		end

	elseif (self.状态 ==  "死亡") then

		self:pak动画更新(self.动画帧率.死亡,10,10)

	elseif (self.状态 ==  "倒地死亡") then

		self:pak动画更新(self.动画帧率.死亡,6,10)

	elseif (self.状态 ==  "蹲伏") then
		self:pak动画更新(self.动画帧率.被击中A,11,11)

	elseif (self.状态 ==  "被受制") then
		self:pak动画更新(self.动画帧率.被击中A,6,6)

	end
end
--=============================================================================--
-- ■ 是否在跳跃状态
--=============================================================================--
function 怪物_哥布林:是否在跳跃状态()

	if(  self.状态 == "被攻击_空中_起" or self.状态 == "被攻击_空中_落"  ) then
		return true
	end

	return false
end

--=============================================================================--
-- ■ 停止
--=============================================================================--
function 怪物_哥布林:停止()

	self.怪物_目标点.x = self.坐标.x
	self.怪物_目标点.y = self.坐标.y
	self:改变动作("静止",true)
	self.AI时间 = 引擎.取时间戳 ()
	self.移动中 = false

end

--=============================================================================--
-- ■ 是否在被攻击状态
--=============================================================================--
function 怪物_哥布林:是否在被攻击状态()

	if( self.状态 == "被击中A" or self.状态 == "被击中B" or self.状态 == "被攻击_空中_起" or self.状态 == "被攻击_空中_落" or self.状态 == "被受制" ) then
		return true
	end

	return false
end

--=============================================================================--
-- ■ 被打飞
--=============================================================================--
function 怪物_哥布林:被打飞(弹力 ,力量,是否反弹,是否变向)

	if(self.死亡 == false)then
		self:改变动作("被攻击_空中_起")
		self.被击弹跳力 = 弹力
		self.被击力量 = 力量
		self.反弹 = not 是否反弹
		self.记忆打飞.力度 = 力量
		self.记忆打飞.弹力 = 弹力
		self.怪物_目标点.x = self.坐标.x
		self.怪物_目标点.y = self.地平线  + 50
	end


	if (是否变向) then
		if (  Q_主角.坐标.x > self.坐标.x  ) then
			self.方向 = 1
		else
			self.方向 = -1
		end
	end

end
--=============================================================================--
-- ■ 被击退
--=============================================================================--
function 怪物_哥布林:被击退(力量,速度)

	self.击退力量 = 力量
	self.击退速度 = 速度
	self.AI时间 = 引擎.取时间戳 ()

end
--=============================================================================--
-- ■ 移动到
--=============================================================================--
function 怪物_哥布林:移动到(x,y)

	self.怪物_目标点.x =    x
	self.怪物_目标点.y =    y
	self:改变动作("行走",true)
	self.移动中 = true

end
--=============================================================================--
-- ■ 改变动作
--=============================================================================--
function 怪物_哥布林:改变动作(动作,唯一)
	if ( 唯一 ~= nil ) then
		if (self.状态 ~= 动作) then
			self.状态 = 动作

			self:PAK动画重置()

			self:动作更新()
		end
	else
		self.状态 = 动作
		self:PAK动画重置()
		self:动作更新()
		self.上一帧动画 = 0

	end
end
--=============================================================================--
-- ■ 取素材中心点X
--=============================================================================--
function 怪物_哥布林:取素材中心点X()

	return math.ceil( self.身体.动画包围盒:取宽度()/2)

end
--=============================================================================--
-- ■ 取素材中心点Y
--=============================================================================--
function 怪物_哥布林:取素材中心点Y()

	return math.ceil( self.身体.动画包围盒:取高度()/2 - self.跳跃偏移)

end

--=============================================================================--
-- ■ PAK动画更新
--=============================================================================--
function 怪物_哥布林:pak动画更新(帧率,开始帧,结束帧)

	self.身体:更新(帧率,开始帧,结束帧)
	self.武器:更新(帧率,开始帧+17,结束帧+17)

end
--=============================================================================--
-- ■ PAK动画重置
--=============================================================================--
function 怪物_哥布林:PAK动画重置()

	self.身体:重置()
	self.武器:重置()

end
--=============================================================================--
-- ■ X方向位移
--=============================================================================--
function 怪物_哥布林:X方向位移(位移)
	self.坐标.x  = self.坐标.x + 位移
end
--=============================================================================--
-- ■ Y方向位移
--=============================================================================--
function 怪物_哥布林:Y方向位移(位移)
	self.坐标.y = self.坐标.y + 位移
	self.地平线 = self.坐标.y
end
--=============================================================================--
-- ■ 碰撞检测
--=============================================================================--
function 怪物_哥布林:左右障碍检测(位移,y)

	--[[for n=1 , table.getn(Q_地图.矩形_障碍层) do
		if(Q_地图.矩形_障碍层[n].包围盒:检查点( self.坐标.x +位移 + Q_画面偏移.x,y) ) then
			return n
		end
	end

	return 0--]]
end

--=============================================================================--
-- ■ 碰撞检测
--=============================================================================--
function 怪物_哥布林:上下障碍检测(x,位移)

	--[[for n=1 , table.getn(Q_地图.矩形_障碍层) do
		if(Q_地图.矩形_障碍层[n].包围盒:检查点(x + Q_画面偏移.x,self.坐标.y +位移) ) then
			return  n
		end
	end

	return 0--]]
end


--=============================================================================--
-- ■ 碰撞检测
--=============================================================================--
function 怪物_哥布林:碰撞检测()

	if (self.上次位置.x ~= self.坐标.x or self.上次位置.y ~= self.坐标.y )then

		for n = 1, #Q_地图.矩形_障碍层 do

			if(Q_地图.矩形_障碍层[n].包围盒:检查点(self.坐标.x + Q_画面偏移.x, self.坐标.y + Q_画面偏移.y)) then
				--Y轴移动判断
				if(self.上次位置.y ~= self.坐标.y) then

					if(Q_地图.矩形_障碍层[n].包围盒:检查点(self.坐标.x + self.速度 * self.方向 + Q_画面偏移.x, self.上次位置.y + Q_画面偏移.y ) == false) then
						self.坐标.y = self.上次位置.y
						self.怪物_目标点.y = self.坐标.y -self.速度

						if (self.移动中) then

							if (self.方向 == -1 ) then
								if(Q_地图:是否可行(self.坐标.x - self.速度, self.坐标.y)) then

									self.坐标.x = self.坐标.x - self.速度
									self.怪物_目标点.x = self.坐标.x - self.速度

								end

							else
								if(Q_地图:是否可行(self.坐标.x + self.速度, self.坐标.y)) then
									self.坐标.x = self.坐标.x + self.速度
									self.怪物_目标点.x = self.坐标.x + self.速度
								end
							end

						end
					else
						self:停止()
						self.坐标.x = self.上次位置.x
						self.坐标.y = self.上次位置.y
						self.地平线 = self.上次地平线


					end

					return
				end
				--X轴移动判断
				if (self.上次位置.x ~= self.坐标.x) then

					if (Q_地图.矩形_障碍层[n].包围盒:检查点(self.上次位置.x + Q_画面偏移.x, self.坐标.y + self.速度 ) == false) then

						self.坐标.x = self.上次位置.x
						self.怪物_目标点.x = self.坐标.x -self.速度

						if (self.移动中) then

							if(Q_地图:是否可行(self.坐标.x, self.坐标.y - self.速度)) then
								self.坐标.y = self.坐标.y - self.速度
								self.怪物_目标点.y = self.坐标.y - self.速度

							end

							if(Q_地图:是否可行( self.坐标.x, self.坐标.y + self.速度)) then
								self.坐标.y = self.坐标.y + self.速度
								self.怪物_目标点.y = self.坐标.y + self.速度

							end

						end
					else
						self:停止()
						self.坐标.x = self.上次位置.x
						self.坐标.y = self.上次位置.y
					end
					return
				end

				break
			end
		end
		--用于被击退的判断
		if (Q_地图:是否可行(self.坐标.x, self.坐标.y) == false) then
			self.坐标.x = self.上次位置.x
			self.坐标.y = self.上次位置.y
		end
	end

end

--=============================================================================--
-- ■ 掉血动画显示
--=============================================================================--
function 怪物_哥布林:掉血动画显示()

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

					Q_掉血文字动画:显示(self.掉血特效组[n].数字,self.掉血特效组[n].显示位置x - self.掉血特效组[n].x + Q_画面偏移.x ,
									self.掉血特效组[n].显示位置y - self.掉血特效组[n].y  + Q_画面偏移.y  + self.跳跃偏移,
								  	self.掉血特效组[n].a,self.掉血特效组[n].b,self.掉血特效组[n].透明度,false)

				elseif (self.掉血特效组[n].类型 == "文字") then

					if (self.掉血特效组[n].文字 == "MISS") then
						MISS精灵:置颜色(ARGB(self.掉血特效组[n].透明度,255,255,255))

						MISS精灵:置坐标_高级(self.掉血特效组[n].显示位置x - self.掉血特效组[n].x + Q_画面偏移.x ,self.掉血特效组[n].显示位置y - self.掉血特效组[n].y + Q_画面偏移.y ,
											0,self.掉血特效组[n].a/65,self.掉血特效组[n].b/65)

						MISS精灵:显示()
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
function 怪物_哥布林:销毁()

	self.身体:释放()
	self.武器:释放()


	self.掉血特效组 = nil

end

