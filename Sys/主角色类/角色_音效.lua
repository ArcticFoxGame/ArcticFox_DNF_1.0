--=============================================================================--
-- @作者: 白狐剑仙。
-- @邮箱: 1733450036@qq.com
-- @创建时间:   2017-08-01 12:45:25
-- @最后修改来自: 白狐剑仙。
-- @Last Modified time: 2017-11-12 23:04:18
--=============================================================================--
音效_男鬼剑士  = class()
--=============================================================================--
-- ■ 构造函数
--=============================================================================--
function 音效_男鬼剑士:初始化()

--预先设定统一目录
	local 男鬼剑士通用目录 = Q_目录..[[\Dat\Audio\character_sound\鬼剑士_男]]
--角色专属音效
	self.普攻喊叫音效 = {}
	self.普攻喊叫音效[1] = require("BASS类")(男鬼剑士通用目录..[[\攻击_喊叫类\sm_atk_01.wav]])
	self.普攻喊叫音效[2] = require("BASS类")(男鬼剑士通用目录..[[\攻击_喊叫类\sm_atk_02.wav]])
	self.普攻喊叫音效[3] = require("BASS类")(男鬼剑士通用目录..[[\攻击_喊叫类\sm_atk_03.wav]])

	self.裂波斩下斩喊叫声效 = require("BASS类")(男鬼剑士通用目录..[[\技能声效\yeolpa_down.ogg]])

	self.三段斩喊叫音效 = {}
	self.三段斩喊叫音效[1] = require("BASS类")(男鬼剑士通用目录..[[\攻击_喊叫类\ThreeCut1.ogg]])
	self.三段斩喊叫音效[2] = require("BASS类")(男鬼剑士通用目录..[[\攻击_喊叫类\ThreeCut2.ogg]])
	self.三段斩喊叫音效[3] = require("BASS类")(男鬼剑士通用目录..[[\攻击_喊叫类\ThreeCut3.ogg]])

--钝器
	self.普攻钝器挥舞音效 = {}
	self.普攻钝器挥舞音效[1] = require("BASS类")(男鬼剑士通用目录..[[\武器_钝器类\sticka_01.ogg]])
	self.普攻钝器挥舞音效[2] = require("BASS类")(男鬼剑士通用目录..[[\武器_钝器类\sticka_02.ogg]])
	self.普攻钝器击中音效 = {}
	self.普攻钝器击中音效[1] = require("BASS类")(男鬼剑士通用目录..[[\武器_钝器类\sticka_hit_01.ogg]])
	self.普攻钝器击中音效[2] = require("BASS类")(男鬼剑士通用目录..[[\武器_钝器类\sticka_hit_02.ogg]])
--短剑
	self.普攻短剑挥舞音效 = {}
	self.普攻短剑挥舞音效[1] = require("BASS类")(男鬼剑士通用目录..[[\武器_短剑类\minswda_01.ogg]])
	self.普攻短剑挥舞音效[2] = require("BASS类")(男鬼剑士通用目录..[[\武器_短剑类\minswda_02.ogg]])
	self.普攻短剑挥舞音效[3] = require("BASS类")(男鬼剑士通用目录..[[\武器_短剑类\minswda_03.ogg]])
	self.普攻短剑击中音效 = {}
	self.普攻短剑击中音效[1] = require("BASS类")(男鬼剑士通用目录..[[\武器_短剑类\minswda_hit_01.ogg]])
	self.普攻短剑击中音效[2] = require("BASS类")(男鬼剑士通用目录..[[\武器_短剑类\minswda_hit_02.ogg]])
	self.普攻短剑击中音效[3] = require("BASS类")(男鬼剑士通用目录..[[\武器_短剑类\minswda_hit_03.ogg]])
