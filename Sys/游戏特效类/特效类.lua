--=============================================================================--
-- @作者: 白狐剑仙。
-- @邮箱: 1733450036@qq.com
-- @创建时间:   2017-08-01 12:45:25
-- @最后修改来自: 白狐剑仙。
-- @Last Modified time: 2018-01-25 00:16:44
--=============================================================================--
特效类  = class()
--=============================================================================--
-- ■ 构造函数
--=============================================================================--
function 特效类:初始化(资源管理器,特效类型,x坐标,y坐标,显示次数,中心点偏移x,中心点偏移y,开始帧,结束帧,帧速,是否混合,颜色值,Y偏移,是否移动,显示w,显示h,显示方向)	-- 显示次数为0 则标识该特效无限循环

	self.标识类型 = "屏幕特效"
	self.特效动画 =  wfox_pak.创建(资源管理器,开始帧,true)
	self.类型 = 特效类型
	self.方向 = 1
	self.缩放 = 1

	if(显示方向 == nil)then
		self.动态方向 = 0
	else
		self.动态方向 = 显示方向
	end
	self.特效动画:置中心点 (中心点偏移x,中心点偏移y)

	self.坐标 = {x=x坐标,y=y坐标}
	self.原坐标 = {x=x坐标,y=y坐标}
	self.参照点 = {x=x坐标,y=y坐标}
	self.中心点偏移 = {x = 中心点偏移x,y = 中心点偏移y}

	self.w = 显示w
	self.h = 显示h

	if (是否混合 == 1) then
		self.特效动画:置混合 (混合_颜色乘)
	end

	if (是否移动 == nil) then
		self.是否移动 = false
	else
		self.是否移动 = 是否移动
		self.移动方向 = 1
	end

	self.Y偏移 = Y偏移
	self.地平线 = self.坐标.y + self.Y偏移
	self.弧度 = 0

	if ( 颜色值 ~= "0" ) then

		local  颜色分割 = 分割文本(颜色值, "|")

		if (table.getn(颜色分割) == 4 ) then

			local 颜色值 = {
				A = tonumber( 颜色分割[1] ),
				R = tonumber( 颜色分割[2] ),
				G = tonumber( 颜色分割[3] ),
				B = tonumber( 颜色分割[4] )
			}
			self.特效动画 :置颜色(ARGB(颜色值.A,颜色值.R,颜色值.G,颜色值.B))
		end
	end

	if ( self.类型 == "跟随主角" ) then

	elseif ( self.类型 == "主角中心跟随" ) then

		if (Q_主角.职业 == "鬼剑士") then
			self.参照点.x = Q_主角.坐标.x + Q_画面偏移.x + 5
			self.参照点.y = Q_主角.坐标.y + Q_画面偏移.y - 40
			self.坐标.x = Q_主角.坐标.x + 5
			self.坐标.y = Q_主角.坐标.y - 70
		else

			self.参照点.x = Q_主角.坐标.x + Q_画面偏移.x + 2
			self.参照点.y = Q_主角.坐标.y + Q_画面偏移.y - 50
			self.坐标.x = Q_主角.坐标.x + 2
			self.坐标.y = Q_主角.坐标.y - 80

		end

	else
		self.参照点.x = self.坐标.x + Q_画面偏移.x
		self.参照点.y = self.坐标.y + Q_画面偏移.y
	end

	沉浮偏移值 = 0.09
	沉浮位置 = 0


	self.已经消失 = false

	self.显示次数 = 显示次数
	self.当前显示次数  = 0

	self.累积判断 = false

	if (开始帧 == nil) then
		self.开始索引 = 0
		self.结束索引 = 0
	else
		self.开始索引 = 开始帧
		self.结束索引 = 结束帧
	end

	if (帧速 == nil) then
		self.帧速 = 16
	else
		self.帧速 = 帧速
	end

	self.上一帧动画 = 0
	self.帧数 = 结束帧 - 开始帧
end

