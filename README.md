# CloudMusic · ArkTS 音乐首页

在 DevEco Studio 打开本目录，预览 `entry/src/main/ets/pages/Index.ets`。

## 文件结构

遵循同目录 wsh1023 的 pages / component / model 分工：

- `pages/Index.ets`：页面入口、四栏切换、当前歌曲、收藏及最近选择等共享状态。
- `model/model.ets`：Song、Playlist、Banner、NavItem 和 MusicRepository 接口。
- `model/MusicRepository.ets`：接口的本地实现；搜索逻辑与示例内容集中维护。
- `component/HomeContent.ets`：首页轮播、快捷入口、Grid 歌单和歌曲列表。
- `component/DiscoverContent.ets`：即时搜索、音乐分类、空结果处理。
- `component/LibraryContent.ets`：收藏列表、最近选择、空状态。
- `component/ProfileContent.ets`：昵称编辑、个人数据、背景开关及明暗调节。
- `component/PlaylistContent.ets`：歌单详情与收录歌曲。
- `component/PlayerContent.ets`：单曲详情及播放状态演示。
- `component/MiniPlayer.ets`、`BottomNav.ets`：独立常驻底部组件。
- `component/AlbumCard.ets`、`SongRow.ets`、`AppIcon.ets`：复用卡片、歌曲行、图片图标。
- `resources/base/media`：本地封面、Backdrop 和 ic_ 前缀的 SVG 图标。

## 布局与功能

入口的内容区通过 layoutWeight(1) 获取剩余空间，底部固定预留 142vp。背景延伸到系统安全区，内容与控件留在安全区内。首页滚动不会挤走播放器或导航。

首页轮播、三列歌单和歌曲列表分别承担专题推荐、歌单浏览和单曲选择；三部分使用九张不同封面。迷你播放器封面跟随当前选择，可能与正在浏览的歌曲一致。

- 首页：三张可滑动轮播，自动轮播间隔 5 秒；每日推荐打开歌单；私人雷达进入轻音乐；说唱现场筛选说唱；随心听随机选择；歌单可打开详情。
- 发现：按歌名或歌手即时过滤，并与流行、说唱、轻音乐分类组合筛选。
- 曲库：点击歌曲爱心可收藏或取消；最近选择按最新操作排序并去重；状态在切换页面时保留。
- 我的：编辑昵称，查看收藏和最近选择数量，切换背景并调整明暗。
- 底部：四个导航按钮使用 media 中的 SVG 图片，有显著选中颜色；播放器可切换状态、切下一首、打开详情。
- 样式：个人页通过 @Styles 封装通用面板；组件使用 @Prop / @Link 和回调共享数据。

## 当前范围

这是可交互的本地界面项目。示例曲目标题、时长及推荐信息用于展示，部分为示例文案，未接入在线音乐服务或音频文件。播放控件只演示状态，不会实际发声；详情页有相应提示。收藏、昵称等当前保存在运行期状态中，重启会恢复默认值。

后续可在 Song 接口增加音源字段，在独立播放服务中接入音频，并将 LocalMusicRepository 换成远程数据实现；页面组件通过已有的数据接口和回调继续使用。若接入异步网络，请将仓储方法调整为 Promise 并在页面生命周期中加载，不要在 build 内发起请求。

## 验证

已完成 DevEco ArkTS 编译和 unsigned HAP 打包。工程没有配置签名；真机运行前需在 DevEco 配置签名。

手动验收建议：在 Phone 预览中打开 Index，滚动首页到底，确认播放栏和导航始终可见；切换四个页面；搜索 Fire；收藏与取消收藏；打开每日推荐和歌单；修改昵称、背景开关和明暗；查看播放器详情并切歌。