--太刀
	self.普攻太刀挥舞音效 = {}
	self.普攻太刀挥舞音效[1] = require("BASS类")(男鬼剑士通用目录..[[\武器_太刀类\kata_01.ogg]])
	self.普攻太刀挥舞音效[2] = require("BASS类")(男鬼剑士通用目录..[[\武器_太刀类\kata_02.ogg]])
	self.普攻太刀挥舞音效[3] = require("BASS类")(男鬼剑士通用目录..[[\武器_太刀类\kata_03.ogg]])
	self.普攻太刀击中音效 = {}
	self.普攻太刀击中音效[1] = require("BASS类")(男鬼剑士通用目录..[[\武器_太刀类\kata_hit_01.ogg]])
	self.普攻太刀击中音效[2] = require("BASS类")(男鬼剑士通用目录..[[\武器_太刀类\kata_hit_02.ogg]])
--巨剑
	self.普攻巨剑挥舞音效 = {}
	self.普攻巨剑挥舞音效[1] = require("BASS类")(男鬼剑士通用目录..[[\武器_巨剑类\sqrswda_01.ogg]])
	self.普攻巨剑挥舞音效[2] = require("BASS类")(男鬼剑士通用目录..[[\武器_巨剑类\sqrswda_02.ogg]])
	self.普攻巨剑击中音效 = {}
	self.普攻巨剑击中音效[1] = require("BASS类")(男鬼剑士通用目录..[[\武器_巨剑类\sqrswda_hit_01.ogg]])
	self.普攻巨剑击中音效[2] = require("BASS类")(男鬼剑士通用目录..[[\武器_巨剑类\sqrswda_hit_02.ogg]])
--光剑
	self.普攻光剑挥舞音效 = {}
	self.普攻光剑挥舞音效[1] = require("BASS类")(男鬼剑士通用目录..[[\武器_光剑类\beamswda_01.ogg]])
	self.普攻光剑挥舞音效[2] = require("BASS类")(男鬼剑士通用目录..[[\武器_光剑类\beamswda_02.ogg]])
	self.普攻光剑挥舞音效[3] = require("BASS类")(男鬼剑士通用目录..[[\武器_光剑类\beamswda_03.ogg]])
	self.普攻光剑击中音效 = {}
	self.普攻光剑击中音效[1] = require("BASS类")(男鬼剑士通用目录..[[\武器_光剑类\beamswda_hit_01.ogg]])
	self.普攻光剑击中音效[2] = require("BASS类")(男鬼剑士通用目录..[[\武器_光剑类\beamswda_hit_02.ogg]])


	self.跳跃起跳喊叫音效 = require("BASS类")(男鬼剑士通用目录..[[\跳跃_音效类\sm_jump.wav]])

	self.跳跃攻击喊叫音效 = {}
	self.跳跃攻击喊叫音效[1] = require("BASS类")(男鬼剑士通用目录..[[\跳跃_音效类\sm_jumpatk_01.wav]])
	self.跳跃攻击喊叫音效[2] = require("BASS类")(男鬼剑士通用目录..[[\跳跃_音效类\sm_jumpatk_02.wav]])


	self.被攻击喊叫音效 = {}
	self.被攻击喊叫音效[1] = require("BASS类")(男鬼剑士通用目录..[[\角色_被击类\sm_dmg_01.wav]])
	self.被攻击喊叫音效[2] = require("BASS类")(男鬼剑士通用目录..[[\角色_被击类\sm_dmg_02.wav]])
	self.被攻击喊叫音效[3] = require("BASS类")(男鬼剑士通用目录..[[\角色_被击类\sm_dmg_03.wav]])

	self.死亡音效 = require("BASS类")(男鬼剑士通用目录..[[\sm_die.wav]])

