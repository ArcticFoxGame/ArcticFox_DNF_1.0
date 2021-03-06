--=============================================================================--
-- @作者: 白狐剑仙。
-- @邮箱: 1733450036@qq.com
-- @创建时间:   2017-08-01 12:45:25
-- @最后修改来自: 白狐剑仙。
-- @Last Modified time: 2018-01-24 23:16:49
--=============================================================================--
wfox_pak  = class()
--=============================================================================--
-- ■ 构造函数
--=============================================================================--
function wfox_pak:初始化(资源管理器,首帧,是否缓存)

	self.临时位置 = {x=0,y=0}
	self.中心点 ={x=0,y=0}
	self.首帧  = 1

	if (首帧 ~= nil and 首帧 > 0 ) then
		self.首帧 = 首帧
	end

	self.启用缓存 = 是否缓存
	self.资源管理器 = 资源管理器
	self.pak信息组 = 复制表(self.资源管理器.PAK信息组)--复制表 --table.copy

	self.cx = 0
	self.cy = 0
	self.影子可视 = false
	self.影子透明度 = 80
	self.影子y偏移 = 70
	self.影子_跳跃偏移 = {x=0,y=0}

	self.边线可视 = false
	self.边线透明度 = 255
	self.边线透明控制变量 = 5

	self.混合 = 混合_默认
	self.停止 = false
	self.总帧数 = table.getn(self.pak信息组)

	self.pak信息组[self.首帧].纹理 = self.资源管理器:取图片(self.首帧,self.启用缓存)

	self.碎图片精灵 = require ("gge精灵类")(self.pak信息组[self.首帧].纹理)

	self.临时宽度 = self.碎图片精灵:取宽度()
	self.临时高度 = self.碎图片精灵:取高度()

	self.开始帧 = 1
	self.结束帧 = 1
	self.当前帧 = self.首帧
	self.全局计次 = 0
	self.时间累积 = 0
	self.进度值  = 1
	self.动画包围盒 = require("gge包围盒")(0,0,self.临时宽度,self.临时高度)
	self.包围盒显示 = false
end
--=============================================================================--
-- ■ 更新()
--=============================================================================--
function wfox_pak:更新(动画帧率,开始帧,结束帧)

	if (self.停止) then
		return
	end

	self.时间累积 = self.时间累积 + 0.02

	if ( 开始帧 == nil) then
		self.开始帧 = 1
		self.结束帧 = self.总帧数
	else

		self.开始帧 = 开始帧
		self.结束帧 = 结束帧
	end

	if (self.时间累积 > 动画帧率/100) then

		self.全局计次 = self.全局计次 + 1
		self.时间累积 = 0
	end

	if (self.全局计次 > self.结束帧 - self.开始帧) then
		self.全局计次 = 0
	end

	self.当前帧 = self.全局计次 + self.开始帧

	if (self.当前帧 <= table.getn(self.pak信息组)) then

		if (self.pak信息组[self.当前帧].图片 == 0 or self.pak信息组[self.当前帧].图片 ==nil ) then
			self.pak信息组[self.当前帧].图片 = self.资源管理器:取图片(self.当前帧,self.启用缓存)
		end

		self.碎图片精灵:置纹理(self.pak信息组[self.当前帧].图片)
		self.碎图片精灵:置区域(0,0,self.碎图片精灵:取宽度(),self.碎图片精灵:取高度())

		--self.碎图片精灵.rect:置宽高(self.碎图片精灵:取宽度(),self.碎图片精灵:取高度())
	end
