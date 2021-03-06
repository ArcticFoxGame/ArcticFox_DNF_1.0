--=============================================================================--
-- @作者: 白狐剑仙。
-- @邮箱: 1733450036@qq.com
-- @创建时间:   2017-08-01 12:45:25
-- @最后修改来自: 白狐剑仙。
-- @Last Modified time: 2017-11-21 20:40:51
--=============================================================================--


--=============================================================================--
-- ■ 寻找发动技能()
--=============================================================================--
function 寻找发动技能(技能动作)

	local 当前ID = nil

	for n=1,table.getn(Q_快捷技能格子) do
		当前ID = Q_快捷技能格子[n].技能

		if (当前ID ~= nil and 当前ID.技能动作 ==  技能动作 and  当前ID.等级 >= 1) then
			return Q_快捷技能格子[n]:发动技能()
		end
	end

	for	j = 1,table.getn(Q_技能窗口.页面组) do
		for n=1,table.getn(Q_技能窗口.页面组[j].技能格子组) do
			当前ID = Q_技能窗口.页面组[j].技能格子组[n].技能

			if (当前ID ~= nil and 当前ID.技能动作 == 技能动作 and 当前ID.等级 >= 1) then

				return Q_技能窗口.页面组[j].技能格子组[n]:发动技能()

			end
		end
	end

	return  0
end

--=============================================================================--
-- ■ 格式化技能属性()
--=============================================================================--
function 格式化技能属性(技能ID)

	local 技能信息 = ""

	技能信息 = string.format("<白>%s Lv%d[地下城] \n%s", 技能ID.技能名称,技能ID.等级 ,技能ID.英文)

	if (技能ID.消耗MP > 0) then
		技能信息 = 技能信息 .. string.format("#<白>#<黄>%s<JL>%24sMP", 技能ID.技能类型,tostring(技能ID.消耗MP ))
	else
		技能信息 = 技能信息 .. string.format("#<白>#<黄>%s", 技能ID.技能类型)
	end

	if (技能ID.冷却时间 > 0) then
		技能信息 =  技能信息 .. "#<白>冷却时间:" .. tostring(技能ID.冷却时间) .. "秒"
	end

	if (技能ID.操作指令 ~= "") then
		技能信息 =  技能信息 .. "#<白>操作指令:" .. 技能ID.操作指令
	end

	if(Q_主角.角色属性.等级 >= 技能ID.学习等级)then
		技能信息 = 技能信息 .. string.format("#<白>Lv%d级以上可以学习", 技能ID.学习等级 )
	else
		技能信息 = 技能信息 .. string.format("#<红>Lv%d级以上可以学习", 技能ID.学习等级 )
	end

	if (技能ID.技能说明 ~= "0") then
		技能信息 =  技能信息 .. string.format("#<白>#<白>%s", 技能ID.技能说明)
	end

	if (技能ID.其他介绍 ~= "0") then
		技能信息 =  技能信息 .. string.format("#<白>#<JA> %s", 技能ID.其他介绍)
	end--]]

	return 技能信息
end

--=============================================================================--
-- ■ 格式化技能属性()
--=============================================================================--
function 格式化技能栏属性(技能ID)

		local 技能信息 = ""

		if (技能ID.界面说明 ~= "0") then
			技能信息 =  技能信息 .. "#<白>#<白>" .. 技能ID.界面说明
		end

		if (技能ID.技能说明 == "被动技能") then
			if (技能ID.其他介绍 ~="") then
				技能信息 =  技能信息 .. "#<白>#<JA>  " .. 技能ID.其他介绍
			end
		end

	return 技能信息