--技能音效
	self.上挑技能音效 = require("BASS类")(男鬼剑士通用目录..[[\技能声效\upper_slash_01.wav]])

	self.连突刺技能音效 = require("BASS类")(男鬼剑士通用目录..[[\技能声效\突刺.wav]])

	self.鬼斩技能喊叫 = {}
	self.鬼斩技能喊叫[1] = require("BASS类")(男鬼剑士通用目录..[[\技能声效\sm_gue_01.wav]])
	self.鬼斩技能喊叫[2] = require("BASS类")(男鬼剑士通用目录..[[\技能声效\sm_gue_02.wav]])

	self.格挡起手音效 =  require("BASS类")(男鬼剑士通用目录..[[\技能声效\swd_eff_05.wav]])

	self.银落冲击下落音效 = require("BASS类")(男鬼剑士通用目录..[[\技能声效\skyraid.ogg]])
	self.银落冲击落地音效 = require("BASS类")(男鬼剑士通用目录..[[\技能声效\spx_crash.wav]])

	self.崩山击落地音效 = require("BASS类")(男鬼剑士通用目录..[[\技能声效\sm_boongsan.ogg]])


	self.裂波斩上斩音效 = require("BASS类")(男鬼剑士通用目录..[[\技能声效\upper_slash_02.ogg]])
	self.裂波斩下斩音效 = require("BASS类")(男鬼剑士通用目录..[[\技能声效\yeolpa_flash.ogg]])
	self.裂波斩旋转音效 = require("BASS类")(男鬼剑士通用目录..[[\技能声效\yeolpa_wind.ogg]])
	self.裂波斩击中音效 = require("BASS类")(男鬼剑士通用目录..[[\技能声效\yeolpa_wind_hit.ogg]])

	self.三段斩一斩音效 = require("BASS类")(男鬼剑士通用目录..[[\技能声效\sandz1.ogg]])
	self.三段斩二斩音效 = require("BASS类")(男鬼剑士通用目录..[[\技能声效\sandz2.ogg]])
	self.三段斩三斩音效 = require("BASS类")(男鬼剑士通用目录..[[\技能声效\sandz3.ogg]])

	self.十字斩喊叫音效 = require("BASS类")(男鬼剑士通用目录..[[\技能声效\slash_down_h.ogg]])
	self.十字斩挑音效 = require("BASS类")(男鬼剑士通用目录..[[\技能声效\slash_down_up.ogg]])
	self.十字斩放音效 = require("BASS类")(男鬼剑士通用目录..[[\技能声效\slash_down_f.ogg]])

	self.十字斩击中A音效 = require("BASS类")(男鬼剑士通用目录..[[\技能声效\slash_down_hit1.ogg]])
	self.十字斩击中B音效 = require("BASS类")(男鬼剑士通用目录..[[\技能声效\slash_down_hit2.ogg]])

	self.波动剑释放音效 = require("BASS类")(男鬼剑士通用目录..[[\技能声效\hadouken.wav]])

	self.波动剑击中音效 = {}
	self.波动剑击中音效[1] = require("BASS类")(男鬼剑士通用目录..[[\技能声效\hadouken_hit1.ogg]])
	self.波动剑击中音效[2] = require("BASS类")(男鬼剑士通用目录..[[\技能声效\hadouken_hit2.ogg]])

	self.月光斩下释放音效 = require("BASS类")(男鬼剑士通用目录..[[\技能声效\moonslash1.ogg]])
	self.月光斩挑释放音效 = require("BASS类")(男鬼剑士通用目录..[[\技能声效\moonslash2.ogg]])
	self.月光斩起释放音效 = require("BASS类")(男鬼剑士通用目录..[[\技能声效\moonslash3.ogg]])


end

--=============================================================================--
-- ■ 销毁
--=============================================================================--
function 音效_男鬼剑士:销毁()

	self.男鬼剑士通用目录 = nil

	self.普攻喊叫音效 = nil

	self.跳跃起跳喊叫音效 = nil
	self.跳跃攻击喊叫音效 = nil
	self.跳跃攻击喊叫音效 = nil

	self.跳跃攻击喊叫音效 = nil

	self.被攻击喊叫音效 = nil

	self.死亡音效 = nil


end




音效_女鬼剑士  = class()

--=============================================================================--
-- ■ 构造函数
--=============================================================================--
function 音效_女鬼剑士:初始化()

--预先设定统一目录
	self.女鬼剑士通用目录 = [[Dat\Audio\character_sound\鬼剑士_女]]