end
--=============================================================================--
-- ■ 置坐标_高级()
--=============================================================================--
function wfox_pak:置坐标_高级(x,y,w,h,旋转,高级逻辑)

	if (w == nil) then
		w = 1
	end

	if (h == nil) then
		h = 1
	end

	if (旋转 == nil) then
		旋转 = 0
	end

	if (高级逻辑 ~= false )then
		self.动画包围盒:置宽高 (self.碎图片精灵:取宽度()* math.abs(w),self.碎图片精灵:取高度 ()*math.abs(h))
	end

	if (self.当前帧 <= table.getn(self.pak信息组)) then

		if (self.当前帧 > 0) then
			self.临时位置.x = x + self.pak信息组[self.当前帧].中心x * w
			self.临时位置.y = y + self.pak信息组[self.当前帧].中心y * h

			if (高级逻辑 ~= false )then
				if ( w > 0 ) then

					self.动画包围盒:置坐标 (self.临时位置.x -self.中心点.x * w,self.临时位置.y-self.中心点.y*h)

					if (self.影子可视) then
						self.碎图片精灵:置翻转(false)
						self.cx = self.临时位置.x - self.中心点.x * w
						self.cy = self.临时位置.y - self.中心点.y * h
					end

				else

					self.动画包围盒:置坐标 (self.临时位置.x + self.中心点.x -self.中心点.x*(1+w)-self.碎图片精灵:取宽度()*math.abs(w) , self.临时位置.y-self.中心点.y * h)

					if (self.影子可视) then
						self.碎图片精灵:置翻转(true)
						self.cx = self.临时位置.x + self.中心点.x-self.中心点.x*(1+w)-self.碎图片精灵:取宽度 () * math.abs(w)
						self.cy = self.临时位置.y - self.中心点.y* h
					end
				end
			end
		end
	end

	if (self.影子可视) then
		self.碎图片精灵:置颜色(ARGB(self.影子透明度,0,0,0))

		--左上，右上，左下，右下
		self.碎图片精灵:置顶点(
		self.cx - self.碎图片精灵:取高度 ()* math.abs(h)*0.45 + 15 + self.影子_跳跃偏移.x,
		self.cy + self.影子y偏移 + self.影子_跳跃偏移.y ,
		self.cx - self.碎图片精灵:取高度 ()* math.abs(h)*0.45 + 10+ self.碎图片精灵:取宽度 () * math.abs(w)+ self.影子_跳跃偏移.x,
		self.cy + self.影子y偏移 + self.影子_跳跃偏移.y ,
		self.cx + self.影子_跳跃偏移.x,
		self.cy + self.碎图片精灵:取高度 ()* math.abs(h)+ self.影子_跳跃偏移.y,
		self.cx + self.碎图片精灵:取宽度 ()* math.abs(w) + self.影子_跳跃偏移.x ,
		self.cy + self.碎图片精灵:取高度 ()* math.abs(h)-10 + self.影子_跳跃偏移.y
		)

		self.碎图片精灵:显示()

		self.碎图片精灵:置翻转(false)
		self.碎图片精灵:置颜色(RGB(255,255,255))--颜色_白

	end


	self.碎图片精灵:置中心(self.中心点.x - self.pak信息组[self.当前帧].中心x,self.中心点.y - self.pak信息组[self.当前帧].中心y)

	if (self.边线可视) then

		self.碎图片精灵:置混合(混合_单色)--混合_单色

		--self.边线透明度 = self.边线透明度 + self.边线透明控制变量

		if (self.边线透明度 <= 120 or self.边线透明度 >=255) then
			--self.边线透明控制变量 = -self.边线透明控制变量
		end

		self.碎图片精灵:置颜色(ARGB(self.边线透明度,255,255,0))

		if ( w > 0 ) then
			self.碎图片精灵:置坐标_高级(self.临时位置.x - self.pak信息组[self.当前帧].中心x * math.abs(w) + 1.5,self.临时位置.y - self.pak信息组[self.当前帧].中心y * math.abs(h) ,旋转,w,h)
			self.碎图片精灵:置坐标_高级(self.临时位置.x - self.pak信息组[self.当前帧].中心x * math.abs(w) - 1.5,self.临时位置.y - self.pak信息组[self.当前帧].中心y * math.abs(h) ,旋转,w,h)
			self.碎图片精灵:置坐标_高级(self.临时位置.x - self.pak信息组[self.当前帧].中心x * math.abs(w),self.临时位置.y - self.pak信息组[self.当前帧].中心y * math.abs(h) + 1.5 ,旋转,w,h)
			self.碎图片精灵:置坐标_高级(self.临时位置.x - self.pak信息组[self.当前帧].中心x * math.abs(w),self.临时位置.y - self.pak信息组[self.当前帧].中心y * math.abs(h) - 1.5 ,旋转,w,h)
			self.碎图片精灵:显示()
		else
			self.碎图片精灵:置坐标_高级(self.临时位置.x + self.pak信息组[self.当前帧].中心x * math.abs(w) + 1.5,self.临时位置.y - self.pak信息组[self.当前帧].中心y * math.abs(h) ,旋转,w,h)
			self.碎图片精灵:置坐标_高级(self.临时位置.x + self.pak信息组[self.当前帧].中心x * math.abs(w) - 1.5,self.临时位置.y - self.pak信息组[self.当前帧].中心y * math.abs(h) ,旋转,w,h)
			self.碎图片精灵:置坐标_高级(self.临时位置.x + self.pak信息组[self.当前帧].中心x * math.abs(w),self.临时位置.y - self.pak信息组[self.当前帧].中心y * math.abs(h) + 1.5 ,旋转,w,h)
			self.碎图片精灵:置坐标_高级(self.临时位置.x + self.pak信息组[self.当前帧].中心x * math.abs(w),self.临时位置.y - self.pak信息组[self.当前帧].中心y * math.abs(h) - 1.5 ,旋转,w,h)
			self.碎图片精灵:显示()
		end
	end

	self.碎图片精灵:置混合(self.混合)
	self.碎图片精灵:置颜色(RGB(255,255,255))--颜色_白

	if ( w > 0 ) then
		self.碎图片精灵:置坐标_高级(self.临时位置.x - self.pak信息组[self.当前帧].中心x * math.abs(w),self.临时位置.y - self.pak信息组[self.当前帧].中心y * math.abs(h) ,旋转,w,h)
	else
		self.碎图片精灵:置坐标_高级(self.临时位置.x + self.pak信息组[self.当前帧].中心x * math.abs(w),self.临时位置.y - self.pak信息组[self.当前帧].中心y * math.abs(h) ,旋转,w,h)
	end

