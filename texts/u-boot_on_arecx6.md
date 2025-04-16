# ArecX6 に u-boot を焼く

## TL;DR:
　結論から言うと JTAG に構う必要は一切ない。 USB-UART アダプタ 1 個あれば `kwboot` で焼ける。

## ArecX6 とは
　ワンセグ 6ch 全録レコーダ。任意の 6ch を24時間連続的に録画する。6 個の USB ワンセグチューナが OpenRD なる EVB を元にした Marvell Kirkwood ボードに積み込まれていて、番組ごとにばらした形で外付けの USB または eSATA のストレージにローテーション記録する。録画した番組はブラウザやスマホアプリから視聴できる。標準ファームではすべて独自実装で自己署名証明書を使って著作権保護もどきを行うためエクスペリエンスは良くない。電源は AC アダプタ駆動 12V 5.5x2.1 センタープラスで、まあ 1A ちょっきりだと足りないかもしらん程度の消費である。

　以下はなんか雰囲気的なリンクである。

  - http://izm.way-nifty.com/robo/2020/01/post-d4a22b.html
  - http://izm.way-nifty.com/robo/2020/01/post-5b846b.html
  - https://koga2020.hatenablog.com/entry/52036160
  - http://linfeslogs.cocolog-nifty.com/blog/2019/08/post-2c221e.html
  - http://blog.fne.jp/2010/09/post-150.html
  - https://bbs.kakaku.com/bbs/K0000654469/
  - http://hg536h2.seesaa.net/article/446669315.html
  - https://itest.5ch.net/mevius/test/read.cgi/avi/1524673464
  - 

## なぜ焼く
　標準ファームは古い Firefox か何か縛りがあったり自己署名証明書のインストールが必須だったりしばしば発熱で録画が止まったりとだるいので書き換えたいが、標準 u-boot と Linux は著作権に配慮して (ARIB 標準に従っているわけではなさそう)コンソールを潰してある。 Linux ユーザランドの方は bash の Shellshock 脆弱性で root とれることが知られているがこの際全部飛ばすことにする。

## false leads
　色々先人がいて JTAG アダプタつないで OpenOCD で焼いたらよいとされているがよい JTAG アダプタがない。Bluepill の CMSIS-DAP ファームだの FT232RL だのやってみたがどっちも壊しただけに終わった。

　以下は後述の方法がより簡単であるためにさして役に立たないリンクである(内容に問題があるわけではない)。

  - https://github.com/RadioOperator/STM32F103C8T6_CMSIS-DAP_SWO/blob/master/build/F103-DAP-SWO-CDC-BLUEPILL-SWD_PB8PB9.hex
  - https://github.com/dirtyjtag/DirtyJTAG/blob/master/docs/install-bluepill.md
  - https://benedicam-te.blogspot.com/2021/01/blue-pill-stm32f103c8t6vcomcmsis-dap.html
  - https://github.com/RadioOperator/STM32F103C8T6_CMSIS-DAP_SWO/blob/master/Doc/Bluepill/Bluepill%20CMSIS-DAP%20Pin-config.txt
  - https://s5suzuki.github.io/posts/urjtag-dirtyjtag-wsl/
  - http://nahitafu.cocolog-nifty.com/nahitafu/2024/01/post-9784e8.html
  - http://nemuisan.blog.bai.ne.jp/?eid=197512
  - http://www.biokids.org/97dd26.html
  - https://openocd.org/doc/html/Flash-Commands.html#nanddriverlist
  
## kwboot
　Marvell Kirkwood 系統の SoC には、昔はやった NAND がぶっ壊れていてもお構いなしマスク ROM 上のブートローダから簡便に次段のブートローダを転送できるやつがあり、そのツール `kwboot` がUbuntuでは `u-boot-tools` に含まれている。 `https://web.archive.org/web/20220517214659/http://ftp.debian.org/debian/dists/stretch/main/installer-armel/current/images/kirkwood/u-boot/openrd-base/u-boot.kwb` を落としてきて `kwboot -b u-boot.kwb -t /dev/ttyUSB0` で転送すると、 RAM 上に u-boot が置かれて走っている状態になる。そのまま任意の端末エミュレータで今度は u-boot を叩き、 `https://www.cyrius.com/debian/kirkwood/openrd/uboot-upgrade/` から "You have to complete three steps in order to install the(...)" 以下を行う。具体的には: 

  1.  FATフォーマットのUSBメモリに `u-boot.kwb` を入れる。
  2.  => `usb start`
  3.  => `usb reset`
  4.  => `fatload usb 0:1 0x0800000 u-boot.kwb`
  5.  => `nand erase 0x0 0x60000`
  6.  => `nand write 0x0800000 0x0 0x60000`
  7.  => `reset`
  8.  => `setenv ethaddr 00:11:22:33:44:55` 
  9.  => `saveenv`
  10. => `reset`

　なお、上手順 5. を実行するまでは恒久的な変更はない、はず、である。Ethernet MAC アドレスは新しい u-boot の書き込みに伴って消えるため再設定が必要である。本体底面を参照、または事前に記録しておくとよい。わすれた場合は、 MAC アドレスは L2 より外に出ないので適当に設定しても構わない。せいぜい宅内で被りがなく頭の 1 バイトの下から 2 ビットを 0b10 とする locally administred unicast address としてあれば十二分である。

　以下は役に立ったリンクである。
  - https://openwrt.org/toh/seagate/goflexnet
  - https://manpages.ubuntu.com/manpages/noble/man1/kwboot.1.html

## u-boot 更新後

　u-boot を更新した後は、ARM 系の GNU/Linux ディストリビューションなどをインストールすることが可能である。詳細についてはまだやってないので省く。

　以下は今後役に立つであろうリンクである。
  - https://qiita.com/yamori813/items/df71b1d0eea037e62bb4
  - https://yu-izumi.hatenablog.com/entry/2019/04/29/213632
  - https://qiita.com/yamori813/items/14e224dc80b3a6c84279
  - https://www.cyrius.com/debian/kirkwood/openrd/
  - https://code.google.com/archive/p/oneseg24/