--角色专属音效
	self.普攻喊叫音效 = {}
	self.普攻喊叫音效[1] = require("BASS类")(男鬼剑士通用目录..[[\攻击_喊叫类\sm_atk_01.wav]])
	self.普攻喊叫音效[2] = require("BASS类")(男鬼剑士通用目录..[[\攻击_喊叫类\sm_atk_02.wav]])
	self.普攻喊叫音效[3] = require("BASS类")(男鬼剑士通用目录..[[\攻击_喊叫类\sm_atk_03.wav]])

--钝器
	self.普攻钝器挥舞音效 = {}
	self.普攻钝器挥舞音效[1] = require("BASS类")(男鬼剑士通用目录..[[\武器_钝器类\sticka_01.ogg]])
	self.普攻钝器挥舞音效[2] = require("BASS类")(男鬼剑士通用目录..[[\武器_钝器类\sticka_02.ogg]])
	self.普攻钝器击中音效 = {}
	self.普攻钝器击中音效[1] = require("BASS类")(男鬼剑士通用目录..[[\武器_钝器类\sticka_hit_01.ogg]])
	self.普攻钝器击中音效[2] = require("BASS类")(男鬼剑士通用目录..[[\武器_钝器类\sticka_hit_02.ogg]])
--短剑
	self.普攻短剑挥舞音效 = {}
	self.普攻短剑挥舞音效[1] = require("BASS类")(男鬼剑士通用目录..[[\武器_短剑类\minswda_01.ogg]])
	self.普攻短剑挥舞音效[2] = require("BASS类")(男鬼剑士通用目录..[[\武器_短剑类\minswda_02.ogg]])
	self.普攻短剑挥舞音效[3] = require("BASS类")(男鬼剑士通用目录..[[\武器_短剑类\minswda_03.ogg]])
	self.普攻短剑击中音效 = {}
	self.普攻短剑击中音效[1] = require("BASS类")(男鬼剑士通用目录..[[\武器_短剑类\minswda_hit_01.ogg]])
	self.普攻短剑击中音效[2] = require("BASS类")(男鬼剑士通用目录..[[\武器_短剑类\minswda_hit_02.ogg]])
	self.普攻短剑击中音效[3] = require("BASS类")(男鬼剑士通用目录..[[\武器_短剑类\minswda_hit_03.ogg]])
--太刀
	self.普攻太刀挥舞音效 = {}
	self.普攻太刀挥舞音效[1] = require("BASS类")(男鬼剑士通用目录..[[\武器_太刀类\kata_01.ogg]])
	self.普攻太刀挥舞音效[2] = require("BASS类")(男鬼剑士通用目录..[[\武器_太刀类\kata_02.ogg]])
	self.普攻太刀挥舞音效[3] = require("BASS类")(男鬼剑士通用目录..[[\武器_太刀类\kata_03.ogg]])
	self.普攻太刀击中音效 = {}
	self.普攻太刀击中音效[1] = require("BASS类")(男鬼剑士通用目录..[[\武器_太刀类\kata_hit_01.ogg]])
	self.普攻太刀击中音效[2] = require("BASS类")(男鬼剑士通用目录..[[\武器_太刀类\kata_hit_02.ogg]])
--巨剑
	self.普攻巨剑挥舞音效 = {}
	self.普攻巨剑挥舞音效[1] = require("BASS类")(男鬼剑士通用目录..[[\武器_巨剑类\sqrswda_01.ogg]])
	self.普攻巨剑挥舞音效[2] = require("BASS类")(男鬼剑士通用目录..[[\武器_巨剑类\sqrswda_02.ogg]])
	self.普攻巨剑击中音效 = {}
	self.普攻巨剑击中音效[1] = require("BASS类")(男鬼剑士通用目录..[[\武器_巨剑类\sqrswda_hit_01.ogg]])
	self.普攻巨剑击中音效[2] = require("BASS类")(男鬼剑士通用目录..[[\武器_巨剑类\sqrswda_hit_02.ogg]])
