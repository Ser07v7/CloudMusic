import { Song, Playlist } from '../model/model'
import { musicRepository } from '../model/MusicRepository'
import { HomeContent } from '../component/HomeContent'
import { DiscoverContent } from '../component/DiscoverContent'
import { LibraryContent } from '../component/LibraryContent'
import { ProfileContent } from '../component/ProfileContent'
import { PlaylistContent } from '../component/PlaylistContent'
import { PlayerContent } from '../component/PlayerContent'
import { BottomNav } from '../component/BottomNav'
import { MiniPlayer } from '../component/MiniPlayer'

// 页面只负责路由和共享状态；具体界面在 component，数据与接口在 model。
@Entry
@Component
struct Index {
  @State currentTab: number = 0
  @State currentSong: Song = musicRepository.getSongs()[0]
  @State playing: boolean = false
  @State likedIds: string[] = []
  @State recentIds: string[] = []
  @State genre: string = '全部'
  @State nickname: string = 'sero77777777'
  @State wallpaper: boolean = true
  @State backgroundLevel: number = 28
  @State detail: Playlist = musicRepository.getPlaylists()[0]
  @State showPlaylist: boolean = false
  @State showPlayer: boolean = false

  private selectSong(song: Song): void {
    this.currentSong = song
    this.playing = true
    this.recentIds = [song.id, ...this.recentIds.filter((id: string) => id !== song.id)]
  }
  private toggleLike(id: string): void {
    this.likedIds = this.likedIds.includes(id) ?
      this.likedIds.filter((value: string) => value !== id) : [...this.likedIds, id]
  }
  private nextSong(): void {
    const songs: Song[] = musicRepository.getSongs()
    const index: number = songs.findIndex((song: Song) => song.id === this.currentSong.id)
    this.selectSong(songs[(index + 1) % songs.length])
  }
  private openDiscover(genre: string): void {
    this.genre = genre
    this.currentTab = 1
    this.showPlaylist = false
    this.showPlayer = false
  }
  private openPlaylist(playlist: Playlist): void {
    this.detail = playlist
    this.showPlaylist = true
    this.showPlayer = false
  }
  private dailyPlaylist(): Playlist {
    return {
      id: 'daily', title: '今天，听点不一样', description: '从温柔旋律到夜晚节拍，为今天挑选的三首歌。',
      cover: $r('app.media.ts'), count: '', songIds: ['s7', 's2', 's6']
    }
  }
  onBackPress(): boolean {
    if (this.showPlayer) { this.showPlayer = false; return true }
    if (this.showPlaylist) { this.showPlaylist = false; return true }
    if (this.currentTab !== 0) { this.currentTab = 0; return true }
    return false
  }

  build() {
    Stack() {
      // 只有背景延伸到系统安全区，内容和底部控制仍在安全区内。
      Column().width('100%').height('100%')
        .backgroundColor(this.currentTab === 3 ? '#221B19' :
          this.currentTab === 1 ? '#201A28' : this.currentTab === 2 ? '#191B28' : '#1D191F')
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
      if (this.wallpaper) {
        Image($r('app.media.Backdrop')).width('100%').height('100%')
          .objectFit(ImageFit.Cover).opacity(this.backgroundLevel / 100)
          .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
      }
      Column() {
        // 中间区域只分配剩余空间，内部独立滚动，绝不挤压底部两栏。
        Stack() {
          if (this.showPlayer) {
            PlayerContent({ song: this.currentSong, playing: this.playing,
              liked: this.likedIds.includes(this.currentSong.id),
              onBack: () => { this.showPlayer = false },
              onToggle: () => { this.playing = !this.playing },
              onNext: () => this.nextSong(), onLike: () => this.toggleLike(this.currentSong.id) })
          } else if (this.showPlaylist) {
            PlaylistContent({ playlist: this.detail, likedIds: this.likedIds, currentId: this.currentSong.id,
              onBack: () => { this.showPlaylist = false }, onPlay: (song: Song) => this.selectSong(song),
              onLike: (id: string) => this.toggleLike(id) })
          } else if (this.currentTab === 0) {
            HomeContent({ likedIds: this.likedIds, currentId: this.currentSong.id,
              onPlay: (song: Song) => this.selectSong(song), onLike: (id: string) => this.toggleLike(id),
              onPlaylist: (playlist: Playlist) => this.openPlaylist(playlist),
              onDiscover: (genre: string) => this.openDiscover(genre),
              onDaily: () => this.openPlaylist(this.dailyPlaylist()) })
          } else if (this.currentTab === 1) {
            DiscoverContent({ genre: $genre, likedIds: this.likedIds, currentId: this.currentSong.id,
              onPlay: (song: Song) => this.selectSong(song), onLike: (id: string) => this.toggleLike(id) })
          } else if (this.currentTab === 2) {
            LibraryContent({ likedIds: this.likedIds, recentIds: this.recentIds, currentId: this.currentSong.id,
              onPlay: (song: Song) => this.selectSong(song), onLike: (id: string) => this.toggleLike(id),
              onDiscover: () => this.openDiscover('全部') })
          } else {
            ProfileContent({ nickname: $nickname, wallpaper: $wallpaper, backgroundLevel: $backgroundLevel,
              likedCount: this.likedIds.length, recentCount: this.recentIds.length,
              onLibrary: () => { this.currentTab = 2 } })
          }
        }.width('100%').layoutWeight(1).clip(true)
        Column() {
          MiniPlayer({ song: this.currentSong, playing: this.playing,
            onToggle: () => { this.playing = !this.playing },
            onNext: () => this.nextSong(), onOpen: () => { this.showPlayer = true } })
          BottomNav({ selected: this.currentTab, onChange: (index: number) => {
            this.currentTab = index
            this.showPlaylist = false
            this.showPlayer = false
          } })
        }.width('100%').height(142).padding({ left: 14, right: 14, top: 8, bottom: 4 })
          .backgroundColor('#4617131C')
      }.width('100%').height('100%')
    }.width('100%').height('100%').backgroundColor('#1D191F')
  }
}

