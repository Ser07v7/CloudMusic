import { Banner, Playlist, Song } from '../model/model'
import { musicRepository } from '../model/MusicRepository'
import { AlbumCard } from './AlbumCard'
import { SongRow } from './SongRow'
import { AppIcon } from './AppIcon'

@Component
export struct HomeContent {
  @State gridWidth: number = 320
  @Prop likedIds: string[] = []
  @Prop currentId: string = ''
  onPlay: (song: Song) => void = () => {}
  onLike: (id: string) => void = () => {}
  onPlaylist: (playlist: Playlist) => void = () => {}
  onDiscover: (genre: string) => void = () => {}
  onDaily: () => void = () => {}
  private banners: Banner[] = musicRepository.getBanners()
  private playlists: Playlist[] = musicRepository.getPlaylists()
  private songs: Song[] = musicRepository.getSongs().slice(6)

  @Builder
  section(title: string, subtitle: string) {
    Row() {
      Text(title).fontSize(19).fontWeight(FontWeight.Bold).fontColor('#F7F5F9').layoutWeight(1)
      Text(subtitle).fontSize(10).fontColor('#B4AAB7')
    }.width('100%').margin({ top: 23, bottom: 14 })
  }

  @Builder
  shortcut(title: string, icon: Resource, action: () => void) {
    Column({ space: 7 }) {
      Button({ type: ButtonType.Circle }) {
        AppIcon({ source: icon, iconSize: 23, color: '#FFD6D9' })
      }.width(44).height(44).backgroundColor('#24F4B7C4')
        .onClick(action).accessibilityText(title)
      Text(title).fontSize(11).fontColor('#D8D3DC')
    }.layoutWeight(1)
  }

  build() {
    Column() {
      Row() {
        Column({ space: 3 }) {
          Text('CLOUD / MUSIC').fontSize(10).fontWeight(FontWeight.Medium)
            .fontColor('#C8ACB4').letterSpacing(2)
          Text('让喜欢，发生').fontSize(23).fontWeight(FontWeight.Bold).fontColor('#FFFFFF')
        }.alignItems(HorizontalAlign.Start).layoutWeight(1)
        Button({ type: ButtonType.Circle }) {
          AppIcon({ source: $r('app.media.ic_search'), iconSize: 22 })
        }.width(40).height(40).backgroundColor('#13FFFFFF')
          .onClick(() => this.onDiscover('全部')).accessibilityText('搜索音乐')
      }.width('100%').padding({ left: 20, right: 20, top: 12, bottom: 18 })
      Scroll() {
        Column() {
          Swiper() {
            ForEach(this.banners, (banner: Banner) => {
              Stack({ alignContent: Alignment.Start }) {
                Row() {
                  Column().layoutWeight(1)
                  Image(banner.cover).width('58%').height('100%').objectFit(ImageFit.Cover)
                }.width('100%').height('100%')
                Row().width('100%').height('100%')
                  .linearGradient({ angle: 90, colors: [[banner.color, 0], [banner.color, 0.28], ['#0025222C', 1]] })
                Column({ space: 9 }) {
                  Text(banner.eyebrow).fontSize(9).fontWeight(FontWeight.Bold).fontColor('#ECD6D6')
                  Text(banner.title).fontSize(25).fontWeight(FontWeight.Bold)
                    .fontColor('#FFFFFF').lineHeight(34)
                  Row({ space: 6 }) {
                    AppIcon({ source: $r('app.media.ic_play'), iconSize: 12 })
                    Text('即刻聆听').fontSize(11).fontColor('#FFFFFF')
                  }.padding({ left: 10, right: 12, top: 6, bottom: 6 })
                    .backgroundColor('#32FFFFFF').borderRadius(16)
                }.alignItems(HorizontalAlign.Start).padding(18)
              }.width('100%').height(192).backgroundColor(banner.color)
                .borderRadius(18).clip(true)
                .onClick(() => {
                  const song: Song | undefined = musicRepository.getSongs().find((item: Song) => item.id === banner.songId)
                  if (song) { this.onPlay(song) }
                })
            }, (banner: Banner) => banner.id)
          }.width('100%').height(206).autoPlay(true).interval(5000).loop(true)
            .indicator(Indicator.dot().itemWidth(5).itemHeight(5)
              .selectedItemWidth(15).selectedItemHeight(5)
              .color('#55FFFFFF').selectedColor('#FF8B95').bottom(0))
          Row() {
            this.shortcut('每日推荐', $r('app.media.ic_calendar'), () => this.onDaily())
            this.shortcut('私人雷达', $r('app.media.ic_radio'), () => this.onDiscover('轻音乐'))
            this.shortcut('说唱现场', $r('app.media.ic_chart'), () => this.onDiscover('说唱'))
            this.shortcut('随心听', $r('app.media.ic_shuffle'), () => {
              const all: Song[] = musicRepository.getSongs()
              this.onPlay(all[Math.floor(Math.random() * all.length)])
            })
          }.width('100%').margin({ top: 16 })
          this.section('精选歌单', '三种心情 · 三段旅程')
          Grid() {
            ForEach(this.playlists, (playlist: Playlist) => {
              GridItem() { AlbumCard({ playlist: playlist, onOpen: this.onPlaylist }) }
            }, (playlist: Playlist) => playlist.id)
          }.columnsTemplate('1fr 1fr 1fr').columnsGap(12)
            .height((this.gridWidth - 24) / 3 + 52)
            .onAreaChange((_oldArea: Area, area: Area) => {
              const width: number = Number(area.width)
              if (width > 0 && width !== this.gridWidth) { this.gridWidth = width }
            })
          this.section('慢下来，听一首', '今日轻音乐 / 03')
          ForEach(this.songs, (song: Song) => {
            SongRow({ song: song, liked: this.likedIds.includes(song.id),
              active: this.currentId === song.id, onSelect: this.onPlay, onLike: this.onLike })
          }, (song: Song) => song.id)
          Text('音乐是生活里，一直亮着的灯。')
            .fontSize(10).fontColor('#817988').margin({ top: 20, bottom: 24 })
        }.width('100%').padding({ left: 20, right: 20 })
      }.layoutWeight(1).scrollBar(BarState.Off).width('100%')
    }.width('100%').height('100%')
  }
}


