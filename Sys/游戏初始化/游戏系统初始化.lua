--=============================================================================--
-- @作者: 白狐剑仙。
-- @邮箱: 1733450036@qq.com
-- @创建时间:   2017-08-01 12:45:25
-- @最后修改来自: 白狐剑仙。
-- @Last Modified time: 2017-11-21 17:37:15
--=============================================================================--
--=============================================================================--
--■ 游戏初始化()
--=============================================================================--
function 游戏初始化()

	Q_地图配置 = {类型 = "",地面= "草地",背景音乐= "",阴影="阳光"}
	Q_背景音乐名称 = ""

	--落地灰层粒子A图片 =  require("gge纹理类")([[Dat\other\灰尘效果\灰尘A.png]])
	--落地灰层粒子B图片 =  require("gge纹理类")([[Dat\other\灰尘效果\灰尘B.png]])
	--落地灰层粒子C图片 =  require("gge纹理类")([[Dat\other\灰尘效果\灰尘C.png]])


	Q_格子选中效果精灵 = require("gge精灵类")([[Dat\UI\格子选中.png]],0,0,30,30)
	Q_格子选中效果精灵:置混合(混合_颜色乘)
	Q_角色地面光环精灵 = require("gge精灵类") ([[Dat\UI\角色地面光环.png]],0,0,126,42)
	Q_角色地面光环精灵:置混合(混合_颜色乘)

	全局音效初始化()

	Q_打击_特效_管理器 = 扩展_资源管理器.创建([[Dat\PAK\通用特效\通用特效.pak]])
	Q_屏幕_特效_管理器 = 扩展_资源管理器.创建([[Dat\PAK\通用特效\特殊特效.pak]])
	Q_地图_动画_管理器 = 扩展_资源管理器.创建([[Dat\PAK\通用特效\地图特效_旧.pak]])
	Q_资源_NPC_管理器 = 扩展_资源管理器.创建([[Dat\PAK\通用特效\NPC.pak]])




	--Q_信息框 = 信息提示框.创建()

	Q_掉血文字动画 = 扩展_精灵文字A.创建()

	Q_地图 = 扩展_游戏地图.创建()

	Q_主角 = 主角_男鬼剑士.创建(470,450)

	Q_游戏鼠标 = 鼠标类.创建()

	Q_系统 = 系统类.创建()

	Q_屏幕 = 主屏幕类.创建()

	Q_全局CD =
	{
		HP_延时时间 = 0,HP_延时参考 = 0,HP_特效显示 = false,HP_延时特效 = nil,HP_延时进度 = 0,
		MP_延时时间 = 0,MP_延时参考 = 0,MP_特效显示 = false,MP_延时特效 = nil,MP_延时进度 = 0
	}
	Q_全局CD.HP_延时特效 = wfox_pak.创建(Q_屏幕_特效_管理器,13,true)
	Q_全局CD.HP_延时特效:置混合(混合_颜色乘)
	Q_全局CD.MP_延时特效 = wfox_pak.创建(Q_屏幕_特效_管理器,13,true)
	Q_全局CD.MP_延时特效:置混合(混合_颜色乘)

end

--=============================================================================--
--■ 初始化数据系统()
--=============================================================================--
function 初始化数据库系统()

--装扮数据组
	鬼剑士装扮初始化()


--系统特效组
	初始化特效数据()
	初始化单帧特效数据()
	初始化MOBJ特效数据()
	初始化AS特效数据()

--风格提示数据组
	初始化风格提示()

--道具数据组
	初始化技能数据()
	初始化道具数据()
	--初始化NPC数据()

end