--=============================================================================--
-- ■ 更新
--=============================================================================--
function 特效类:更新()

	沉浮位置 = 沉浮位置 + 沉浮偏移值
	if (沉浮位置 > 10 or  沉浮位置 < 0) then
		沉浮偏移值 = -沉浮偏移值
	end

	if ( self.类型 == "跟随主角" ) then

	elseif ( self.类型 == "主角中心跟随" ) then

		if (Q_主角.职业 == "鬼剑士") then
			self.参照点.x = Q_主角.坐标.x + Q_画面偏移.x + 5
			self.参照点.y = Q_主角.坐标.y + Q_画面偏移.y - 40
			self.坐标.x = Q_主角.坐标.x + 5
			self.坐标.y = Q_主角.坐标.y - 70
		else

			self.参照点.x = Q_主角.坐标.x + Q_画面偏移.x + 2
			self.参照点.y = Q_主角.坐标.y + Q_画面偏移.y - 50
			self.坐标.x = Q_主角.坐标.x + 2
			self.坐标.y = Q_主角.坐标.y - 80

		end

	else
		self.参照点.x = self.坐标.x + Q_画面偏移.x
		self.参照点.y = self.坐标.y + Q_画面偏移.y
	end


	self.上一帧动画 = self.特效动画:取间隔帧()

	if (self.开始索引 ~= 0) then
		self.特效动画:更新(self.帧速,self.开始索引,self.结束索引)
	else
		self.特效动画:更新(self.帧速)
	end

	if (self.显示次数 ~= 0) then  -- 有播放限制次数

		if( self.上一帧动画 == self.帧数 and  self.特效动画:取间隔帧() == 0) then

			if (self.累积判断 == false) then
				self.当前显示次数 = self.当前显示次数 + 1
				self.累积判断 = true
			end

		else
			self.累积判断 = false

		end

		if (self.当前显示次数 >= self.显示次数) then
			self.已经消失 = true
		end

	end

	self.地平线 = self.坐标.y + self.Y偏移

end

--=============================================================================--
-- ■ 显示
--=============================================================================--
function 特效类:显示()

	if (self.是否移动) then
		if(self.类型 == "地图光照1")then
			self.坐标.x = self.坐标.x + 0.15 * self.移动方向
			if (self.原坐标.x + 20 <= self.坐标.x) then
				self.移动方向 = -1
			elseif (self.坐标.x <= self.原坐标.x) then
				self.移动方向 = 1
			end
		elseif(self.类型 == "地图光照2")then
			self.坐标.x = self.坐标.x - 0.15 * self.移动方向
			if (self.原坐标.x - 20 >= self.坐标.x) then
				self.移动方向 = -1
			elseif (self.坐标.x >= self.原坐标.x) then
				self.移动方向 = 1
			end
		end
	end

	if (self.已经消失 == false ) then

		if ( self.类型 == "屏幕坐标" ) then

			self.特效动画:置坐标_高级(self.坐标.x ,self.坐标.y ,self.方向 * self.缩放 ,self.缩放,self.弧度)
			self.特效动画:显示特效()

		elseif (self.类型 == "地图光照1") then

			self.特效动画:置颜色(ARGB(110,255,255,255))
			self.特效动画:置坐标_高级(self.坐标.x + Q_画面偏移.x + 0.1,self.坐标.y + Q_画面偏移.y, self.w ,self.h,self.动态方向)
			self.特效动画:显示特效()

		elseif (self.类型 == "地图光照2") then

			self.特效动画:置颜色(ARGB(70,255,255,255))
			self.特效动画:置坐标_高级(self.坐标.x + Q_画面偏移.x + 0.1,self.坐标.y + Q_画面偏移.y, self.w ,self.h,self.动态方向)
			self.特效动画:显示特效()

		else
			self.特效动画:置坐标_高级(self.坐标.x + Q_画面偏移.x,self.坐标.y + Q_画面偏移.y,self.方向 * self.缩放 ,self.缩放,self.弧度)
			self.特效动画:显示特效()
		end

	end

	if (Q_调试) then
		--引擎:画矩形(self.参照点.x ,self.地平线, 5,50,颜色_黄)

		if(self.类型 == "地图光照2" or self.类型 == "地图光照1")then
			--self.特效动画.动画包围盒:显示(黄)
		else
		    self.特效动画.动画包围盒:显示(黑)
		    --文字_描边显示(文字,self.坐标.x,self.坐标.y,string.format("特效坐标为:%d,%d",self.坐标.x,self.坐标.y),颜色_蓝,颜色_黑)
		end
	end

end

--=============================================================================--
-- ■ 置位置
--=============================================================================--
function 特效类:置位置(x,y)

	self.坐标.x = x
	self.坐标.y = y

end

--=============================================================================--
-- ■ 销毁
--=============================================================================--
function 特效类:销毁()

	self.特效动画:释放()

end