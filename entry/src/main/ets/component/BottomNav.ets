import { NavItem } from '../model/model'
import { AppIcon } from './AppIcon'

@Component
export struct BottomNav {
  @Prop selected: number = 0
  onChange: (index: number) => void = () => {}
  private items: NavItem[] = [
    { id: 0, name: '首页', icon: $r('app.media.ic_home') },
    { id: 1, name: '发现', icon: $r('app.media.ic_search') },
    { id: 2, name: '曲库', icon: $r('app.media.ic_library') },
    { id: 3, name: '我的', icon: $r('app.media.ic_user') }
  ]
  build() {
    Row() {
      ForEach(this.items, (item: NavItem) => {
        Button({ type: ButtonType.Normal }) {
          Column({ space: 5 }) {
            AppIcon({ source: item.icon, iconSize: 23,
              color: this.selected === item.id ? '#FF7884' : '#9994A2' })
            Text(item.name).fontSize(11)
              .fontColor(this.selected === item.id ? '#FF7884' : '#9994A2')
              .fontWeight(this.selected === item.id ? FontWeight.Bold : FontWeight.Normal)
          }.width('100%')
        }.layoutWeight(1).height(62).backgroundColor(Color.Transparent)
          .accessibilityText(item.name)
          .onClick(() => this.onChange(item.id))
      }, (item: NavItem) => item.id.toString())
    }.width('100%').height(68).padding({ bottom: 6 })
  }
}