end
--=============================================================================--
-- ■ 格式化道具属性()
--=============================================================================--
function 格式化道具属性(道具ID,附加属性位置)

	local 道具信息 = ""
	local 换行 = false
	local 换行_A = false

	道具信息 = "<" .. Q_游戏道具组[道具ID].颜色值 .. ">" .. Q_游戏道具组[道具ID].名称
	道具信息 = 道具信息 .. string.format("#<%s>%s",Q_游戏道具组[道具ID].颜色值,Q_游戏道具组[道具ID].英文)

	if ( Q_游戏道具组[道具ID].总类 == "装扮") then
		道具信息 = 道具信息 .. string.format("#<白>#<白>%0.1fkg%23s金币",Q_游戏道具组[道具ID].重量,数值到格式文本(Q_游戏道具组[道具ID].价格,0,true))

		if (Q_游戏道具组[道具ID].限制职业~="0") then

			if (Q_游戏道具组[道具ID].限制职业 == Q_主角.职业) then
				道具信息 = 道具信息 .. string.format("#<白>#<白>%s可以使用",Q_游戏道具组[道具ID].限制职业 )
			else
				道具信息 = 道具信息 .. string.format("#<白>#<红>%s可以使用",Q_游戏道具组[道具ID].限制职业 )
			end

		end

		道具信息 = 道具信息 .. string.format("#<白>%s装扮%23s",Q_游戏道具组[道具ID].子类,"")

		return  道具信息
	end

	道具信息 = 道具信息 .. string.format("#<白>#<白>%0.1fkg%23s金币",Q_游戏道具组[道具ID].重量,string.format(Q_游戏道具组[道具ID].价格))

	if ( Q_游戏道具组[道具ID].分类 == "饰品") then

		道具信息 = 道具信息 .. string.format("#<白>%32s",Q_游戏道具组[道具ID].子类)

	elseif ( Q_游戏道具组[道具ID].分类 == "消耗品") then

		道具信息 = 道具信息 .. string.format("#<白>%s%26s",Q_游戏道具组[道具ID].分类,"冷却时间:" .. Q_游戏道具组[道具ID].武器物理技能MP .. "秒")

	elseif ( Q_游戏道具组[道具ID].分类 == "材料") then

		道具信息 = 道具信息 .. string.format("#<白>%s",Q_游戏道具组[道具ID].子类)


	else
		道具信息 = 道具信息 .. string.format("#<白>%s%28s",Q_游戏道具组[道具ID].子类,Q_游戏道具组[道具ID].分类)
	end


	if (Q_游戏道具组[道具ID].攻击速度状态 ~="0" and Q_游戏道具组[道具ID].总类 ~= "消耗品") then
		道具信息 = 道具信息 .. string.format("#<白>%s",Q_游戏道具组[道具ID].攻击速度状态 )
	end


	if ( Q_游戏道具组[道具ID].分类 == "饰品") then
		道具信息 = 道具信息 .."#<白>"
	end

	if (Q_游戏道具组[道具ID].总类 == "消耗品") then   --消耗品数据显示设置

		if (Q_游戏道具组[道具ID].需要等级 ~=0) then
			if(Q_游戏道具组[道具ID].需要等级 > Q_主角.角色属性.等级)then
				道具信息 = 道具信息 .. string.format("#<白>#<红>Lv%d以上可以使用",Q_游戏道具组[道具ID].需要等级 )
			else
				道具信息 = 道具信息 .. string.format("#<白>Lv%d以上可以使用",Q_游戏道具组[道具ID].需要等级 )
			end
			--道具信息 = 道具信息 .. string.format("#<白>Lv%d以上可以使用#<白>",Q_游戏道具组[道具ID].需要等级 )
		else
			道具信息 = 道具信息 .."#<白>"
			换行_A = true
		end

		if (Q_游戏道具组[道具ID].武器物理技能冷却时间 ~= 0  ) then
			道具信息 = 道具信息 .. string.format("#<IL>『使用效果』#<IL> 恢复HP%d点",Q_游戏道具组[道具ID].武器物理技能冷却时间 )
		end

		if (Q_游戏道具组[道具ID].武器魔法技能MP ~= 0  ) then
			道具信息 = 道具信息 .. string.format("#<IL>『使用效果』#<IL> 恢复MP%d点",Q_游戏道具组[道具ID].武器魔法技能MP )
		end

	elseif (Q_游戏道具组[道具ID].总类 == "材料") then  --材料数据显示设置

		if (Q_游戏道具组[道具ID].说明 ~= "0") then

			道具信息 = 道具信息 .. string.format("#<IL>#<IL>  %s",Q_游戏道具组[道具ID].说明)
		end

		return 道具信息

	else  --以下为武器数据显示设置

		if (Q_游戏道具组[道具ID].武器物理技能MP ~= 0  ) then
			if ( Q_游戏道具组[道具ID].武器物理技能MP < 0) then
				道具信息 = 道具信息 .. string.format("#<白>武器物理技能: MP%d%%",Q_游戏道具组[道具ID].武器物理技能MP*100 )
			else
				道具信息 = 道具信息 .. string.format("#<白>武器物理技能: MP+%d%%",Q_游戏道具组[道具ID].武器物理技能MP*100 )
			end
		end

		if (Q_游戏道具组[道具ID].武器物理技能冷却时间 ~= 0 ) then
			if ( Q_游戏道具组[道具ID].武器物理技能冷却时间 < 0) then
				道具信息 = 道具信息 .. string.format(" 冷却时间%d%%",Q_游戏道具组[道具ID].武器物理技能冷却时间*100 )
			else
				道具信息 = 道具信息 .. string.format(" 冷却时间+%d%%",Q_游戏道具组[道具ID].武器物理技能冷却时间*100 )
			end
		end

		if (Q_游戏道具组[道具ID].武器魔法技能MP ~= 0 ) then
			if ( Q_游戏道具组[道具ID].武器魔法技能MP < 0) then
				道具信息 = 道具信息 .. string.format("#<白>武器魔法技能: MP%d%%",Q_游戏道具组[道具ID].武器魔法技能MP*100 )
			else
				道具信息 = 道具信息 .. string.format("#<白>武器魔法技能: MP+%d%%",Q_游戏道具组[道具ID].武器魔法技能MP*100 )
			end
		end

		if (Q_游戏道具组[道具ID].武器魔法技能冷却时间 ~= 0 ) then
			if ( Q_游戏道具组[道具ID].武器魔法技能冷却时间 < 0) then
				道具信息 = 道具信息 .. string.format(" 冷却时间%d%%",Q_游戏道具组[道具ID].武器魔法技能冷却时间*100 )
			else
				道具信息 = 道具信息 .. string.format(" 冷却时间+%d%%",Q_游戏道具组[道具ID].武器魔法技能冷却时间*100 )
			end
		end

		if (Q_游戏道具组[道具ID].耐久度 ~=0) then
			道具信息 = 道具信息 .. string.format("#<白>耐久度 %d/%d",Q_游戏道具组[道具ID].耐久度,Q_游戏道具组[道具ID].耐久度 )
		end


		if (Q_游戏道具组[道具ID].需要等级 ~=0) then
			if(Q_游戏道具组[道具ID].需要等级 > Q_主角.角色属性.等级)then
				道具信息 = 道具信息 .. string.format("#<白>#<红>Lv%d以上可以使用",Q_游戏道具组[道具ID].需要等级 )
			else
				道具信息 = 道具信息 .. string.format("#<白>Lv%d以上可以使用",Q_游戏道具组[道具ID].需要等级 )
			end
		else
			道具信息 = 道具信息 .."#<白>"
			换行_A = true
		end

		if (Q_游戏道具组[道具ID].限制职业~="0") then

			if (Q_游戏道具组[道具ID].限制职业 == Q_主角.职业) then
				道具信息 = 道具信息 .. string.format("#<白>#<白>%s可以使用",Q_游戏道具组[道具ID].限制职业 )
			else
				道具信息 = 道具信息 .. string.format("#<白>#<红>%s可以使用",Q_游戏道具组[道具ID].限制职业 )
			end

		end

		if (Q_游戏道具组[道具ID].物理攻击力 ~= 0) then
			if (换行_A == false  ) then
				道具信息 = 道具信息 .. "#<IB>"
				换行_A = true
			end
			if ( Q_游戏道具组[道具ID].物理攻击力 < 0) then
				道具信息 = 道具信息 .. string.format("#<白>物理攻击力 -%d",Q_游戏道具组[道具ID].物理攻击力)
			else
				道具信息 = 道具信息 .. string.format("#<白>物理攻击力 +%d",Q_游戏道具组[道具ID].物理攻击力)
			end
		end

		if (Q_游戏道具组[道具ID].魔法攻击力 ~= 0) then
			if (换行_A == false  ) then
				道具信息 = 道具信息 .. "#<IB>"
				换行_A = true
			end

			if ( Q_游戏道具组[道具ID].魔法攻击力 < 0) then
				道具信息 = 道具信息 .. string.format("#<白>魔法攻击力 -%d",Q_游戏道具组[道具ID].魔法攻击力)
			else
				道具信息 = 道具信息 .. string.format("#<白>魔法攻击力 +%d",Q_游戏道具组[道具ID].魔法攻击力)
			end
		end

		if (Q_游戏道具组[道具ID].物理防御力 ~= 0) then
			if (换行_A == false  ) then
				道具信息 = 道具信息 .. "#<IB>"
				换行_A = true
			end
			if ( Q_游戏道具组[道具ID].魔法攻击力 < 0) then
				道具信息 = 道具信息 .. string.format("#<白>物理防御力 -%d",Q_游戏道具组[道具ID].物理防御力)
			else
				道具信息 = 道具信息 .. string.format("#<白>物理防御力 +%d",Q_游戏道具组[道具ID].物理防御力)
			end
		end

		if (Q_游戏道具组[道具ID].魔法防御力 ~= 0) then
			if (换行_A == false  ) then
				道具信息 = 道具信息 .. "#<IB>"
				换行_A = true
			end
			if ( Q_游戏道具组[道具ID].魔法攻击力 < 0) then
				道具信息 = 道具信息 .. string.format("#<白>魔法防御力 -%d",Q_游戏道具组[道具ID].魔法防御力)
			else
				道具信息 = 道具信息 .. string.format("#<白>魔法防御力 +%d",Q_游戏道具组[道具ID].魔法防御力)
			end

		end

		if (Q_游戏道具组[道具ID].力量 ~= 0) then
			道具信息 = 道具信息 .. string.format("#<白>力量 +%d",Q_游戏道具组[道具ID].力量)
		end

		if (Q_游戏道具组[道具ID].智力 ~= 0) then
			道具信息 = 道具信息 .. string.format("#<白>智力 +%d",Q_游戏道具组[道具ID].智力)
		end

		if (Q_游戏道具组[道具ID].体力 ~= 0) then
			道具信息 = 道具信息 .. string.format("#<白>体力 +%d",Q_游戏道具组[道具ID].体力)
		end

		if (Q_游戏道具组[道具ID].精神 ~= 0) then
			道具信息 = 道具信息 .. string.format("#<白>精神 +%d",Q_游戏道具组[道具ID].精神)
		end


		if (附加属性位置 ~= nil ) then
			if (附加属性位置 == 101 and Q_游戏道具组[道具ID].子类 == Q_主角.防具天赋精通  ) then  -- 头肩

				if (Q_主角.防具天赋精通 == "重甲") then
					Q_游戏道具组[道具ID].物理防御精通_附加 = Q_游戏道具组[道具ID].需要等级 * 4
					道具信息 = 道具信息 .. string.format("#<白>#<白>[重甲精通]#<白> 物理防御 +%d",Q_游戏道具组[道具ID].需要等级 * 4)
					换行 = true

				elseif (Q_主角.防具天赋精通 == "皮甲") then
					道具信息 = 道具信息 .. string.format("#<白>#<白>[皮甲精通]#<白> 攻击速度 +%d%%#<白> 物理暴击率 +%d%%",4,2)
					换行 = true
				end

			elseif (附加属性位置 == 102 and Q_游戏道具组[道具ID].子类 == Q_主角.防具天赋精通  ) then  -- 上衣
				if (Q_主角.防具天赋精通 == "重甲") then
					Q_游戏道具组[道具ID].物理防御精通_附加 = Q_游戏道具组[道具ID].需要等级 * 6
					道具信息 = 道具信息 .. string.format("#<白>#<白>[重甲精通]#<白> 物理防御 +%d",Q_游戏道具组[道具ID].需要等级 * 6)
					换行 = true
				elseif (Q_主角.防具天赋精通 == "皮甲") then
					道具信息 = 道具信息 .. string.format("#<白>#<白>[皮甲精通]#<白> 攻击速度 +%d%%#<白> 物理暴击率 +%d%%",6,3)
					换行 = true
				end

			elseif (附加属性位置 == 103 and Q_游戏道具组[道具ID].子类 == Q_主角.防具天赋精通  ) then  -- 下装
				if (Q_主角.防具天赋精通 == "重甲") then
					Q_游戏道具组[道具ID].物理防御精通_附加 = Q_游戏道具组[道具ID].需要等级 * 5
					道具信息 = 道具信息 .. string.format("#<白>#<白>[重甲精通]#<白> 物理防御 +%d",Q_游戏道具组[道具ID].需要等级 * 5)
					换行 = true
				elseif (Q_主角.防具天赋精通 == "皮甲") then
					道具信息 = 道具信息 .. string.format("#<白>#<白>[皮甲精通]#<白> 攻击速度 +%d%%#<白> 物理暴击率 +%d%%",5,3)
					换行 = true
				end

			elseif (附加属性位置 == 104 and Q_游戏道具组[道具ID].子类 == Q_主角.防具天赋精通  ) then  -- 鞋
				if (Q_主角.防具天赋精通 == "重甲") then
					Q_游戏道具组[道具ID].物理防御精通_附加 = Q_游戏道具组[道具ID].需要等级 * 3
					道具信息 = 道具信息 .. string.format("#<白>#<白>[重甲精通]#<白> 物理防御 +%d",Q_游戏道具组[道具ID].需要等级 * 3)
					换行 = true
				elseif (Q_主角.防具天赋精通 == "皮甲") then
					道具信息 = 道具信息 .. string.format("#<白>#<白>[皮甲精通]#<白> 攻击速度 +%d%%#<白> 物理暴击率 +%d%%",3,2)
					换行 = true
				end

			elseif (附加属性位置 == 105 and Q_游戏道具组[道具ID].子类 == Q_主角.防具天赋精通  ) then  -- 腰带
				if (Q_主角.防具天赋精通 == "重甲") then
					Q_游戏道具组[道具ID].物理防御精通_附加 = Q_游戏道具组[道具ID].需要等级 * 2
					道具信息 = 道具信息 .. string.format("#<白>#<白>[重甲精通]#<白> 物理防御 +%d",Q_游戏道具组[道具ID].需要等级 * 2)
					换行 = true
				elseif (Q_主角.防具天赋精通 == "皮甲") then
					道具信息 = 道具信息 .. string.format("#<白>#<白>[皮甲精通]#<白> 攻击速度 +%d%%#<白> 物理暴击率 +%d%%",2,1)
					换行 = true
				end


			end
		end
	end


	if (Q_游戏道具组[道具ID].移动速度 ~= 0) then
		if (换行 == false  ) then
			道具信息 = 道具信息 .. "#<IL>"
			换行 = true
		end
		道具信息 = 道具信息 .. string.format("#<IL>移动速度 +%d%%",Q_游戏道具组[道具ID].移动速度*100)
		换行 = true
	end

	if (Q_游戏道具组[道具ID].命中率 ~= 0) then
		if (换行 == false  ) then
			道具信息 = 道具信息 .. "#<IL>"
			换行 = true
		end

		if ( Q_游戏道具组[道具ID].命中率 < 0) then
			道具信息 = 道具信息 .. string.format("#<IA>命中率 %d%%",Q_游戏道具组[道具ID].命中率*100)
		else
			道具信息 = 道具信息 .. string.format("#<IL>命中率 +%d%%",Q_游戏道具组[道具ID].命中率*100)
		end

	end

	if (Q_游戏道具组[道具ID].物理暴击率 ~= 0) then
		if (换行 == false  ) then
			道具信息 = 道具信息 .. "#<IL>"
			换行 = true
		end
		道具信息 = 道具信息 .. string.format("#<IL>物理暴击率 +%d%%",Q_游戏道具组[道具ID].物理暴击率*100)
	end

	if (Q_游戏道具组[道具ID].魔法暴击率 ~= 0) then
		if (换行 == false  ) then
			道具信息 = 道具信息 .. "#<IL>"
			换行 = true
		end
		道具信息 = 道具信息 .. string.format("#<IL>魔法暴击率 +%d%%",Q_游戏道具组[道具ID].魔法暴击率*100)
	end

	if (Q_游戏道具组[道具ID].施放速度 ~= 0) then
		if (换行 == false  ) then
			道具信息 = 道具信息 .. "#<IL>"
			换行 = true
		end
		if ( Q_游戏道具组[道具ID].施放速度 < 0) then
			道具信息 = 道具信息 .. string.format("#<IA>施放速度 %d%%",Q_游戏道具组[道具ID].施放速度*100)
		else
			道具信息 = 道具信息 .. string.format("#<IL>施放速度 +%d%%",Q_游戏道具组[道具ID].施放速度*100)
		end

	end

	if (Q_游戏道具组[道具ID].回避率 ~= 0) then
		if (换行 == false  ) then
			道具信息 = 道具信息 .. "#<IL>"
			换行 = true
		end
		道具信息 = 道具信息 .. string.format("#<IL>回避率 +%d%%",Q_游戏道具组[道具ID].回避率*100)
	end

	if (Q_游戏道具组[道具ID].耐久度加成 ~= 0) then
		if (换行 == false  ) then
			道具信息 = 道具信息 .. "#<IL>"
			换行 = true
		end
		道具信息 = 道具信息 .. string.format("#<IL>耐久度 +%d",Q_游戏道具组[道具ID].耐久度加成)
	end

	if (Q_游戏道具组[道具ID].HPMAX ~= 0) then
		if (换行 == false  ) then
			道具信息 = 道具信息 .. "#<IL>"
			换行 = true
		end
		道具信息 = 道具信息 .. string.format("#<IL>HPMAX +%d",Q_游戏道具组[道具ID].HPMAX)
	end

	if (Q_游戏道具组[道具ID].MPMAX ~= 0) then
		if (换行 == false  ) then
			道具信息 = 道具信息 .. "#<IL>"
			换行 = true
		end
		道具信息 = 道具信息 .. string.format("#<IL>MPMAX +%d",Q_游戏道具组[道具ID].MPMAX)
	end

	if (Q_游戏道具组[道具ID].每分钟恢复HP ~= 0) then
		if (换行 == false  ) then
			道具信息 = 道具信息 .. "#<IL>"
			换行 = true
		end
		道具信息 = 道具信息 .. string.format("#<IL>每分钟恢复HP +%d",Q_游戏道具组[道具ID].每分钟恢复HP)
	end

	if (Q_游戏道具组[道具ID].每分钟恢复MP ~= 0) then
		if (换行 == false  ) then
			道具信息 = 道具信息 .. "#<IL>"
			换行 = true
		end
		道具信息 = 道具信息 .. string.format("#<IL>每分钟恢复MP +%d",Q_游戏道具组[道具ID].每分钟恢复MP)
	end

	if (Q_游戏道具组[道具ID].负重上线 ~= 0) then
		if (换行 == false  ) then
			道具信息 = 道具信息 .. "#<IL>"
			换行 = true
		end
		道具信息 = 道具信息 .. string.format("#<IL>物品栏负重上限 +%dkg",Q_游戏道具组[道具ID].负重上线)
	end

	if (Q_游戏道具组[道具ID].说明 ~= "0") then
		if (换行 == false  and  Q_游戏道具组[道具ID].分类 ~= "饰品") then
			道具信息 = 道具信息 .. "#<IL>"
			换行 = true
		end
		道具信息 = 道具信息 .. string.format("#<IH>#<IH>   %s",Q_游戏道具组[道具ID].说明)
	end

	return 道具信息

