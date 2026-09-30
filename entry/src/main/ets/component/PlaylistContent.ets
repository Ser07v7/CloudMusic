import { Playlist, Song } from '../model/model'
import { musicRepository } from '../model/MusicRepository'
import { AppIcon } from './AppIcon'
import { SongRow } from './SongRow'

@Component
export struct PlaylistContent {
  @Prop playlist: Playlist
  @Prop likedIds: string[] = []
  @Prop currentId: string = ''
  onBack: () => void = () => {}
  onPlay: (song: Song) => void = () => {}
  onLike: (id: string) => void = () => {}

  build() {
    Column({ space: 14 }) {
      Row({ space: 12 }) {
        Button({ type: ButtonType.Circle }) {
          AppIcon({ source: $r('app.media.ic_back') })
        }.width(38).height(38).backgroundColor('#20FFFFFF').onClick(() => this.onBack())
        Text('歌单详情').fontSize(17).fontColor('#FFFFFF')
      }.width('100%')
      Row({ space: 16 }) {
        Image(this.playlist.cover).width(112).height(112).objectFit(ImageFit.Cover)
          .borderRadius(18).clip(true)
        Column({ space: 10 }) {
          Text(this.playlist.title).fontSize(23).fontWeight(FontWeight.Bold).fontColor('#FFFFFF')
          Text(this.playlist.description).fontSize(12).fontColor('#C2B6C7')
          Text(this.playlist.songIds.length + ' 首歌曲').fontSize(11).fontColor('#F1BBCB')
        }.layoutWeight(1).alignItems(HorizontalAlign.Start)
      }.width('100%').margin({ top: 10, bottom: 14 })
      Text('收录歌曲').fontSize(17).fontWeight(FontWeight.Bold).fontColor('#FFFFFF').width('100%')
      List() {
        ForEach(this.playlist.songIds, (id: string) => {
          ListItem() {
            Column() {
              ForEach(musicRepository.getSongs().filter((song: Song) => song.id === id), (song: Song) => {
                SongRow({ song: song, liked: this.likedIds.includes(song.id),
                  active: this.currentId === song.id, onSelect: this.onPlay, onLike: this.onLike })
              }, (song: Song) => song.id)
            }
          }
        }, (id: string) => id)
      }.width('100%').layoutWeight(1).scrollBar(BarState.Off)
    }.width('100%').height('100%').padding({ left: 20, right: 20, top: 16 })
  }
}


