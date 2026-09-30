import { Song } from '../model/model'
import { musicRepository } from '../model/MusicRepository'
import { SongRow } from './SongRow'
import { AppIcon } from './AppIcon'

@Component
export struct LibraryContent {
  @Prop likedIds: string[] = []
  @Prop recentIds: string[] = []
  @Prop currentId: string = ''
  @State selected: number = 0
  onPlay: (song: Song) => void = () => {}
  onLike: (id: string) => void = () => {}
  onDiscover: () => void = () => {}

  private visibleSongs(): Song[] {
    const all: Song[] = musicRepository.getSongs()
    const ids: string[] = this.selected === 0 ? this.likedIds : this.recentIds
    return ids.map((id: string) => all.find((song: Song) => song.id === id))
      .filter((song: Song | undefined) => song !== undefined) as Song[]
  }

  build() {
    Column({ space: 18 }) {
      Text('我的曲库').fontSize(27).fontWeight(FontWeight.Bold).fontColor('#FFFFFF').width('100%')
      Row({ space: 14 }) {
        Stack() {
          AppIcon({ source: $r('app.media.ic_heart_fill'), iconSize: 35, color: '#FFD1DB' })
        }.width(72).height(72).backgroundColor('#66424D').borderRadius(20)
        Column({ space: 7 }) {
          Text('把喜欢留在这里').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#FFFFFF')
          Text(this.likedIds.length + ' 首收藏 · ' + this.recentIds.length + ' 首最近选择')
            .fontSize(12).fontColor('#CEC0D1')
        }.alignItems(HorizontalAlign.Start)
      }.width('100%').padding(16).backgroundColor('#3541394B').borderRadius(20)
      Row({ space: 12 }) {
        Button('我喜欢 · ' + this.likedIds.length).fontSize(12)
          .backgroundColor(this.selected === 0 ? '#EBC5D0' : '#20FFFFFF')
          .fontColor(this.selected === 0 ? '#312331' : '#C7BDCD')
          .onClick(() => { this.selected = 0 })
        Button('最近选择').fontSize(12)
          .backgroundColor(this.selected === 1 ? '#EBC5D0' : '#20FFFFFF')
          .fontColor(this.selected === 1 ? '#312331' : '#C7BDCD')
          .onClick(() => { this.selected = 1 })
      }.width('100%')
      if (this.visibleSongs().length === 0) {
        Column({ space: 12 }) {
          Text(this.selected === 0 ? '还没有收藏歌曲' : '还没有选择歌曲')
            .fontSize(17).fontColor('#E6DEE9')
          Text('遇到喜欢的旋律，点一下爱心').fontSize(12).fontColor('#AC9DB6')
          Button('去发现音乐').fontSize(13).backgroundColor('#795263')
            .onClick(() => this.onDiscover())
        }.layoutWeight(1).width('100%').justifyContent(FlexAlign.Center)
      } else {
        List() {
          ForEach(this.visibleSongs(), (song: Song) => {
            ListItem() {
              SongRow({ song: song, liked: this.likedIds.includes(song.id),
                active: this.currentId === song.id, onSelect: this.onPlay, onLike: this.onLike })
            }
          }, (song: Song) => song.id)
        }.layoutWeight(1).width('100%').scrollBar(BarState.Off)
      }
    }.width('100%').height('100%').padding({ left: 20, right: 20, top: 22 })
  }
}