end

--===============================================================================
-- ■ 格式化文字()
--===============================================================================
function 格式化文字 (_文字,内容,行距,类型)

	local 多彩文字 = {}
	local 多彩文字组 = {}
	local 颜色值 = 颜色_白
	local 总宽 = 0
	local 总高 = 0
	local 最后文本 = ""
	local _文字高度 = _文字:取高度("A")
	if(类型 == "物品")then
		_文字高度2 = _文字:取高度("A") / 1.5
	end

	内容 = string.gsub(内容, "	","")  -- 将TAB符替换掉

      	if( 内容 ~= ""  ) then

			local _按行分割组 = 分割文本(内容, "#")

				if (table.getn(_按行分割组)> 0 ) then

					for n=1, table.getn(_按行分割组) do

						local 再分割文本组 = 分割文本(_按行分割组[n], "<")

							if(table.getn(再分割文本组)>1) then

								for j=1, table.getn(再分割文本组) do

									local  临时_偏移 = 0

									for s_n=1, j-2 do
										临时_偏移  = 临时_偏移 + _文字:取宽度(再分割文本组[s_n] )
									end

									if (string.find(再分割文本组[j],"红>") == 1 ) then
										颜色值 = ARGB(255,255,0,0)
									elseif (string.find(再分割文本组[j],"黄>") == 1 ) then
										颜色值 = ARGB(255,255,255,0)
									elseif (string.find(再分割文本组[j],"蓝>") == 1 ) then
										颜色值 = ARGB(255,30,144,255)
									elseif (string.find(再分割文本组[j],"淡>") == 1 ) then
										颜色值 = ARGB(128,255,255,255)
									elseif (string.find(再分割文本组[j],"灰>") == 1 ) then
										颜色值 = -922746881
									elseif (string.find(再分割文本组[j],"菊>") == 1 ) then
										颜色值 = -2952
									elseif (string.find(再分割文本组[j],"暗>") == 1 ) then
										颜色值 =-7499363
									elseif (string.find(再分割文本组[j],"白>") == 1 ) then --普通
										颜色值 = ARGB(255,255,255,255)
									elseif (string.find(再分割文本组[j],"青>") == 1 ) then --高级
										颜色值 =-9906707
									elseif (string.find(再分割文本组[j],"紫>") == 1 ) then --稀有
										颜色值 = ARGB(255,169,118,226)
									elseif (string.find(再分割文本组[j],"粉>") == 1 ) then --神器
										颜色值 = ARGB(255,206,28,198)
									elseif (string.find(再分割文本组[j],"赤>") == 1 ) then  --勇者
										颜色值 = ARGB(255,255,102,102)
									elseif (string.find(再分割文本组[j],"橙>") == 1 ) then  --传说
										颜色值 = ARGB(255,255,120,0)
									elseif (string.find(再分割文本组[j],"金>") == 1 ) then  --史诗
										颜色值 = ARGB(255,239,176,45)
									elseif (string.find(再分割文本组[j],"HC>") == 1 ) then --淡棕
										颜色值 =-1784166
									elseif (string.find(再分割文本组[j],"IL>") == 1 ) then  --青色
										颜色值 =-9906707
									elseif (string.find(再分割文本组[j],"IB>") == 1 ) then  --白色
										颜色值 =-1
									elseif (string.find(再分割文本组[j],"IH>") == 1 ) then  --暗色
										颜色值 =-6908266
									elseif (string.find(再分割文本组[j],"IC>") == 1 ) then  --橙色
										颜色值 =-2182565
									elseif (string.find(再分割文本组[j],"IZ>") == 1 ) then  --紫色
										颜色值 =-5018625
									elseif (string.find(再分割文本组[j],"IA>") == 1 ) then  --浅紫
										颜色值 =-5271636
									elseif (string.find(再分割文本组[j],"JH>") == 1 ) then  --灰色
										颜色值 =-3750200
									elseif (string.find(再分割文本组[j],"JA>") == 1 ) then  --灰白
										颜色值 =-1317140
									elseif (string.find(再分割文本组[j],"JL>") == 1 ) then  --青色
										颜色值 =-9255189
									end
									再分割文本组[j] = string.sub(再分割文本组[j], 4)
									if(类型 == "物品")then
									多彩文字 =
									{
										内容 = 再分割文本组[j],
										颜色 = 颜色值,
										位置 = {x=临时_偏移+ _文字:取宽度(再分割文本组[j-1]),y= (n-1)*5 + (n-1) * _文字高度2},
										当前计次 = 0,
										当前文本 = "",
										字符组 =  分割为字符组(再分割文本组[j])
									}
								else
									多彩文字 =
									{
										内容 = 再分割文本组[j],
										颜色 = 颜色值,
										位置 = {x=临时_偏移+ _文字:取宽度(再分割文本组[j-1]),y= (n-1)*5 + (n-1) * _文字高度},
										当前计次 = 0,
										当前文本 = "",
										字符组 =  分割为字符组(再分割文本组[j])
									}
								end

									最后文本 = 最后文本 .. 再分割文本组[j].."\n"
									table.insert(多彩文字组,多彩文字)
								end
							else
								多彩文字 =
								{
									内容 = _按行分割组[n],
									颜色 =颜色_白,
									位置 = {x=0,y= (n-1) * 行距 + (n-1) * _文字高度},
									当前计次 = 0,
									当前文本 = "",
									字符组 =  分割为字符组(_按行分割组[n])
								}
								最后文本 = 最后文本 .. 再分割文本组[n] .."\n"
								table.insert(多彩文字组,多彩文字)
							end

						end
					else
						多彩文字 =
						{
							内容 = 内容,
							颜色 =颜色_白,
							位置 = {x=0,y= 0},
							当前计次 = 0,
							当前文本 = "",
							字符组 =  分割为字符组(内容)
						}
						最后文本 = 最后文本 .. 内容
						table.insert(多彩文字组,多彩文字)
					end
		--获取最长的行
		local 文字行宽度= {}
		local f =分割文本(最后文本,"\n")
		for i=1,#f do
			if f[i]~="" then
			    table.insert(文字行宽度,_文字:取宽度(f[i]))
			end
		end
		table.sort(文字行宽度,function(a,b)return a>b end)--]]

		总宽 = 文字行宽度[1]
		总高 = table.getn(_按行分割组) * (_文字高度 + 行距)

		return 多彩文字组,总宽,总高
      end
