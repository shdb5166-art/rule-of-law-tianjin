# Phigros 网页版

可在浏览器直接运行的Phigros音游网页版本。

## 部署到GitHub Pages

1. 在GitHub新建一个仓库（比如叫`phigros-web`）
2. 把本文件夹**根目录的所有内容**上传到仓库
3. 打开仓库Settings -> Pages
4. Source选择`Deploy from a branch`，分支选`main`，文件夹选`/root`
5. 保存后等1分钟，访问 `https://你的用户名.github.io/phigros-web/` 即可游玩

## 本地运行

```bash
# 进入文件夹，运行本地服务器（注意：直接双击index.html会因浏览器限制无法加载资源）
python -m http.server 8000
# 浏览器打开 http://localhost:8000
```

## 包含内容
- 完整流程：启动页 → 章节选择 → 歌曲列表 → 游戏加载 → 游玩 → 结算
- 设置页：谱面延时、按键缩放、背景亮度、多押辅助、打击音效等
- 校准页：根据声音调整偏移率
- 关于页
- 3个章节共20首歌曲：官方谱面、SP谱面、社区创作
- 每首歌包含曲绘、音频、全难度谱面

## 操作说明
- 鼠标/触屏点击屏幕
- 电脑端滚轮滚动歌曲列表
- 游玩时点击/触摸判定区击打音符

## 注意
- 本项目仅用于学习交流，版权归原作者所有（Pigeon Games / HanHan233 / lchzh3473）
- 收录曲目为早期版本，不包含Phigros移动端最新章节内容
