{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.modules) mkIf;
  inherit (lib.types) str;
  inherit (lib.meta) getExe';

  inherit (config.my) desktop;
  cfg = desktop.rime;
  kernelName = pkgs.stdenv.hostPlatform.parsed.kernel.name;
  fcitx5-remote' = getExe' pkgs.fcitx5 "fcitx5-remote";
in {
  options.my.desktop.rime = {
    enable =
      mkEnableOption "rime"
      // {
        default = desktop.enable;
      };

    dir = mkOption {
      type = str;
      default =
        {
          # /Library/Input\ Methods/Squirrel.app/Contents/SharedSupport
          darwin = "Library/Rime";
          linux = ".local/share/fcitx5/rime";
        }
        .${
          kernelName
        };
    };

    deploy = mkOption {
      type = str;
      default =
        {
          darwin = "'/Library/Input Methods/Squirrel.app/Contents/MacOS/Squirrel' --reload";
          linux = "${fcitx5-remote'} -r";
        }
        .${
          kernelName
        };
    };
  };

  config = mkIf cfg.enable {
    # TODO: refactor this
    home.file = {
      ${cfg.dir} = {
        source = pkgs.rime-ice;
        recursive = true;
      };

      "${cfg.dir}/default.custom.yaml".text = with config.my.keyboard.keys; ''
        patch:
          switcher/hotkeys:
            - Control+grave
          schema_list:
            - schema: luna_pinyin
            - schema: flypy
          recognizer/patterns:
            url1: "^(https?|ftp|file):.*$"
            url2: '^([a-z]+\.)+([a-z]+)?$'
            email: "^[A-Za-z][-_.0-9A-Za-z]*@.*$"
            uppercase: "[A-Z][-_+.'0-9A-Za-z]*$"
          ascii_composer/switch_key:
            Caps_Lock: noop
            Shift_L: noop
            Shift_R: commit_code
            Control_L: noop
            Control_R: noop
          key_binder/bindings:
            - { when: composing, accept: Control+comma, toggle: traditionalization }
            - { when: composing, accept: Control+period, toggle: full_shape }

            - { when: composing, accept: Tab, send: Shift+Right }
            - { when: composing, accept: Shift+Tab, send: Shift+Left }

            - { when: has_menu, accept: Control+${k}, send: Page_Up }
            - { when: has_menu, accept: Control+${j}, send: Page_Down }
            - { when: has_menu, accept: Control+${h}, send: Left }
            - { when: has_menu, accept: Control+${l}, send: Right }
      '';
      "${cfg.dir}/grammar.yaml".source = pkgs.fetchurl {
        url = "https://github.com/lotem/rime-octagram-data/raw/master/grammar.yaml";
        sha256 = "0aa14rvypnja38dm15hpq34xwvf06al6am9hxls6c4683ppyk355";
      };

      "${cfg.dir}/zh-hans-t-essay-bgw.gram".source = pkgs.fetchurl {
        url = "https://github.com/lotem/rime-octagram-data/raw/hans/zh-hans-t-essay-bgw.gram";
        sha256 = "0ygcpbhp00lb5ghi56kpxl1mg52i7hdlrznm2wkdq8g3hjxyxfqi";
      };
      "${cfg.dir}/luna_pinyin.custom.yaml".text = ''
        patch:
          __include: grammar:/hans
          translator/dictionary: rime_ice
      '';
      "${cfg.dir}/squirrel.custom.yaml".text = lib.optionalString pkgs.stdenv.hostPlatform.isDarwin ''
        patch:
          style/color_scheme: purity_of_form_custom
          style/color_scheme_dark: dark_temple
          style/font_point: 18
      '';
      "${cfg.dir}/luna.schema.yaml".text = ''
        # Rime schema
        # encoding: utf-8

        schema:
          schema_id: luna
          name: 朙月拼音·简化字
          version: "0.22"
          author:
            - 佛振 <chen.sst@gmail.com>
          description: |
            朙月拼音，簡化字輸出模式。
          dependencies:
            - easy_en

        switches:
          - name: ascii_mode
            reset: 0
            states: [中, A]
          - name: traditionalization
            reset: 0
            states: [简, 繁]
          - name: full_shape
            states: [半, 全]
          - name: emoji_suggestion
            reset: 1
            states: ["🈚️️\uFE0E", "🈶️️\uFE0F"]

        engine:
          processors:
            - ascii_composer
            - recognizer
            - key_binder
            - speller
            - punctuator
            - selector
            - navigator
            - express_editor
          segmentors:
            - ascii_segmentor
            - matcher
            - abc_segmentor
            - punct_segmentor
            - fallback_segmentor
          translators:
            - punct_translator # 转换标点符号
            - script_translator # 脚本翻译器，用于拼音等基于音节表的输入方案
            - lua_translator@date_translator # 日期、时间、周
            - table_translator@custom_phrase # 自定义词组
            - table_translator@easy_en # 英文输入
          filters:
            - simplifier@emoji_suggestion # 文字转 Emoji
            - simplifier@traditionalize # 简繁转换
            - lua_filter@cn_first
            - lua_filter@auto_capitalize
            - uniquifier

        speller:
          alphabet: zyxwvutsrqponmlkjihgfedcbaZYXWVUTSRQPONMLKJIHGFEDCBA
          delimiter: " '"
          algebra:
            - erase/^xx$/

            # 模糊音定義
            #- derive/^([zcs])h/$1/             # zh, ch, sh => z, c, s
            #- derive/^([zcs])([^h])/$1h$2/     # z, c, s => zh, ch, sh

            # 模糊音定義先於簡拼定義，方可令簡拼支持以上模糊音
            - abbrev/^([a-z]).+$/$1/ # 簡拼（首字母）
            - abbrev/^([zcs]h).+$/$1/ # 簡拼（zh, ch, sh）

            # 以下是一組容錯拼寫，《漢語拼音》方案以前者爲正
            - derive/^([nl])ve$/$1ue/ # nve = nue, lve = lue
            - derive/^([jqxy])u/$1v/ # ju = jv
            - derive/un$/uen/ # gun = guen
            - derive/ui$/uei/ # gui = guei
            - derive/iu$/iou/ # jiu = jiou

            # 自動糾正一些常見的按鍵錯誤
            - derive/([aeiou])ng$/$1gn/ # dagn => dang
            - derive/([dtngkhrzcs])o(u|ng)$/$1o/ # zho => zhong|zhou
            - derive/ong$/on/ # zhonguo => zhong guo
            - derive/ao$/oa/ # hoa => hao
            - derive/([iu])a(o|ng?)$/a$1$2/ # tain => tian

        translator:
          dictionary: cn_dicts
          prism: luna
          preedit_format: # preedit_format 影响到输入框的显示和“Shift+回车”上屏的字符
            - xform/([nl])v/$1ü/ # 显示为 nü lü
            - xform/([nl])ue/$1üe/ # 显示为 nüe lüe
            - xform/([jqxy])v/$1u/ # 显示为 ju qu xu yu
          # 以下 3 行用于八股文语法
          contextual_suggestions: true
          max_homophones: 7
          max_homographs: 7

        __include: common:/
      '';
      "${cfg.dir}/flypy.schema.yaml".text = ''
        # Rime schema
        # encoding: utf-8

        schema:
          schema_id: flypy
          name: 小鹤双拼
          version: "0.18"
          author:
            - double pinyin layout by 鶴
            - Rime schema by 佛振 <chen.sst@gmail.com>
          description: |
            朙月拼音＋小鶴雙拼方案。
          dependencies:
            - easy_en

        switches:
          - name: ascii_mode
            reset: 0
            states: [中, A]
          - name: traditionalization
            reset: 0
            states: [简, 繁]
          - name: full_shape
            states: [半, 全]
          - name: emoji_suggestion
            reset: 1
            states: ["🈚️️\uFE0E", "🈶️️\uFE0F"]

        engine:
          processors:
            - ascii_composer
            - recognizer
            - key_binder
            - speller
            - punctuator
            - selector
            - navigator
            - express_editor
          segmentors:
            - ascii_segmentor
            - matcher
            - abc_segmentor
            - punct_segmentor
            - fallback_segmentor
          translators:
            - punct_translator # 转换标点符号
            - script_translator # 脚本翻译器，用于拼音等基于音节表的输入方案
            - lua_translator@date_translator # 日期、时间、周
            - table_translator@custom_phrase # 自定义词组
            - table_translator@easy_en # 英文输入
          filters:
            - simplifier@emoji_suggestion # 文字转 Emoji
            - simplifier@traditionalize # 简繁转换
            - lua_filter@cn_first
            - lua_filter@auto_capitalize
            - uniquifier

        speller:
          alphabet: zyxwvutsrqponmlkjihgfedcbaZYXWVUTSRQPONMLKJIHGFEDCBA
          delimiter: " '"
          algebra:
            - erase/^xx$/
            - derive/^([jqxy])u$/$1v/
            - derive/^([aoe])([ioun])$/$1$1$2/
            - xform/^([aoe])(ng)?$/$1$1$2/
            - xform/iu$/Q/
            - xform/(.)ei$/$1W/
            - xform/uan$/R/
            - xform/[uv]e$/T/
            - xform/un$/Y/
            - xform/^sh/U/
            - xform/^ch/I/
            - xform/^zh/V/
            - xform/uo$/O/
            - xform/ie$/P/
            - xform/i?ong$/S/
            - xform/ing$|uai$/K/
            - xform/(.)ai$/$1D/
            - xform/(.)en$/$1F/
            - xform/(.)eng$/$1G/
            - xform/[iu]ang$/L/
            - xform/(.)ang$/$1H/
            - xform/ian$/M/
            - xform/(.)an$/$1J/
            - xform/(.)ou$/$1Z/
            - xform/[iu]a$/X/
            - xform/iao$/N/
            - xform/(.)ao$/$1C/
            - xform/ui$/V/
            - xform/in$/B/
            - xlit/QWRTYUIOPSDFGHJKLZXCVBNM/qwrtyuiopsdfghjklzxcvbnm/
            #- abbrev/^(.).+$/$1/

        translator:
          dictionary: cn_dicts
          prism: flypy
          # 以下 3 行用于八股文语法
          contextual_suggestions: true
          max_homophones: 7
          max_homographs: 7

        __include: common:/
      '';
    };
  };
}