end

--=============================================================================--
-- ■ 显示风格框
--=============================================================================--
function 显示风格框(x,y,宽度,高度,透明度,类型)

	if(类型 == 7)then

		--[[风格提示_左上精灵_7:置中心点(取整_(标签宽度 / 2), 0)
		风格提示_左边精灵_7:置中心点(取整_(标签宽度 / 2), 0)
		风格提示_左下精灵_7:置中心点(取整_(标签宽度 / 2), 0)
		风格提示_上边精灵_7:置中心点(取整_(标签宽度 / 2), 0)
		风格提示_下边精灵_7:置中心点(取整_(标签宽度 / 2), 0)
		风格提示_右上精灵_7:置中心点(取整_(标签宽度 / 2), 0)
		风格提示_右边精灵_7:置中心点(取整_(标签宽度 / 2), 0)
		风格提示_右下精灵_7:置中心点(取整_(标签宽度 / 2), 0)
		风格提示_填充精灵_7:置中心点(取整_(标签宽度 / 2), 0)

		风格提示_左上精灵_7:置颜色(ARGB(透明度,255,255,255))
		风格提示_左边精灵_7:置颜色(ARGB(透明度,255,255,255))
		风格提示_左下精灵_7:置颜色(ARGB(透明度,255,255,255))
		风格提示_上边精灵_7:置颜色(ARGB(透明度,255,255,255))
		风格提示_下边精灵_7:置颜色(ARGB(透明度,255,255,255))
		风格提示_右上精灵_7:置颜色(ARGB(透明度,255,255,255))
		风格提示_右边精灵_7:置颜色(ARGB(透明度,255,255,255))
		风格提示_右下精灵_7:置颜色(ARGB(透明度,255,255,255))
		风格提示_填充精灵_7:置颜色(ARGB(透明度,255,255,255))


		风格提示_左上精灵_7:显示 (x, y)
		风格提示_左边精灵_7:置显示区域 (0, 0, 8, 高度)
		风格提示_左边精灵_7:显示 (x, y + 8)
		风格提示_左下精灵_7:显示 (x, y + 8 + 高度)
		风格提示_上边精灵_7:置显示区域 (0, 0, 宽度, 8)
		风格提示_上边精灵_7:显示 (x + 8, y)
		风格提示_下边精灵_7:置显示区域 (0, 0, 宽度, 8)
		风格提示_下边精灵_7:显示 (x +8, y + 8 + 高度)
		风格提示_右上精灵_7:显示 (x + 8 + 宽度, y)
		风格提示_右边精灵_7:置显示区域 (0, 0, 8, 高度)
		风格提示_右边精灵_7:显示 (x + 8 + 宽度, y + 8)
		风格提示_右下精灵_7:显示 (x + 8 + 宽度, y + 8 + 高度)
		风格提示_填充精灵_7:置显示区域 (0, 0, 宽度, 高度)
		风格提示_填充精灵_7:显示 (x + 8, y + 8)--]]

	elseif(类型 == 8)then

		--[[风格提示_左上精灵_8:置中心点(取整_(标签宽度 / 2), 0)
		风格提示_左边精灵_8:置中心点(取整_(标签宽度 / 2), 0)
		风格提示_左下精灵_8:置中心点(取整_(标签宽度 / 2), 0)
		风格提示_上边精灵_8:置中心点(取整_(标签宽度 / 2), 0)
		风格提示_下边精灵_8:置中心点(取整_(标签宽度 / 2), 0)
		风格提示_右上精灵_8:置中心点(取整_(标签宽度 / 2), 0)
		风格提示_右边精灵_8:置中心点(取整_(标签宽度 / 2), 0)
		风格提示_右下精灵_8:置中心点(取整_(标签宽度 / 2), 0)
		风格提示_填充精灵_8:置中心点(取整_(标签宽度 / 2), 0)

		风格提示_左上精灵_8:置颜色(ARGB(透明度,255,255,255))
		风格提示_左边精灵_8:置颜色(ARGB(透明度,255,255,255))
		风格提示_左下精灵_8:置颜色(ARGB(透明度,255,255,255))
		风格提示_上边精灵_8:置颜色(ARGB(透明度,255,255,255))
		风格提示_下边精灵_8:置颜色(ARGB(透明度,255,255,255))
		风格提示_右上精灵_8:置颜色(ARGB(透明度,255,255,255))
		风格提示_右边精灵_8:置颜色(ARGB(透明度,255,255,255))
		风格提示_右下精灵_8:置颜色(ARGB(透明度,255,255,255))
		风格提示_填充精灵_8:置颜色(ARGB(透明度,255,255,255))


		风格提示_左上精灵_8:显示 (x, y)
		风格提示_左边精灵_8:置显示区域 (0, 0, 8, 高度)
		风格提示_左边精灵_8:显示 (x, y + 8)
		风格提示_左下精灵_8:显示 (x, y + 8 + 高度)
		风格提示_上边精灵_8:置显示区域 (0, 0, 宽度, 8)
		风格提示_上边精灵_8:显示 (x + 8, y)
		风格提示_下边精灵_8:置显示区域 (0, 0, 宽度, 8)
		风格提示_下边精灵_8:显示 (x +8, y + 8 + 高度)
		风格提示_右上精灵_8:显示 (x + 8 + 宽度, y)
		风格提示_右边精灵_8:置显示区域 (0, 0, 8, 高度)
		风格提示_右边精灵_8:显示 (x + 8 + 宽度, y + 8)
		风格提示_右下精灵_8:显示 (x + 8 + 宽度, y + 8 + 高度)
		风格提示_填充精灵_8:置显示区域 (0, 0, 宽度, 高度)
		风格提示_填充精灵_8:显示 (x + 8, y + 8)--]]

	end