--=============================================================================--
--■ 音乐初始化
--=============================================================================--
function 全局音效初始化()

	Q_全局音效 =
	{
		道具_药水_音效 = require("gge音效类")([[Dat\Audio\sond\ico\药水.wav]]),
		道具_食物_音效 = require("gge音效类")([[Dat\Audio\sond\ico\食物.wav]]),
		道具_重物_音效 = require("gge音效类")([[Dat\Audio\sond\ico\重物.wav]]),
		道具_晶石_音效 = require("gge音效类")([[Dat\Audio\sond\ico\晶石.wav]]),
		道具_布皮甲_音效 = require("gge音效类")([[Dat\Audio\sond\ico\布皮甲.wav]]),
		道具_轻甲_音效 = require("gge音效类")([[Dat\Audio\sond\ico\轻甲.wav]]),
		道具_重甲_音效 = require("gge音效类")([[Dat\Audio\sond\ico\重甲.wav]]),

		道具_拿起_音效 = require("gge音效类")([[Dat\Audio\sond\ico\道具拿起.wav]]),
		道具_戒指_音效 = require("gge音效类")([[Dat\Audio\sond\ico\戒指.wav]]),
		道具_项链_音效 = require("gge音效类")([[Dat\Audio\sond\ico\项链.wav]]),
		道具_手镯_音效 = require("gge音效类")([[Dat\Audio\sond\ico\手镯.wav]]),

		道具_钝器_音效 = require("gge音效类")([[Dat\Audio\sond\ico\钝器.ogg]]),
		道具_短剑_音效 = require("gge音效类")([[Dat\Audio\sond\ico\短剑.ogg]]),
		道具_太刀_音效 = require("gge音效类")([[Dat\Audio\sond\ico\太刀.ogg]]),
		道具_巨剑_音效 = require("gge音效类")([[Dat\Audio\sond\ico\巨剑.ogg]]),
		道具_光剑_音效 = require("gge音效类")([[Dat\Audio\sond\ico\光剑.ogg]]),

		HP增加音效  =  require("gge音效类")([[Dat\Audio\sond\通用音效\hp_recovered.wav]]),
		MP增加音效  =  require("gge音效类")([[Dat\Audio\sond\通用音效\mp_recovered.wav]]),
		--命运硬币音效 = require("gge音效类")([[Dat\sond\other\coin_bound.wav]]),
		--开罐子音效  =  require("gge音效类")([[Dat\sond\other\danjin_gamble_jar.wav]]),

		物品掉落音效  =  require("gge音效类")([[Dat\Audio\sond\通用音效\item_drop.wav]]),
		金币掉落音效  =  require("gge音效类")([[Dat\Audio\sond\通用音效\golddrop.wav]]),

		拾取道具音效 =  require("gge音效类")([[Dat\Audio\sond\通用音效\get_item.ogg]]),

	}

	鼠标经过按钮音效 = require("gge音效类")([[Dat\Audio\UI_sound\mouseOver.wav]])
	按钮按下音效 =  require("gge音效类")([[Dat\Audio\UI_sound\click1.wav]])
	窗口打开音效 = require("gge音效类")([[Dat\Audio\UI_sound\winShow.wav]])
	窗口关闭音效 = require("gge音效类")([[Dat\Audio\UI_sound\winClose.wav]])

	地图选择进入音效 = require("gge音效类")([[Dat\Audio\UI_sound\map_select.ogg]])
	地图出现音效 = require("gge音效类")([[Dat\Audio\UI_sound\map_appear.ogg]])

	NPC对话菜单打开音效 =  require("gge音效类")([[Dat\Audio\UI_sound\commandshow.wav]])
	NPC对话菜单选中音效 =  require("gge音效类")([[Dat\Audio\UI_sound\commandselect.wav]])
	NPC对话框翻页音效 = require("gge音效类")([[Dat\Audio\UI_sound\next_page_button.wav]])
	打字音效 = require("gge音效类")([[Dat\Audio\UI_sound\write_char.wav]])


--通用角色音效
	跳跃起跳音效 = require("gge音效类")([[Dat\Audio\character_sound\角色_通用类\pub_landing_01.wav]])
	跳跃落地音效 = require("gge音效类")([[Dat\Audio\character_sound\角色_通用类\pub_landing_02.wav]])

	草地行走音效 =  require("gge音效类")([[Dat\Audio\character_sound\角色_通用类\pub_wrk_01.wav]])
	草地跑动音效 =  require("gge音效类")([[Dat\Audio\character_sound\角色_通用类\pub_run_01.wav]])

	雪地行走音效 = {}
	雪地行走音效[1] = require("gge音效类")([[Dat\Audio\character_sound\角色_通用类\snow_walk_01.ogg]])
	雪地行走音效[2] = require("gge音效类")([[Dat\Audio\character_sound\角色_通用类\snow_walk_02.ogg]])
	雪地行走音效[3] = require("gge音效类")([[Dat\Audio\character_sound\角色_通用类\snow_walk_03.ogg]])

	雪地跑动音效 = {}
	雪地跑动音效[1] = require("gge音效类")([[Dat\Audio\character_sound\角色_通用类\snow_run_01.ogg]])
	雪地跑动音效[2] = require("gge音效类")([[Dat\Audio\character_sound\角色_通用类\snow_run_02.ogg]])
	雪地跑动音效[3] = require("gge音效类")([[Dat\Audio\character_sound\角色_通用类\snow_run_03.ogg]])

--通用技能音效
	暗属性击中音效 =  require("gge音效类")([[Dat\Audio\character_sound\技能音效_通用\暗属性击中.wav]])
	冰属性击中音效 =  require("gge音效类")([[Dat\Audio\character_sound\技能音效_通用\冰属性击中.wav]])
	火属性击中音效 =  require("gge音效类")([[Dat\Audio\character_sound\技能音效_通用\火属性击中.wav]])
	光属性击中音效 =  require("gge音效类")([[Dat\Audio\character_sound\技能音效_通用\光属性击中.wav]])

--通用技能声效
	格挡成功音效 =  require("gge音效类")([[Dat\Audio\character_sound\鬼剑士_男\技能声效\swd_eff_01.wav]])



end
