-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-01-27 03:51:34
-- @最后修改来自: baidwwy
-- @Last Modified time: 2017-11-14 19:42:23
--======================================================================--
local _tostring = function (t) return "ggeRect" end

--======================================================================--
local ggeobj = class()
rawset(ggeobj, '__new__', require("__ggerect__"))

local function _计算( self )
	self.x1 = self.x
	self.y1 = self.y
	self.x2 = self.x+self.w
	self.y2 = self.y+self.h
end
--x,y,宽度,高度,是否创建核心
function ggeobj:初始化(x,y,w,h,gge)
	self.x = x or 0
	self.y = y or 0
	self.w = w or 0
	self.h = h or 0
	_计算( self )
	self.中心x = 0
	self.中心y = 0
	if gge then
	    self._obj = ggeobj.__new__(self.x,self.y,self.x2,self.y2)
	    self._obj:SetL(__gge.state)
	end
	getmetatable(self).__tostring = _tostring
end
function ggeobj:检查盒(b)
	if self:是否核心() or b:是否核心() then
		local aptr = self:取指针()
		local bptr = b:取指针()
		assert(bptr ~= 0 , "无法获取被检查盒的指针,请确定是核心包围盒.")
		assert(aptr ~= 0 , "无法获取被检查盒的指针,请确定是核心包围盒.")
		return self._obj:Intersect(b:取指针())
	elseif self:检查点(b.x,b.y) then
	    return 1
	elseif self:检查点(b.x2,b.y) then
	    return 2
	elseif self:检查点(b.x,b.y2) then
	    return 3
	elseif self:检查点(b.x2,b.y2) then
	    return 4
	elseif (b.x > self.x or b.x2 > self.x) and b.x <= self.x2 and self.y > b.y and self.y <= b.y2 then
		return 0
	end
	return false
end
function ggeobj:是否核心()
	return self._obj
end

function ggeobj:检查点(x,y)
	if type(x) == 'table' then x,y=x.x or 0,x.y or 0 end

	if self:是否核心() then
		return self:取指针() ~= 0 and self._obj:TestPoint(x,y)
	elseif x>=self.x and x<=self.x2 then
	    if y>=self.y and y<=self.y2 then
	    	return true
		end
	end

	return false
end
function ggeobj:置中心(x,y)
	self.中心x = x or self.中心x
	self.中心y = y or self.中心y
	self.x = self.x -self.中心x
	self.y = self.y -self.中心y
	_计算( self )
	if self._obj then self._obj:Move(self.x,self.y)end
	return self
end
function ggeobj:置坐标(x,y)
	if type(x) == 'table' then
	    y,x = x.y,x.x
	end
	self.x = x -self.中心x
	self.y = y -self.中心y
	_计算( self )
	if self._obj then self._obj:Move(self.x,self.y)end
	return self
end
function ggeobj:置宽高(x,y)
	self.w = x
	self.h = y
	_计算( self )
	if self._obj then self._obj:Set(self.x,self.y,self.x2,self.y2)end
	return self
end
function ggeobj:置坐标宽高(x,y,w,h)
	self.x = x
	self.y = y
	if w then
		self.w = w
		self.h = h
	end
	_计算( self )
	if self._obj then self._obj:Set(self.x,self.y,self.x2,self.y2)end
end
local 画线 = 引擎.画线
function ggeobj:显示(c)
	c = c or -1
	画线(self.x,self.y,self.x2,self.y,c)--上
	画线(self.x,self.y2,self.x2,self.y2,c)--下
	画线(self.x,self.y,self.x,self.y2,c)--左
	画线(self.x2,self.y,self.x2,self.y2,c)--右
end

function ggeobj:取坐标()
	return self.x,self.y
end
function ggeobj:取宽度()
	return self.w
end
function ggeobj:取高度()
	return self.h
end
function ggeobj:取顶点x()
	return self.x
end
function ggeobj:取顶点y()
	return self.y
end
function ggeobj:取中心()
	return self.中心x,self.中心y
end
-------------------------------------------------------------------
function ggeobj:置指针(p)
	if not self._obj then
	    self._obj = ggeobj.__new__(0,0,0,0)
	end
	self._obj:SetP(p)
	return self
end
function ggeobj:取指针()
	return self._obj and self._obj:GetP() or 0
end
return ggeobj