end

--=============================================================================--
-- ■ 显示风格提示
--=============================================================================--
function 显示风格提示(x,y,风格文字组,宽度,高度,透明度,间距,道具,类型)

	风格提示_文字:置颜色(颜色_白)
	风格提示_文字宽度  =   宽度
	风格提示_文字高度  =   高度

	if (y + 高度 > 600 ) then
		y=   y -((y + 高度) - 600) -20
	end

	if (类型 == nil) then  --默认为1

		风格提示_左上精灵:置颜色(ARGB(透明度,255,255,255))
		风格提示_左边精灵:置颜色(ARGB(透明度,255,255,255))
		风格提示_左下精灵:置颜色(ARGB(透明度,255,255,255))
		风格提示_上边精灵:置颜色(ARGB(透明度,255,255,255))
		风格提示_下边精灵:置颜色(ARGB(透明度,255,255,255))
		风格提示_右上精灵:置颜色(ARGB(透明度,255,255,255))
		风格提示_右边精灵:置颜色(ARGB(透明度,255,255,255))
		风格提示_右下精灵:置颜色(ARGB(透明度,255,255,255))
		风格提示_填充精灵:置颜色(ARGB(透明度,255,255,255))

		风格提示_左上精灵:显示 (x, y)
		风格提示_左边精灵:置区域 (0, 0, 8, 风格提示_文字高度)
		风格提示_左边精灵:显示 (x, y + 8)
		风格提示_左下精灵:显示 (x, y + 8 + 风格提示_文字高度)
		风格提示_上边精灵:置区域 (0, 0, 风格提示_文字宽度, 8)
		风格提示_上边精灵:显示 (x + 8, y)
		风格提示_下边精灵:置区域 (0, 0, 风格提示_文字宽度, 8)
		风格提示_下边精灵:显示 (x +8, y + 8 + 风格提示_文字高度)
		风格提示_右上精灵:显示 (x + 8 + 风格提示_文字宽度, y)
		风格提示_右边精灵:置区域 (0, 0, 8, 风格提示_文字高度)
		风格提示_右边精灵:显示 (x + 8 + 风格提示_文字宽度, y + 8)
		风格提示_右下精灵:显示 (x + 8 + 风格提示_文字宽度, y + 8 + 风格提示_文字高度)
		风格提示_填充精灵:置区域 (0, 0, 风格提示_文字宽度, 风格提示_文字高度)
		风格提示_填充精灵:显示 (x + 8, y + 8)

	elseif(类型 == 2) then

		风格提示_左上精灵_2:置颜色(ARGB(透明度,255,255,255))
		风格提示_左边精灵_2:置颜色(ARGB(透明度,255,255,255))
		风格提示_左下精灵_2:置颜色(ARGB(透明度,255,255,255))
		风格提示_上边精灵_2:置颜色(ARGB(透明度,255,255,255))
		风格提示_下边精灵_2:置颜色(ARGB(透明度,255,255,255))
		风格提示_右上精灵_2:置颜色(ARGB(透明度,255,255,255))
		风格提示_右边精灵_2:置颜色(ARGB(透明度,255,255,255))
		风格提示_右下精灵_2:置颜色(ARGB(透明度,255,255,255))
		风格提示_填充精灵_2:置颜色(ARGB(透明度,255,255,255))


		风格提示_左上精灵_2:显示 (x, y)
		风格提示_左边精灵_2:置区域 (0, 0, 8, 风格提示_文字高度)
		风格提示_左边精灵_2:显示 (x, y + 8)
		风格提示_左下精灵_2:显示 (x, y + 8 + 风格提示_文字高度)
		风格提示_上边精灵_2:置区域 (0, 0, 风格提示_文字宽度, 8)
		风格提示_上边精灵_2:显示 (x + 8, y)
		风格提示_下边精灵_2:置区域 (0, 0, 风格提示_文字宽度, 8)
		风格提示_下边精灵_2:显示 (x +8, y + 8 + 风格提示_文字高度)
		风格提示_右上精灵_2:显示 (x + 8 + 风格提示_文字宽度, y)
		风格提示_右边精灵_2:置区域 (0, 0, 8, 风格提示_文字高度)
		风格提示_右边精灵_2:显示 (x + 8 + 风格提示_文字宽度, y + 8)
		风格提示_右下精灵_2:显示 (x + 8 + 风格提示_文字宽度, y + 8 + 风格提示_文字高度)
		风格提示_填充精灵_2:置区域 (0, 0, 风格提示_文字宽度, 风格提示_文字高度)
		风格提示_填充精灵_2:显示 (x + 8, y + 8)

	elseif(类型 == 3) then --主屏幕UI风格提示

		风格提示_左上精灵_3:置颜色(ARGB(透明度,255,255,255))
		风格提示_左边精灵_3:置颜色(ARGB(透明度,255,255,255))
		风格提示_左下精灵_3:置颜色(ARGB(透明度,255,255,255))
		风格提示_上边精灵_3:置颜色(ARGB(透明度,255,255,255))
		风格提示_下边精灵_3:置颜色(ARGB(透明度,255,255,255))
		风格提示_右上精灵_3:置颜色(ARGB(透明度,255,255,255))
		风格提示_右边精灵_3:置颜色(ARGB(透明度,255,255,255))
		风格提示_右下精灵_3:置颜色(ARGB(透明度,255,255,255))
		风格提示_填充精灵_3:置颜色(ARGB(透明度,255,255,255))

		风格提示_左上精灵_3:显示 (x +3.0, y +3.0)
		风格提示_左边精灵_3:置区域 (0, 0, 风格提示_左边精灵_3:取宽度(), 高度)
		风格提示_左边精灵_3:显示 (x +3.0, y + 风格提示_左上精灵_3:取高度() +3.0)
		风格提示_左下精灵_3:显示 (x +3.0, y + 风格提示_左上精灵_3:取高度() + 高度 +3.0)
		风格提示_上边精灵_3:置区域 (0, 0, 宽度, 风格提示_上边精灵_3:取高度())
		风格提示_上边精灵_3:显示 (x + 风格提示_左上精灵_3:取宽度() +3.0 , y +3.0)
		风格提示_下边精灵_3:置区域 (0, 0, 宽度, 风格提示_下边精灵_3:取高度())
		风格提示_下边精灵_3:显示 (x + 风格提示_左上精灵:取宽度()-0.4  , y + 风格提示_左上精灵:取高度() + 高度-0.4)
		风格提示_右上精灵_3:显示 ( x + 风格提示_左上精灵_3:取宽度() + 宽度 +3.0, y +3.0)
		风格提示_右边精灵_3:置区域 (0, 0,风格提示_右边精灵_3:取宽度(), 高度)
		风格提示_右边精灵_3:显示 (x + 风格提示_左上精灵_3:取宽度() + 宽度 +3.0, y + 风格提示_右上精灵_3:取高度() +3.0)
		风格提示_右下精灵_3:显示 ( x + 风格提示_左上精灵_3:取宽度() +宽度 +3.0, y + 风格提示_左上精灵_3:取高度() + 高度 +3.0)
		风格提示_填充精灵_3:置区域 (0, 0, 宽度, 高度)
		风格提示_填充精灵_3:显示 (x + 风格提示_左边精灵_3:取宽度() +3.0,  y + 风格提示_左上精灵_3:取高度() +3.0)
	end

	if (道具 ~= nil and 道具 == true) then
		引擎.画线(x+8,y+38,x+风格提示_文字宽度+4,y+38,ARGB(80,255,255,255))
	end

	for n=1,table.getn(风格文字组) do
		文字_描边显示(文字,x+8+ 风格文字组[n].位置.x,y + 10+ 风格文字组[n].位置.y,风格文字组[n].内容,风格文字组[n].颜色,颜色_黑)
	end