end
--=============================================================================--
-- ■ 显示()
--=============================================================================--
function wfox_pak:显示()

	if (self.包围盒显示==true) then
	    self.动画包围盒:显示()
	end
	self.碎图片精灵:显示()

end
--=============================================================================--
-- ■ 显示特效()
--=============================================================================--
function wfox_pak:显示特效()

	if (self.包围盒显示==true) then
	    self.动画包围盒:显示(橙)
	end
	self.碎图片精灵:置过滤(true)
	self.碎图片精灵:显示()

end
--=============================================================================--
-- ■ 显示_高级()
--=============================================================================--
function wfox_pak:显示_高级(x,...)--x,y,w,h,旋转,高级逻辑
	if (self.包围盒显示==true) then
	    self.动画包围盒:显示()
	end
	self.碎图片精灵:置坐标_高级(x,...)
	self.碎图片精灵:显示()
end
--=============================================================================--
-- ■ 置当前帧()
--=============================================================================--
function wfox_pak:置当前帧(帧)

	self.当前帧  = 帧
	if (self.pak信息组[self.当前帧].图片 == 0) then
		self.pak信息组[self.当前帧].图片 = self.资源管理器:取图片(self.当前帧,self.启用缓存)
	end

	self.碎图片精灵:置纹理(self.pak信息组[self.当前帧].图片 )
	self.碎图片精灵:置区域(0,0,self.碎图片精灵:取宽度(),self.碎图片精灵:取高度())

	--self.碎图片精灵.rect:置宽高(self.碎图片精灵:取宽度(),self.碎图片精灵:取高度())
end
--=============================================================================--
-- ■ 取当前帧()
--=============================================================================--
function wfox_pak:取当前帧()
	return self.当前帧
end
--=============================================================================--
-- ■ 往返更新()
--=============================================================================--
function wfox_pak:往返更新(动画帧率,开始帧,结束帧)

	if (self.停止) then
		return
	end

	self.时间累积 = self.时间累积 + 0.02

	if ( 开始帧 == nil) then
		self.开始帧 = 1
		self.结束帧 = self.总帧数
	else

		self.开始帧 = 开始帧
		self.结束帧 = 结束帧
	end

	if(self.全局计次 == 0)then
		self.进度值 = 1
	end

	if(self.全局计次 + self.开始帧 == self.结束帧)then
		self.进度值 = -1
	end

	if (self.时间累积 > 动画帧率/100) then

		self.全局计次 = self.全局计次 + self.进度值
		self.时间累积 = 0
	end

	self.当前帧  = self.全局计次 + self.开始帧

	if (self.pak信息组[self.当前帧].图片 == 0) then
		self.pak信息组[self.当前帧].图片 =  self.资源管理器:取图片(self.当前帧,self.启用缓存)
	end

	self.碎图片精灵:置纹理(self.pak信息组[self.当前帧].图片)
	self.碎图片精灵:置区域(0,0,self.碎图片精灵:取宽度(),self.碎图片精灵:取高度())

	--self.碎图片精灵.rect:置宽高(self.碎图片精灵:取宽度(),self.碎图片精灵:取高度())
end
--=============================================================================--
-- ■ 置颜色()
--=============================================================================--
function wfox_pak:置颜色(颜色值,i)
	self.碎图片精灵:置颜色(颜色值,i)
end
--=============================================================================--
-- ■ 重置()
--=============================================================================--
function wfox_pak:重置()
	self.时间累积 = 0
	self.全局计次 = 0
end
--=============================================================================--
-- ■ 取间隔帧()
--=============================================================================--
function wfox_pak:取间隔帧()
	return self.全局计次
end
--=============================================================================--
-- ■ 暂停()
--=============================================================================--
function wfox_pak:暂停()
	self.停止 =true
end
--=============================================================================--
-- ■ 继续()
--=============================================================================--
function wfox_pak:继续()
	self.停止 = false
end
--=============================================================================--
-- ■ 置混合()
--=============================================================================--
function wfox_pak:置混合(混合值)
	self.混合 = 混合值
	self.碎图片精灵:置混合(混合值)
end
--=============================================================================--
-- ■ 置中心点()
--=============================================================================--
function wfox_pak:置中心点(x,y)
	self.中心点.x = x
	self.中心点.y = y
end
--=============================================================================--
-- ■ 销毁()
--=============================================================================--
function wfox_pak:销毁()

	if (self.启用缓存 == false) then
		for n=1,table.getn(self.pak信息组) do
			if ( self.pak信息组[n].纹理 ~= 0  ) then
				self.pak信息组[n].纹理 = nil
			end
		end
		self.pak信息组 = nil
	end
	self.碎图片精灵 = nil
	self.碎图片精灵 = nil
	self.动画包围盒 = nil
end