--光剑
	self.普攻光剑挥舞音效 = {}
	self.普攻光剑挥舞音效[1] = require("BASS类")(男鬼剑士通用目录..[[\武器_光剑类\beamswda_01.ogg]])
	self.普攻光剑挥舞音效[2] = require("BASS类")(男鬼剑士通用目录..[[\武器_光剑类\beamswda_02.ogg]])
	self.普攻光剑挥舞音效[3] = require("BASS类")(男鬼剑士通用目录..[[\武器_光剑类\beamswda_03.ogg]])
	self.普攻光剑击中音效 = {}
	self.普攻光剑击中音效[1] = require("BASS类")(男鬼剑士通用目录..[[\武器_光剑类\beamswda_hit_01.ogg]])
	self.普攻光剑击中音效[2] = require("BASS类")(男鬼剑士通用目录..[[\武器_光剑类\beamswda_hit_02.ogg]])


	self.跳跃起跳喊叫音效 = require("BASS类")(男鬼剑士通用目录..[[\跳跃_音效类\sm_jump.wav]])

	self.跳跃攻击喊叫音效 = {}
	self.跳跃攻击喊叫音效[1] = require("BASS类")(男鬼剑士通用目录..[[\跳跃_音效类\sm_jumpatk_01.wav]])
	self.跳跃攻击喊叫音效[2] = require("BASS类")(男鬼剑士通用目录..[[\跳跃_音效类\sm_jumpatk_02.wav]])


	self.被攻击喊叫音效 = {}
	self.被攻击喊叫音效[1] = require("BASS类")(男鬼剑士通用目录..[[\角色_被击类\sm_dmg_01.wav]])
	self.被攻击喊叫音效[2] = require("BASS类")(男鬼剑士通用目录..[[\角色_被击类\sm_dmg_02.wav]])
	self.被攻击喊叫音效[3] = require("BASS类")(男鬼剑士通用目录..[[\角色_被击类\sm_dmg_03.wav]])

	self.死亡音效 = require("BASS类")(男鬼剑士通用目录..[[\sm_die.wav]])

	self.上挑技能声音 = require("BASS类")(男鬼剑士通用目录..[[\技能声效\upper_slash_01.wav]])

	self.鬼斩技能喊叫 = {}
	self.鬼斩技能喊叫[1] = require("BASS类")(男鬼剑士通用目录..[[\技能声效\sm_gue_01.wav]])
	self.鬼斩技能喊叫[2] = require("BASS类")(男鬼剑士通用目录..[[\技能声效\sm_gue_02.wav]])

--通用色色音效
	self.跳跃起跳音效 = require("BASS类")(Q_目录.. [[Dat\Audio\character_sound\角色_通用类\pub_landing_01.wav]])
	self.跳跃落地音效 = require("BASS类")(Q_目录.. [[Dat\Audio\character_sound\角色_通用类\pub_landing_02.wav]])

	self.走路音效 =  require("BASS类")(Q_目录.. [[Dat\Audio\character_sound\角色_通用类\pub_wrk_01.wav]])
	self.跑动音效 =  require("BASS类")(Q_目录.. [[Dat\Audio\character_sound\角色_通用类\pub_run_01.wav]])

end

--=============================================================================--
-- ■ 销毁
--=============================================================================--
function 音效_女鬼剑士:销毁()

	self.女鬼剑士通用目录 = nil

	self.普攻喊叫音效[1]:销毁()
	self.普攻喊叫音效[2]:销毁()
	self.普攻喊叫音效[3]:销毁()

	self.跳跃起跳喊叫音效:销毁()
	self.跳跃攻击喊叫音效[1]:销毁()
	self.跳跃攻击喊叫音效[2]:销毁()

	self.跳跃攻击喊叫音效[1]:销毁()
	self.跳跃攻击喊叫音效[2]:销毁()

	self.被攻击喊叫音效[1]:销毁()
	self.被攻击喊叫音效[2]:销毁()
	self.被攻击喊叫音效[3]:销毁()

	self.死亡音效:销毁()

	self.跳跃起跳音效:销毁()
	self.跳跃落地音效:销毁()

	self.走路音效:销毁()
	self.跑动音效:销毁()

end