end

--=============================================================================--
-- ■ 初始化风格提示
--=============================================================================--
function 初始化风格提示()

	风格提示_文字 = 文字
	风格提示_内容 = ""
	风格提示_文字宽度 = 0
	风格提示_文字高度 = 文字高度

	风格提示_上边精灵 = require ("gge精灵类") (Q_目录..[[/Dat/UI/风格框UI/1/上.png]],0,0,8,8)
	风格提示_下边精灵 = require ("gge精灵类") (Q_目录..[[/Dat/UI/风格框UI/1/下.Png]],0,0,8,8)
	风格提示_左边精灵 = require ("gge精灵类") (Q_目录..[[/Dat/UI/风格框UI/1/左.Png]],0,0,8,8)
	风格提示_右边精灵 = require ("gge精灵类") (Q_目录..[[/Dat/UI/风格框UI/1/右.Png]],0,0,8,8)
	风格提示_左上精灵 = require ("gge精灵类") (Q_目录..[[/Dat/UI/风格框UI/1/左上.Png]],0,0,8,8)
	风格提示_左下精灵 = require ("gge精灵类") (Q_目录..[[/Dat/UI/风格框UI/1/左下.Png]],0,0,8,8)
	风格提示_右上精灵 = require ("gge精灵类") (Q_目录..[[/Dat/UI/风格框UI/1/右上.Png]],0,0,8,8)
	风格提示_右下精灵 = require ("gge精灵类") (Q_目录..[[/Dat/UI/风格框UI/1/右下.Png]],0,0,8,8)
	风格提示_填充精灵 = require ("gge精灵类") (Q_目录..[[/Dat/UI/风格框UI/1/填充.Png]],0,0,8,8)

	风格提示_上边精灵_2 = require ("gge精灵类") (Q_目录..[[/Dat/UI/风格框UI/2/上.png]],0,0,8,8)
	风格提示_下边精灵_2 = require ("gge精灵类") (Q_目录..[[/Dat/UI/风格框UI/2/下.Png]],0,0,8,8)
	风格提示_左边精灵_2 = require ("gge精灵类") (Q_目录..[[/Dat/UI/风格框UI/2/左.Png]],0,0,8,8)
	风格提示_右边精灵_2 = require ("gge精灵类") (Q_目录..[[/Dat/UI/风格框UI/2/右.Png]],0,0,8,8)
	风格提示_左上精灵_2 = require ("gge精灵类") (Q_目录..[[/Dat/UI/风格框UI/2/左上.Png]],0,0,8,8)
	风格提示_左下精灵_2 = require ("gge精灵类") (Q_目录..[[/Dat/UI/风格框UI/2/左下.Png]],0,0,8,8)
	风格提示_右上精灵_2 = require ("gge精灵类") (Q_目录..[[/Dat/UI/风格框UI/2/右上.Png]],0,0,8,8)
	风格提示_右下精灵_2 = require ("gge精灵类") (Q_目录..[[/Dat/UI/风格框UI/2/右下.Png]],0,0,8,8)
	风格提示_填充精灵_2 = require ("gge精灵类") (Q_目录..[[/Dat/UI/风格框UI/2/填充.Png]],0,0,8,8)

	风格提示_上边图片_3 = require ("gge纹理类") (Q_目录..[[/Dat/UI/风格框UI/3/2.png]])
	风格提示_下边图片_3 = require ("gge纹理类") (Q_目录..[[/Dat/UI/风格框UI/3/8.Png]])
	风格提示_左边图片_3 = require ("gge纹理类") (Q_目录..[[/Dat/UI/风格框UI/3/4.Png]])
	风格提示_右边图片_3 = require ("gge纹理类") (Q_目录..[[/Dat/UI/风格框UI/3/6.Png]])
	风格提示_左上图片_3 = require ("gge纹理类") (Q_目录..[[/Dat/UI/风格框UI/3/1.Png]])
	风格提示_左下图片_3 = require ("gge纹理类") (Q_目录..[[/Dat/UI/风格框UI/3/7.Png]])
	风格提示_右上图片_3 = require ("gge纹理类") (Q_目录..[[/Dat/UI/风格框UI/3/3.Png]])
	风格提示_右下图片_3 = require ("gge纹理类") (Q_目录..[[/Dat/UI/风格框UI/3/9.Png]])
	风格提示_填充图片_3 = require ("gge纹理类") (Q_目录..[[/Dat/UI/风格框UI/3/5.Png]])

	风格提示_上边精灵_3 = require ("gge精灵类") (风格提示_上边图片_3,0,0,风格提示_上边图片_3:取宽度(), 风格提示_上边图片_3:取高度())
	风格提示_下边精灵_3 = require ("gge精灵类") (风格提示_下边图片_3,0,0,风格提示_下边图片_3:取宽度(), 风格提示_下边图片_3:取高度())
	风格提示_左边精灵_3 = require ("gge精灵类") (风格提示_左边图片_3,0,0,风格提示_左边图片_3:取宽度(), 风格提示_左边图片_3:取高度())
	风格提示_右边精灵_3 = require ("gge精灵类") (风格提示_右边图片_3,0,0,风格提示_右边图片_3:取宽度(), 风格提示_右边图片_3:取高度())

	风格提示_左上精灵_3 = require ("gge精灵类") (风格提示_左上图片_3,0,0,风格提示_左上图片_3:取宽度(), 风格提示_左上图片_3:取高度())
	风格提示_左下精灵_3 = require ("gge精灵类") (风格提示_左下图片_3,0,0,风格提示_左下图片_3:取宽度(), 风格提示_左下图片_3:取高度())
	风格提示_右上精灵_3 = require ("gge精灵类") (风格提示_右上图片_3,0,0,风格提示_右上图片_3:取宽度(), 风格提示_右上图片_3:取高度())
	风格提示_右下精灵_3 = require ("gge精灵类") (风格提示_右下图片_3,0,0,风格提示_右下图片_3:取宽度(), 风格提示_右下图片_3:取高度())

	风格提示_填充精灵_3 = require ("gge精灵类") (风格提示_填充图片_3,0,0,风格提示_填充图片_3:取宽度(), 风格提示_填充图片_3:取高度())

	风格提示_上边图片_7 = require ("gge纹理类") (Q_目录..[[/Dat/UI/风格框UI/捡物默认/上.png]])
	风格提示_下边图片_7 = require ("gge纹理类") (Q_目录..[[/Dat/UI/风格框UI/捡物默认/下.Png]])
	风格提示_左边图片_7 = require ("gge纹理类") (Q_目录..[[/Dat/UI/风格框UI/捡物默认/左.Png]])
	风格提示_右边图片_7 = require ("gge纹理类") (Q_目录..[[/Dat/UI/风格框UI/捡物默认/右.Png]])
	风格提示_左上图片_7 = require ("gge纹理类") (Q_目录..[[/Dat/UI/风格框UI/捡物默认/左上.Png]])
	风格提示_左下图片_7 = require ("gge纹理类") (Q_目录..[[/Dat/UI/风格框UI/捡物默认/左下.Png]])
	风格提示_右上图片_7 = require ("gge纹理类") (Q_目录..[[/Dat/UI/风格框UI/捡物默认/右上.Png]])
	风格提示_右下图片_7 = require ("gge纹理类") (Q_目录..[[/Dat/UI/风格框UI/捡物默认/右下.Png]])
	风格提示_填充图片_7 = require ("gge纹理类") (Q_目录..[[/Dat/UI/风格框UI/捡物默认/填充.Png]])

	风格提示_上边精灵_7 = require ("gge精灵类") (风格提示_上边图片_7,0,0,风格提示_上边图片_7:取宽度(), 风格提示_上边图片_7:取高度())
	风格提示_下边精灵_7 = require ("gge精灵类") (风格提示_下边图片_7,0,0,风格提示_下边图片_7:取宽度(), 风格提示_下边图片_7:取高度())
	风格提示_左边精灵_7 = require ("gge精灵类") (风格提示_左边图片_7,0,0,风格提示_左边图片_7:取宽度(), 风格提示_左边图片_7:取高度())
	风格提示_右边精灵_7 = require ("gge精灵类") (风格提示_右边图片_7,0,0,风格提示_右边图片_7:取宽度(), 风格提示_右边图片_7:取高度())
	风格提示_左上精灵_7 = require ("gge精灵类") (风格提示_左上图片_7,0,0,风格提示_左上图片_7:取宽度(), 风格提示_左上图片_7:取高度())
	风格提示_左下精灵_7 = require ("gge精灵类") (风格提示_左下图片_7,0,0,风格提示_左下图片_7:取宽度(), 风格提示_左下图片_7:取高度())
	风格提示_右上精灵_7 = require ("gge精灵类") (风格提示_右上图片_7,0,0,风格提示_右上图片_7:取宽度(), 风格提示_右上图片_7:取高度())
	风格提示_右下精灵_7 = require ("gge精灵类") (风格提示_右下图片_7,0,0,风格提示_右下图片_7:取宽度(), 风格提示_右下图片_7:取高度())
	风格提示_填充精灵_7 = require ("gge精灵类") (风格提示_填充图片_7,0,0,风格提示_填充图片_7:取宽度(), 风格提示_填充图片_7:取高度())

	风格提示_上边图片_8 = require ("gge纹理类") (Q_目录..[[/Dat/UI/风格框UI/捡物激活/上.png]])
	风格提示_下边图片_8 = require ("gge纹理类") (Q_目录..[[/Dat/UI/风格框UI/捡物激活/下.Png]])
	风格提示_左边图片_8 = require ("gge纹理类") (Q_目录..[[/Dat/UI/风格框UI/捡物激活/左.Png]])
	风格提示_右边图片_8 = require ("gge纹理类") (Q_目录..[[/Dat/UI/风格框UI/捡物激活/右.Png]])

	风格提示_左上图片_8 = require ("gge纹理类") (Q_目录..[[/Dat/UI/风格框UI/捡物激活/左上.Png]])
	风格提示_左下图片_8 = require ("gge纹理类") (Q_目录..[[/Dat/UI/风格框UI/捡物激活/左下.Png]])
	风格提示_右上图片_8 = require ("gge纹理类") (Q_目录..[[/Dat/UI/风格框UI/捡物激活/右上.Png]])
	风格提示_右下图片_8 = require ("gge纹理类") (Q_目录..[[/Dat/UI/风格框UI/捡物激活/右下.Png]])
	风格提示_填充图片_8 = require ("gge纹理类") (Q_目录..[[/Dat/UI/风格框UI/捡物激活/填充.Png]])

	风格提示_上边精灵_8 = require ("gge精灵类") (风格提示_上边图片_8,0,0,风格提示_上边图片_8:取宽度(), 风格提示_上边图片_8:取高度())
	风格提示_下边精灵_8 = require ("gge精灵类") (风格提示_下边图片_8,0,0,风格提示_下边图片_8:取宽度(), 风格提示_下边图片_8:取高度())
	风格提示_左边精灵_8 = require ("gge精灵类") (风格提示_左边图片_8,0,0,风格提示_左边图片_8:取宽度(), 风格提示_左边图片_8:取高度())
	风格提示_右边精灵_8 = require ("gge精灵类") (风格提示_右边图片_8,0,0,风格提示_右边图片_8:取宽度(), 风格提示_右边图片_8:取高度())

	风格提示_左上精灵_8 = require ("gge精灵类") (风格提示_左上图片_8,0,0,风格提示_左上图片_8:取宽度(), 风格提示_左上图片_8:取高度())
	风格提示_左下精灵_8 = require ("gge精灵类") (风格提示_左下图片_8,0,0,风格提示_左下图片_8:取宽度(), 风格提示_左下图片_8:取高度())
	风格提示_右上精灵_8 = require ("gge精灵类") (风格提示_右上图片_8,0,0,风格提示_右上图片_8:取宽度(), 风格提示_右上图片_8:取高度())
	风格提示_右下精灵_8 = require ("gge精灵类") (风格提示_右下图片_8,0,0,风格提示_右下图片_8:取宽度(), 风格提示_右下图片_8:取高度())

	风格提示_填充精灵_8 = require ("gge精灵类") (风格提示_填充图片_8,0,0,风格提示_填充图片_8:取宽度(), 风格提示_填充图片_8:取高度())

