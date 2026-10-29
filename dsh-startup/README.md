# DSH 启动动画（HTML 复刻版）

DeepSeek Harness 启动动画插件的网页版，单文件自包含，双击即可运行。

## 直接运行

**双击 `index.html`** 即可在浏览器中打开（无需服务器、无需联网）。

- 第一步：点击「授予访问权限」（或按 Enter / Space）
- 第二步：点击「确认身份」
- 之后自动播放：鲸鱼装配 → 十六进制瀑布 → 环形准星 → WELCOME → 光晕揭幕
- 右上角 SKIP 或 Esc 跳过

> 注：浏览器会在首次交互后才允许发声，这是正常的浏览器自动播放策略；点两下按钮就会有真人女声。

## 目录结构

```
index.html          单文件自包含版（含全部 8 个音频 base64 内嵌，双击即跑）
assets/             原始插件自带的 8 个音频素材（可替换/检查）
  line-1~6.mp3      真人女声台词（约 7.8 秒总时长）
  sfx-tick.mp3     咔哒提示音
  sfx-ticks-run.mp3 读取跑马音效
src/
  splash.css       原版插件 CSS（1105 行）
  splash.js        原版插件 JS（1598 行，未改动）
```

## 如何自定义

打开 `index.html`，搜索 `window.__DSH_STARTUP__` 配置块，可改：

- `identity`：身份名称（默认 JOYCE MOORE）
- `identityId`：身份编号（默认 0087）
- `theme`：主题色
- `speed`：速度倍率
- `sound`：是否发声（默认 true）
- `voiceSource`：`'asset'` 用内嵌真人语音，`'tts'` 改浏览器合成
- `sfx`：`'audio'` 用音效，`'synth'` 改合成音

## 复刻自

- 入场动画插件：github.com/bshenhonghong9/dsh-startup-screen
- 本文件按原版 splash.css / splash.js 逐行内联，仅去掉 Windows 桌面端 chromeSync 耦合。