end

--=============================================================================--
-- ■ Q_风格框()
--=============================================================================--
function Q_风格框(x, y, 宽度, 高度, 透明度, 风格ID)

	if(风格ID == 1)then
  		上边图片 = require ("gge纹理类")(Q_目录..[[/Dat/UI/风格框UI/4/上.png]])
  		下边图片 = require ("gge纹理类")(Q_目录..[[/Dat/UI/风格框UI/4/下.png]])
  		左边图片 = require ("gge纹理类")(Q_目录..[[/Dat/UI/风格框UI/4/左.png]])
  		右边图片 = require ("gge纹理类")(Q_目录..[[/Dat/UI/风格框UI/4/右.png]])
  		左上图片 = require ("gge纹理类")(Q_目录..[[/Dat/UI/风格框UI/4/左上.png]])
  		左下图片 = require ("gge纹理类")(Q_目录..[[/Dat/UI/风格框UI/4/左下.png]])
  		右上图片 = require ("gge纹理类")(Q_目录..[[/Dat/UI/风格框UI/4/右上.png]])
  		右下图片 = require ("gge纹理类")(Q_目录..[[/Dat/UI/风格框UI/4/右下.png]])
  		填充图片 = require ("gge纹理类")(Q_目录..[[/Dat/UI/风格框UI/4/填充.png]])
  		风格提示组[1] = {
  		上边精灵 = require ("gge精灵类")(上边图片, 0, 0, 上边图片:取宽度(), 上边图片:取高度()),
  		下边精灵 = require ("gge精灵类")(下边图片, 0, 0, 下边图片:取宽度(), 下边图片:取高度()),
  		左边精灵 = require ("gge精灵类")(左边图片, 0, 0, 左边图片:取宽度(), 左边图片:取高度()),
  		右边精灵 = require ("gge精灵类")(右边图片, 0, 0, 右边图片:取宽度(), 右边图片:取高度()),
  		左上精灵 = require ("gge精灵类")(左上图片, 0, 0, 左上图片:取宽度(), 左上图片:取高度()),
  		左下精灵 = require ("gge精灵类")(左下图片, 0, 0, 左下图片:取宽度(), 左下图片:取高度()),
  		右上精灵 = require ("gge精灵类")(右上图片, 0, 0, 右上图片:取宽度(), 右上图片:取高度()),
  		右下精灵 = require ("gge精灵类")(右下图片, 0, 0, 右下图片:取宽度(), 右下图片:取高度()),
  		填充精灵 = require ("gge精灵类")(填充图片, 0, 0, 填充图片:取宽度(), 填充图片:取高度())}
	elseif(风格ID == 2)then
		上边图片 = require ("gge纹理类")(Q_目录..[[/Dat/UI/风格框UI/5/上.png]])
 		下边图片 = require ("gge纹理类")(Q_目录..[[/Dat/UI/风格框UI/5/下.png]])
  		左边图片 = require ("gge纹理类")(Q_目录..[[/Dat/UI/风格框UI/5/左.png]])
  		右边图片 = require ("gge纹理类")(Q_目录..[[/Dat/UI/风格框UI/5/右.png]])
  		左上图片 = require ("gge纹理类")(Q_目录..[[/Dat/UI/风格框UI/5/左上.png]])
  		左下图片 = require ("gge纹理类")(Q_目录..[[/Dat/UI/风格框UI/5/左下.png]])
  		右上图片 = require ("gge纹理类")(Q_目录..[[/Dat/UI/风格框UI/5/右上.png]])
  		右下图片 = require ("gge纹理类")(Q_目录..[[/Dat/UI/风格框UI/5/右下.png]])
  		填充图片 = require ("gge纹理类")(Q_目录..[[/Dat/UI/风格框UI/5/填充.png]])
  		风格提示组[2] = {
  		上边精灵 = require ("gge精灵类")(上边图片, 0, 0, 上边图片:取宽度(), 上边图片:取高度()),
  		下边精灵 = require ("gge精灵类")(下边图片, 0, 0, 下边图片:取宽度(), 下边图片:取高度()),
  		左边精灵 = require ("gge精灵类")(左边图片, 0, 0, 左边图片:取宽度(), 左边图片:取高度()),
  		右边精灵 = require ("gge精灵类")(右边图片, 0, 0, 右边图片:取宽度(), 右边图片:取高度()),
  		左上精灵 = require ("gge精灵类")(左上图片, 0, 0, 左上图片:取宽度(), 左上图片:取高度()),
  		左下精灵 = require ("gge精灵类")(左下图片, 0, 0, 左下图片:取宽度(), 左下图片:取高度()),
  		右上精灵 = require ("gge精灵类")(右上图片, 0, 0, 右上图片:取宽度(), 右上图片:取高度()),
  		右下精灵 = require ("gge精灵类")(右下图片, 0, 0, 右下图片:取宽度(), 右下图片:取高度()),
  		填充精灵 = require ("gge精灵类")(填充图片, 0, 0, 填充图片:取宽度(), 填充图片:取高度())}
	elseif(风格ID == 3)then
		上边图片 = require ("gge纹理类")(Q_目录..[[/Dat/UI/风格框UI/6/上.png]])
  		下边图片 = require ("gge纹理类")(Q_目录..[[/Dat/UI/风格框UI/6/下.png]])
  		左边图片 = require ("gge纹理类")(Q_目录..[[/Dat/UI/风格框UI/6/左.png]])
  		右边图片 = require ("gge纹理类")(Q_目录..[[/Dat/UI/风格框UI/6/右.png]])
  		左上图片 = require ("gge纹理类")(Q_目录..[[/Dat/UI/风格框UI/6/左上.png]])
  		左下图片 = require ("gge纹理类")(Q_目录..[[/Dat/UI/风格框UI/6/左下.png]])
  		右上图片 = require ("gge纹理类")(Q_目录..[[/Dat/UI/风格框UI/6/右上.png]])
  		右下图片 = require ("gge纹理类")(Q_目录..[[/Dat/UI/风格框UI/6/右下.png]])
  		填充图片 = require ("gge纹理类")(Q_目录..[[/Dat/UI/风格框UI/6/填充.png]])
  		风格提示组[3] = {
  		上边精灵 = require ("gge精灵类")(上边图片, 0, 0, 上边图片:取宽度(), 上边图片:取高度()),
  		下边精灵 = require ("gge精灵类")(下边图片, 0, 0, 下边图片:取宽度(), 下边图片:取高度()),
  		左边精灵 = require ("gge精灵类")(左边图片, 0, 0, 左边图片:取宽度(), 左边图片:取高度()),
  		右边精灵 = require ("gge精灵类")(右边图片, 0, 0, 右边图片:取宽度(), 右边图片:取高度()),
  		左上精灵 = require ("gge精灵类")(左上图片, 0, 0, 左上图片:取宽度(), 左上图片:取高度()),
  		左下精灵 = require ("gge精灵类")(左下图片, 0, 0, 左下图片:取宽度(), 左下图片:取高度()),
  		右上精灵 = require ("gge精灵类")(右上图片, 0, 0, 右上图片:取宽度(), 右上图片:取高度()),
  		右下精灵 = require ("gge精灵类")(右下图片, 0, 0, 右下图片:取宽度(), 右下图片:取高度()),
  		填充精灵 = require ("gge精灵类")(填充图片, 0, 0, 填充图片:取宽度(), 填充图片:取高度())}
	end

  风格提示组[风格ID].左上精灵:置颜色( ARGB(透明度, 255, 255, 255))
  风格提示组[风格ID].左边精灵:置颜色( ARGB(透明度, 255, 255, 255))
  风格提示组[风格ID].左下精灵:置颜色( ARGB(透明度, 255, 255, 255))
  风格提示组[风格ID].上边精灵:置颜色( ARGB(透明度, 255, 255, 255))
  风格提示组[风格ID].下边精灵:置颜色( ARGB(透明度, 255, 255, 255))
  风格提示组[风格ID].右上精灵:置颜色( ARGB(透明度, 255, 255, 255))
  风格提示组[风格ID].右边精灵:置颜色( ARGB(透明度, 255, 255, 255))
  风格提示组[风格ID].右下精灵:置颜色( ARGB(透明度, 255, 255, 255))
  风格提示组[风格ID].填充精灵:置颜色( ARGB(透明度, 255, 255, 255))
  风格提示组[风格ID].左上精灵:置颜色( ARGB(透明度, 255, 255, 255))
  风格提示组[风格ID].左边精灵:置颜色( ARGB(透明度, 255, 255, 255))
  风格提示组[风格ID].左下精灵:置颜色( ARGB(透明度, 255, 255, 255))
  风格提示组[风格ID].上边精灵:置颜色( ARGB(透明度, 255, 255, 255))
  风格提示组[风格ID].下边精灵:置颜色( ARGB(透明度, 255, 255, 255))
  风格提示组[风格ID].右上精灵:置颜色( ARGB(透明度, 255, 255, 255))
  风格提示组[风格ID].右边精灵:置颜色( ARGB(透明度, 255, 255, 255))
  风格提示组[风格ID].右下精灵:置颜色( ARGB(透明度, 255, 255, 255))
  风格提示组[风格ID].填充精灵:置颜色( ARGB(透明度, 255, 255, 255))


  风格提示组[风格ID].左上精灵:显示(x, y)
  风格提示组[风格ID].左边精灵:置区域( 0, 0, 风格提示组[风格ID].左边精灵:取宽度(), 高度)
  风格提示组[风格ID].左边精灵:显示( x, y + 风格提示组[风格ID].左上精灵:取高度())
  风格提示组[风格ID].左下精灵:显示( x, y + 风格提示组[风格ID].左上精灵:取高度() + 高度)
  风格提示组[风格ID].上边精灵:置区域(0, 0, 宽度, 风格提示组[风格ID].上边精灵:取高度())
  风格提示组[风格ID].上边精灵:显示( x + 风格提示组[风格ID].左上精灵:取宽度(), y)
  风格提示组[风格ID].下边精灵:置区域(0, 0, 宽度,风格提示组[风格ID].下边精灵:取高度())
  风格提示组[风格ID].下边精灵:显示(x + 风格提示组[风格ID].左下精灵:取宽度(), y + 风格提示组[风格ID].左上精灵:取高度() + 高度)
  风格提示组[风格ID].右上精灵:显示(x + 风格提示组[风格ID].左上精灵:取宽度() + 宽度, y)
  风格提示组[风格ID].右边精灵:置区域(0, 0, 风格提示组[风格ID].右边精灵:取宽度(), 高度)
  风格提示组[风格ID].右边精灵:显示( x + 风格提示组[风格ID].左上精灵:取宽度() + 宽度, y + 风格提示组[风格ID].右上精灵:取高度())
  风格提示组[风格ID].右下精灵:显示( x + 风格提示组[风格ID].左上精灵:取宽度() + 宽度, y + 风格提示组[风格ID].左上精灵:取高度() + 高度)
  风格提示组[风格ID].填充精灵:置区域(0, 0, 宽度, 高度)
  风格提示组[风格ID].填充精灵:显示( x + 风格提示组[风格ID].左边精灵:取宽度(), y + 风格提示组[风格ID].左上精灵:取高度())

end